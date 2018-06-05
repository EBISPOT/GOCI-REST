/*

################################################################################

Migration script to create EVENT_TYPE table

author: Cinzia Malangone
date:    11th Nov 2016
version: 2.2.0.008
Note: the EventType was an hard coded enum class.
################################################################################
*/

--------------------------------------------------------
--  CREATE TABLE and ID
--------------------------------------------------------
CREATE TABLE "EVENT_TYPE" (
   "ID" NUMBER(19,0),
   "ACTION" VARCHAR2(255 CHAR) NOT NULL,
   "EVENT_TYPE" VARCHAR2(255 CHAR) NOT NULL,
    "TRANSLATED_EVENT" VARCHAR2(255 CHAR) NOT NULL
);

ALTER TABLE "EVENT_TYPE" ADD PRIMARY KEY ("ID") ENABLE;

CREATE SEQUENCE EVENT_TYPE_SEQ
  START WITH 1
  INCREMENT BY 1
  CACHE 1000;

INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Study Creation','STUDY_CREATION','Study created');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Level 1 ancestry done','STUDY_STATUS_CHANGE_LEVEL_1_ANCESTRY_DONE','Study status changed to level 1 ancestry done');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Level 2 ancestry done','STUDY_STATUS_CHANGE_LEVEL_2_ANCESTRY_DONE','Study status changed to level 2 ancestry done');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Level 1 curation done','STUDY_STATUS_CHANGE_LEVEL_1_CURATION_DONE','Study status changed to level 1 curation done');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Level 2 curation done','STUDY_STATUS_CHANGE_LEVEL_2_CURATION_DONE','Study status changed to level 2 curation done');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Level 3 curation done','STUDY_STATUS_CHANGE_LEVEL_3_CURATION_DONE','Study status changed to level 3 curation done');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Publish study','STUDY_STATUS_CHANGE_PUBLISH_STUDY','Study status changed to publish study');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Awaiting Curation','STUDY_STATUS_CHANGE_AWAITING_CURATION','Study status changed to awaiting curation');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Outstanding Query','STUDY_STATUS_CHANGE_OUTSTANDING_QUERY','Study status changed to outstanding query');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'CNV Paper','STUDY_STATUS_CHANGE_CNV_PAPER','Study status changed to cnv paper');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Curation Abandoned','STUDY_STATUS_CHANGE_CURATION_ABANDONED','Study status changed to curation abandoned');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Conversion Problem','STUDY_STATUS_CHANGE_CONVERSION_PROBLEM','Study status changed to conversion problem');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Publish study','STUDY_STATUS_CHANGE_UNPUBLISHED_FROM_CATALOG','Study status changed to unpublished from catalog');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Pending author query','STUDY_STATUS_CHANGE_PENDING_AUTHOR_QUERY','Study status changed to pending author query');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Awaiting EFO assignment','STUDY_STATUS_CHANGE_AWAITING_EFO_ASSIGNMENT','Study status changed to awaiting efo assignment');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Study Unknown','STUDY_STATUS_CHANGE_UNKNOWN','Study status changed to unknown');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Morales','STUDY_CURATOR_ASSIGNMENT_MORALES','Study curator set to Morales');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'MacArthur','STUDY_CURATOR_ASSIGNMENT_MACARTHUR','Study curator set to MacArthur');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Hindorff','STUDY_CURATOR_ASSIGNMENT_HINDORFF','Study curator set to  Hindorff');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Junkins','STUDY_CURATOR_ASSIGNMENT_JUNKINS','Study curator set to Junkins');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Hall','STUDY_CURATOR_ASSIGNMENT_HALL','Study curator set to Hall');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Welter','STUDY_CURATOR_ASSIGNMENT_WELTER','Study curator set to Welter');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Unassigned','STUDY_CURATOR_ASSIGNMENT_UNASSIGNED','Study curator set to Unassigned');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'GWAS Catalog','STUDY_CURATOR_ASSIGNMENT_GWAS_CATALOG','Study curator set to Gwas Catalog');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Level 3 Curator','STUDY_CURATOR_ASSIGNMENT_LEVEL_3_CURATOR','Study curator set to level 3 curator');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Level 2 Curator','STUDY_CURATOR_ASSIGNMENT_LEVEL_2_CURATOR','Study curator set to level 2 curator');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Level 1 Curator','STUDY_CURATOR_ASSIGNMENT_LEVEL_1_CURATOR','Study curator set to level 1 curator');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Level 1 Ethnicity Curator','STUDY_CURATOR_ASSIGNMENT_LEVEL_1_ETHNICITY_CURATOR','Study curator set to level 1 ethnicity curator');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Cerezo','STUDY_CURATOR_ASSIGNMENT_CEREZO','Study curator set to Cerezo');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Milano','STUDY_CURATOR_ASSIGNMENT_MILANO','Study curator set to Milano');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'McMahon','STUDY_CURATOR_ASSIGNMENT_MCMAHON','Study curator set to McMahon');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Malangone','STUDY_CURATOR_ASSIGNMENT_MALANGONE','Study curator set to Malangone');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Pendlington','STUDY_CURATOR_ASSIGNMENT_PENDLINGTON','Study curator set to Pendlington');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Ginoza','STUDY_CURATOR_ASSIGNMENT_GINOZA','Study curator set to Ginoza');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Curator Unknown','STUDY_CURATOR_ASSIGNMENT_UNKNOWN','Study curator assignment unknown');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Study File Upload','STUDY_FILE_UPLOAD','File uploaded');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Study Update','STUDY_UPDATE','Study updated');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Study Deletion','STUDY_DELETION','Study deleted');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Study Duplication','STUDY_DUPLICATION','Study duplicated');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Study Sample Description Update','STUDY_SAMPLE_DESCRIPTION_UPDATE','Study initial/replication description updated');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Association Creation','ASSOCIATION_CREATION','Association created');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Association Update','ASSOCIATION_UPDATE','Association updated');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Association Mapping','ASSOCIATION_MAPPING','Association mapped');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Association Approved','ASSOCIATION_APPROVED','Association approved');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Association Unapproved','ASSOCIATION_UNAPPROVED','Association unapproved');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Association Deletion','ASSOCIATION_DELETION','Association deleted');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Association Batch Upload','ASSOCIATION_BATCH_UPLOAD','SNP association batch upload');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Association Batch Delete','ASSOCIATION_BATCH_DELETE','SNP association batch deletion');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Ethnicity Created','ETHNICITY_CREATED','Ethnicity created');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Ethnicity Updated','ETHNICITY_UPDATED','Ethnicity updated');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Ethnicity Deleted','ETHNICITY_DELETED','Ethnicity deleted');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Chhibba','STUDY_CURATOR_ASSIGNMENT_CHHIBBA','Study curator set to Chhibba');
INSERT INTO "EVENT_TYPE"(ID,ACTION,EVENT_TYPE,TRANSLATED_EVENT) VALUES (EVENT_TYPE_SEQ.nextval,'Bowler','STUDY_CURATOR_ASSIGNMENT_BOWLER','Study curator set to Bowler');
