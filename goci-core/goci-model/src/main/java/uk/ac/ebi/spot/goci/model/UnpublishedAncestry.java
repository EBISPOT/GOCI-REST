package uk.ac.ebi.spot.goci.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonIgnoreProperties(ignoreUnknown = true)
@Entity
public class UnpublishedAncestry {
    @Id
    @GeneratedValue
    @JsonIgnore
    private Long id;

    @JsonProperty("study_tag")
    private String studyTag;
    private String stage;
    @JsonProperty("sample_size")
    private Integer sampleSize;
    private Integer cases;
    private Integer controls;
    @JsonProperty("sample_description")
    private String sampleDescription;
    @JsonProperty("ancestry_category")
    private String ancestryCategory;
    private String ancestry;
    @JsonProperty("ancestry_description")
    private String ancestryDescription;
    @JsonProperty("country_recruitment")
    private String countryRecruitment;

    @OneToOne
    @JsonBackReference
    private UnpublishedStudy study;
}