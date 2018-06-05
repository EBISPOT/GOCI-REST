package uk.ac.ebi.spot.goci.model.projection;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.rest.core.config.Projection;
import uk.ac.ebi.spot.goci.model.Ancestry;
import uk.ac.ebi.spot.goci.model.DiseaseTrait;
import uk.ac.ebi.spot.goci.model.EfoTrait;
import uk.ac.ebi.spot.goci.model.GenotypingTechnology;
import uk.ac.ebi.spot.goci.model.Platform;
import uk.ac.ebi.spot.goci.model.Study;

import java.util.Collection;
import java.util.Date;

/**
 * Created by dwelter on 18/08/17.
 */

@Projection(name = "study", types = {Study.class})//, Ancestry.class, AncestralGroup.class})
public interface StudyProjection {

    String getAuthor();

    Date getPublicationDate();

    String getPublication() ;

    String getTitle() ;

    String getInitialSampleSize();

    @JsonProperty("replicationSampleSize")
    String getReplicateSampleSize();

    String getPubmedId() ;

    Boolean getGxe() ;

    Boolean getGxg() ;

    Integer getSnpCount();

    String getQualifier() ;

    boolean getImputed() ;

    boolean getPooled() ;

    String getStudyDesignComment() ;

    String getAccessionId() ;

    Boolean getFullPvalueSet() ;

    Boolean getUserRequested() ;

    Collection<Ancestry> getAncestries();

    DiseaseTrait getDiseaseTrait() ;

    Collection<EfoTrait> getEfoTraits();

    Collection<Platform> getPlatforms() ;

    Collection<GenotypingTechnology> getGenotypingTechnologies();

}