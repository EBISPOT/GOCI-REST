package uk.ac.ebi.spot.goci.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import uk.ac.ebi.spot.goci.layout.ColourMapper;
import uk.ac.ebi.spot.goci.model.EfoColourMap;


import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by dwelter on 03/02/17.
 */

@RestController
public class ParentMappingController {

    @Value("${ols.server}")
    private String olsServer;

    @Value("${ols.efo.terms}")
    private String olsEfoTerms;

    @Value("${ols.shortForm}")
    private String olsShortForm;

    @Value("${ols.fullIri}")
    private String olsFullIri;

    @Autowired
    ObjectMapper mapper;

    private Logger log = LoggerFactory.getLogger(getClass());

    protected Logger getLog() {
        return log;
    }


    @CrossOrigin
    @RequestMapping(value = "/api/parentMapping/{efoTerm}",
                    method = RequestMethod.GET,
                    produces = MediaType.APPLICATION_JSON_VALUE)
    public HttpEntity getColourMapping(@PathVariable String efoTerm, HttpServletResponse response) throws IOException {

        Map<String, String> ancestors = getAncestors(efoTerm);

        if(ancestors.get("message") == null) {

            EfoColourMap colour =
                    getTraitColour(ancestors.get("ancestors"), ancestors.get("iri"), ancestors.get("label"));
            return new ResponseEntity<EfoColourMap>(colour, HttpStatus.OK);

        }
        else {
            return new ResponseEntity<EfoColourMap>(new EfoColourMap(ancestors.get("iri"),  null, null, null, null, null, ancestors.get("message")), HttpStatus.OK);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/api/parentMappings",
                    method = RequestMethod.POST,
                    consumes = "application/json",
                    produces = MediaType.APPLICATION_JSON_VALUE)
    public HttpEntity<List<EfoColourMap>> getColourMappings(@RequestBody List<String> efoTerms)
            throws IOException, InterruptedException {
        List<EfoColourMap> colours = new ArrayList<>();

        ExecutorService taskExecutor = Executors.newFixedThreadPool(3);
        CountDownLatch latch = new CountDownLatch(efoTerms.size());
        for(String efoTerm : efoTerms) {
            taskExecutor.execute(new EfoThread(efoTerm, colours, latch));
        }
        latch.await();

        return new ResponseEntity<List<EfoColourMap>>(colours, HttpStatus.OK);
    }

    public Map<String, String> getAncestors(String efoTerm)  throws IOException{
        Map<String, String> result = new HashMap<>();
        String uri = olsServer.concat(olsEfoTerms);


        if(efoTerm.contains("http")){
            uri = uri.concat(olsFullIri).concat(efoTerm);
        }
        else {
           uri = uri.concat(olsShortForm).concat(efoTerm);
        }
        
        RestTemplate restTemplate = new RestTemplate();
        String efoObject = null;
        try{
           ResponseEntity<String> response = restTemplate.getForEntity(uri, String.class);
           efoObject  = response.getBody();
            //System.out.println(efoObject);
        }
        catch (HttpClientErrorException ex){
             result.put("message", "Term ".concat(efoTerm).concat(" not found in EFO"));
            result.put("iri", efoTerm);
        }catch(Exception e){
            e.printStackTrace();
        }



        if(efoObject != null){
            JsonNode node = mapper.readTree(efoObject);
            JsonNode responseNode = node.get("_embedded").get("terms").get(0);

            String ancestorsObject = null;

            if(responseNode.get("is_root").asText().trim().equals("false")){
                String ancestors_link = responseNode.get("_links").get("hierarchicalAncestors").get("href").asText().trim();
                ancestors_link = java.net.URLDecoder.decode(ancestors_link, "UTF-8");
                ancestorsObject = restTemplate.getForObject(ancestors_link, String.class);

            }
            String label = responseNode.get("label").asText().trim();
            String iri = responseNode.get("iri").asText().trim();


            result.put("iri", iri);
            result.put("label", label);
            result.put("ancestors", ancestorsObject);
        }
        return result;
    }

    protected EfoColourMap getTraitColour(String ancestors, String uri, String trait) throws IOException {
        List<String> multiple = new ArrayList<>();
        Map<String, String> allTypes = new HashMap<>();

        if(ancestors != null) {
            allTypes = processAncestors(ancestors);

            Set<String> available = ColourMapper.COLOUR_MAP.keySet();

            if(available.contains(uri)){
                multiple.add(uri);
            }

            for (String type : allTypes.keySet()) {
                if (type != null) {
                    if (available.contains(type)) {
                        multiple.add(type);
                    }
                }
            }
        }

        if(multiple.size() == 0){
            // if we got to here, no color available
            getLog().error("Could not identify a suitable colour category for trait " + trait);
            return new EfoColourMap(uri, trait, ColourMapper.OTHER, "experimental factor", ColourMapper.COLOUR_MAP.get(ColourMapper.OTHER), ColourMapper.LABEL_MAP.get(ColourMapper.OTHER), null);
        }
        else if (multiple.size() == 1){
            return new EfoColourMap(uri, trait, multiple.get(0), allTypes.get(multiple.get(0)), ColourMapper.COLOUR_MAP.get(multiple.get(0)), ColourMapper.LABEL_MAP.get(multiple.get(0)), null);
        }
        else{
            getLog().debug("More than one parent for trait " + trait);
            int size = 0;
            String current = null;
            for(String term : multiple){
                String ancs = getAncestors(term).get("ancestors");
                int count = processAncestors(ancs).keySet().size();

                if(count > size){
                    size = count;
                    current = term;
                }
            }
            //allow for cases where the queried term is a parent class - we don't want to return the next highest parent
            // (eg for neoplasm, return neoplasm rather than disease)
            if(uri.equals(current)){
                return new EfoColourMap(uri,
                                        trait,
                                        current,
                                        trait,
                                        ColourMapper.COLOUR_MAP.get(current),
                                        ColourMapper.LABEL_MAP.get(current),
                                        null);
            }
            else {
                return new EfoColourMap(uri,
                                        trait,
                                        current,
                                        allTypes.get(current),
                                        ColourMapper.COLOUR_MAP.get(current),
                                        ColourMapper.LABEL_MAP.get(current),
                                        null);
            }
        }
    }

    private Map<String, String> processAncestors(String ancestors) throws IOException {
        Map<String, String> allAncestors = new HashMap();

        if(ancestors != null){
            JsonNode node = mapper.readTree(ancestors);

            JsonNode terms = node.get("_embedded").get("terms");

            for(JsonNode term : terms){
                String iri = term.get("iri").asText().trim();
                String name = term.get("label").asText().trim();

                if(allAncestors.get(iri) == null) {
                    allAncestors.put(iri, name);
                }
            }
        }

        return allAncestors;
    }

    private class EfoThread extends Thread{
        private final String efoTerm;
        private final CountDownLatch latch;
        private List<EfoColourMap> colours;

        public EfoThread(String efoTerm, List<EfoColourMap> colours, CountDownLatch latch){
            this.efoTerm = efoTerm;
            this.colours = colours;
            this.latch = latch;
        }
        @Override
        public void run() {
            Map<String, String> ancestors = null;
            try {
                ancestors = getAncestors(efoTerm);
                if(ancestors.get("message") == null) {
                    colours.add(getTraitColour(ancestors.get("ancestors"), ancestors.get("iri"), ancestors.get("label")));
                }
                else {
                    colours.add(new EfoColourMap(ancestors.get("iri"),  null, null, null, null, null, ancestors.get("message")));
                }
            } catch (IOException e) {
                e.printStackTrace();
            }finally{
                latch.countDown();
            }
        }
    }
}
