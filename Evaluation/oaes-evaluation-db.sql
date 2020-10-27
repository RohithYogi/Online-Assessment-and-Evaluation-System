DROP DATABASE oaes_evaluation_db;
CREATE DATABASE oaes_evaluation_db;
USE oaes_evaluation_db;
--
-- Database: `oaes_evaluation_db`
--

-- --------------------------------------------------------
-- Table structure for table `ev_question_paper`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_question_paper(
  qp_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  qp_code varchar(255) UNIQUE NOT NULL,
  maximum_marks float(24) NOT NULL DEFAULT 100,
  duration int(10) NOT NULL DEFAULT 180,
  PRIMARY KEY(qp_id)
);

INSERT INTO ev_question_paper VALUES(0,"MAT_1",100,180);
INSERT INTO ev_question_paper VALUES(0,"PHY_1",50,120);
INSERT INTO ev_question_paper VALUES(0,"CHEM_1",25,60);
-- --------------------------------------------------------
-- Table structure for table `ev_itemtype_master`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_itemtype_master (
  itemtype_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  itemtype_code varchar(255) UNIQUE NOT NULL,
  itemtype_name varchar(255) NOT NULL,
  itemtype_category ENUM('AUTO','MANUAL') DEFAULT 'MANUAL',
  PRIMARY KEY (itemtype_id)
);

-- --------------------------------------------------------
-- Table structure for table `ev_qp_item`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_qp_item (
  qp_item_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  item_code varchar(255) UNIQUE NOT NULL,
  item_text varchar(511) NOT NULL,
  item_marks float(24) unsigned NOT NULL,
  item_type varchar(255) NOT NULL,
  qp_id int(10) unsigned,
  PRIMARY KEY (qp_item_id)
);

ALTER TABLE ev_qp_item
  ADD CONSTRAINT `fk_ev_qp_item_qp_id` FOREIGN KEY (qp_id) REFERENCES ev_question_paper(qp_id) ON DELETE SET NULL;

INSERT INTO ev_qp_item VALUES(0,"Item1_qp1","What is a database?",2,"McqSingleCorrect",1);
INSERT INTO ev_qp_item VALUES(0,"Item2_qp1","What is a  PK?",1,"McqMultiCorrect",1);
INSERT INTO ev_qp_item VALUES(0,"Item3_qp1","What is a FK?",2,"McqMultiCorrect",1);
INSERT INTO ev_qp_item VALUES(0,"Item4_qp1","UK and PK are same.",1,"True/False",1);
INSERT INTO ev_qp_item VALUES(0,"Item5_qp1","Uk with no null values is Pk.",2,"True/False",1);
INSERT INTO ev_qp_item VALUES(0,"Item1_qp2","What is a database?",2,"McqSingleCorrect",2);
INSERT INTO ev_qp_item VALUES(0,"Item2_qp2","What is a  PK?",1,"McqSingleCorrect",2);
INSERT INTO ev_qp_item VALUES(0,"Item3_qp2","What is a FK?",2,"McqMultiCorrect",2);
INSERT INTO ev_qp_item VALUES(0,"Item4_qp2","UK and PK are same.",1,"True/False",2);
INSERT INTO ev_qp_item VALUES(0,"Item5_qp2","Uk with no null values is Pk.",2,"True/False",2);

-- --------------------------------------------------------
-- Table structure for table `ev_item_mcq_options`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_item_mcq_options(
  item_mcq_id  int(10) unsigned NOT NULL AUTO_INCREMENT,
  item_mcq_options_code varchar(255) UNIQUE NOT NULL,
  qp_item_id int(10) unsigned,
  mcq_option_text varchar(255) NOT NULL,
  mcq_option_percentage float(24) DEFAULT 0.0,
  PRIMARY KEY(item_mcq_id)
);

ALTER TABLE ev_item_mcq_options
  ADD CONSTRAINT `fk_ev_item_mcq_options_qp_item_id` FOREIGN KEY (qp_item_id) REFERENCES ev_qp_item(qp_item_id) ON DELETE SET NULL;

INSERT INTO ev_item_mcq_options VALUES(0,"Mcq1_item1_qp1",1,"Collection of related data",100.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq2_item1_qp1",1,"Collection of data",0.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq3_item1_qp1",1,"Collection of words",0.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq4_item1_qp1",1,"Collection of people",0.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq1_item2_qp1",2,"Primary Key",50.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq2_item2_qp1",2,"Personal Key",0.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq3_item2_qp1",2,"Person Key",0.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq4_item2_qp1",2,"Primary Keyword",50.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq1_item3_qp1",3,"Foreign Key",50.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq2_item3_qp1",3,"Foreign Keyword",50.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq3_item3_qp1",3,"Fashion Key",0.0);
INSERT INTO ev_item_mcq_options VALUES(0,"Mcq4_item3_qp1",3,"Forward Key",0.0);

-- --------------------------------------------------------
-- Table structure for table `ev_item_true_false`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_item_true_false(
  item_true_false_id  int(10) unsigned NOT NULL AUTO_INCREMENT,
  item_true_false_code varchar(255) UNIQUE NOT NULL,
  qp_item_id int(10) unsigned,
  true_percentage float(24) DEFAULT 0.0,
  false_percentage  float(24) DEFAULT 0.0,
  PRIMARY KEY(item_true_false_id)
);

ALTER TABLE ev_item_true_false
  ADD CONSTRAINT `fk_ev_item_true_false_qp_item_id` FOREIGN KEY (qp_item_id) REFERENCES ev_qp_item(qp_item_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `ev_examinee_batch`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_examinee_batch(
  examinee_batch_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  status ENUM('PENDING','COMPLETED','ABANDONED') DEFAULT 'PENDING',
  PRIMARY KEY(examinee_batch_id)
);

INSERT INTO ev_examinee_batch VALUES(0,'COMPLETED');
INSERT INTO ev_examinee_batch VALUES(0,'PENDING');
INSERT INTO ev_examinee_batch VALUES(0,'PENDING');
INSERT INTO ev_examinee_batch VALUES(0,'PENDING');
INSERT INTO ev_examinee_batch VALUES(0,'ABANDONED');
INSERT INTO ev_examinee_batch VALUES(0,'COMPLETED');
INSERT INTO ev_examinee_batch VALUES(0,'PENDING');
INSERT INTO ev_examinee_batch VALUES(0,'ABANDONED');

-- --------------------------------------------------------
-- Table structure for table ev_examinee_item_marks
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_examinee_item_marks(
	examinee_item_marks_id int(10) unsigned NOT NULL AUTO_INCREMENT,
	examinee_item_marks float(24) NOT NULL,
	examinee_batch_id int(10) unsigned,
	qp_item_id int(10) unsigned,
	PRIMARY KEY (examinee_item_marks_id)
);

ALTER TABLE ev_examinee_item_marks
  ADD CONSTRAINT `fk_ev_examinee_item_marks_examinee_batch_id` FOREIGN KEY (examinee_batch_id) REFERENCES ev_examinee_batch(examinee_batch_id) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ev_examinee_item_marks_qp_item_id` FOREIGN KEY (qp_item_id) REFERENCES ev_qp_item(qp_item_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `ev_response`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_response (
  response_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  response_code varchar(255) UNIQUE NOT NULL,
  qp_item_id int(10) unsigned,
  PRIMARY KEY (response_id)
);

ALTER TABLE ev_response
  ADD CONSTRAINT `fk_ev_response_qp_item_id` FOREIGN KEY (qp_item_id) REFERENCES ev_qp_item(qp_item_id) ON DELETE SET NULL;

INSERT INTO ev_response VALUES(0,"Item1_qp1",1);
INSERT INTO ev_response VALUES(0,"Item2_qp1",2);
INSERT INTO ev_response VALUES(0,"Item3_qp1",3);
 
-- --------------------------------------------------------
-- Table structure for table `ev_response_mcq`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_response_mcq (
  response_mcq_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  response_mcq_code varchar(255) UNIQUE NOT NULL,
  response_text varchar(511) NOT NULL,
  response_id int(10) unsigned,
  PRIMARY KEY (response_mcq_id)
);

ALTER TABLE ev_response_mcq
  ADD CONSTRAINT `fk_ev_response_mcq_response_id` FOREIGN KEY (response_id) REFERENCES ev_response(response_id) ON DELETE SET NULL;

INSERT INTO ev_response_mcq VALUES(0,"Mcq1_item1_qp1","Collection of related data",1);
INSERT INTO ev_response_mcq VALUES(0,"Mcq1_item2_qp1","Primary Key",2);
INSERT INTO ev_response_mcq VALUES(0,"Mcq4_item2_qp1","Primary Keyword",2);
INSERT INTO ev_response_mcq VALUES(0,"Mcq1_item3_qp1","Foreign Key",3);
INSERT INTO ev_response_mcq VALUES(0,"Mcq3_item3_qp1","Fashion Key",3);

-- --------------------------------------------------------
-- Table structure for table `ev_response_true_false`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ev_response_true_false (
  response_true_false_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  response_true_false_code varchar(255) UNIQUE NOT NULL,
  response_id int(10) unsigned,
  PRIMARY KEY (response_true_false_id)
);

ALTER TABLE ev_response_true_false
  ADD CONSTRAINT `fk_ev_response_true_false_response_id` FOREIGN KEY (response_id) REFERENCES ev_response(response_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table in_apack_header
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS in_apack_header(
  apack_header_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  apack_desc varchar(255),
  created_on datetime,
  created_by varchar(255),
  apack_status ENUM('CREATED', 'SENT'),
  apack_sent_on datetime,
  apack_path varchar(255),
  PRIMARY KEY(apack_header_id)
);

-- --------------------------------------------------------
-- Table structure for table apack1
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS apack1(
  apack_header_id int(10) unsigned NOT NULL,
  qp_id int(10) unsigned NOT NULL,
  qp_code varchar(255) NOT NULL,
  item_id int(10) unsigned UNIQUE NOT NULL,
  item_text varchar(255) NOT NULL,
  item_marks float(24) unsigned NOT NULL,
  item_type varchar(255) NOT NULL,
  PRIMARY KEY(apack_header_id)
);

ALTER TABLE apack1
  ADD CONSTRAINT `fk_apack1_apack_header_id` FOREIGN KEY (apack_header_id) REFERENCES in_apack_header(apack_header_id) ON DELETE CASCADE;

-- --------------------------------------------------------
-- Table structure for table apack2
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS apack2(
  apack_id int(10) unsigned NOT NULL,
  item_id int(10) unsigned NOT NULL,
  option_text varchar(255) NOT NULL,
  option_percentage float(24),
  PRIMARY KEY(apack_id)
);

ALTER TABLE apack2
  ADD CONSTRAINT `fk_apack2_item_id` FOREIGN KEY (item_id) REFERENCES apack1(item_id) ON DELETE CASCADE;

-- --------------------------------------------------------
-- Table structure for table out_mpack_header
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS out_mpack_header(
  mpack_header_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  mpack_desc varchar(255),
  created_on datetime,
  created_by varchar(255),
  mpack_status ENUM('CREATED', 'SENT'),
  mpack_sent_on datetime,
  mpack_path varchar(255),
  PRIMARY KEY(mpack_header_id)
);

-- --------------------------------------------------------
-- Table structure for table mpack1
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS mpack1(
  mpack_header_id int(10) unsigned NOT NULL,
  qp_id int(10) unsigned UNIQUE NOT NULL,
  qp_code varchar(255) UNIQUE NOT NULL,
  maximum_marks float(24) NOT NULL,
  marks_obtained float(24) NOT NULL,
  duration int(10) NOT NULL,
  PRIMARY KEY(mpack_header_id)
);

ALTER TABLE mpack1
  ADD CONSTRAINT `fk_mpack1_mpack_header_id` FOREIGN KEY (mpack_header_id) REFERENCES out_mpack_header(mpack_header_id) ON DELETE CASCADE;

-- --------------------------------------------------------
-- Table structure for table mpack2
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS mpack2(
  mpack_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  qp_id int(10) unsigned NOT NULL,
  item_id int(10) unsigned UNIQUE NOT NULL,
  item_text varchar(255) NOT NULL,
  item_marks float(24) unsigned NOT NULL,
  item_type varchar(255) NOT NULL,
  cognitive_level ENUM('REMEMBER', 'UNDERSTAND', 'APPLY', 'ANALYZE', 'EVALUATE', 'CREATE'),
  PRIMARY KEY(mpack_id)
);

ALTER TABLE mpack2
  ADD CONSTRAINT `fk_mpack2_qp_id` FOREIGN KEY (qp_id) REFERENCES mpack1(qp_id) ON DELETE CASCADE;

-- --------------------------------------------------------
-- Table structure for table mpack3
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS mpack3(
  mpack_id int(10) unsigned NOT NULL,
  qp_id int(10) unsigned NOT NULL,
  examinee_batch_id int(10) unsigned NOT NULL,
  item_id int(10) unsigned UNIQUE NOT NULL,
  item_marks_obtained float(24) unsigned NOT NULL,
  PRIMARY KEY(mpack_id)
);

ALTER TABLE mpack3
  ADD CONSTRAINT `fk_mpack3_qp_id` FOREIGN KEY (qp_id) REFERENCES mpack1(qp_id) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_mpack3_mpack_id` FOREIGN KEY (mpack_id) REFERENCES mpack2(mpack_id) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_mpack3_item_id` FOREIGN KEY (item_id) REFERENCES mpack2(item_id) ON DELETE CASCADE;

-- --------------------------------------------------------
-- Table structure for table in_rpack_header
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS in_rpack_header(
  rpack_header_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  rpack_desc varchar(255),
  created_on datetime,
  created_by varchar(255),
  rpack_status ENUM('CREATED', 'SENT'),
  rpack_sent_on datetime,
  rpack_path varchar(255),
  PRIMARY KEY(rpack_header_id)
);

-- --------------------------------------------------------
-- Table structure for table rpack1
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS rpack1(
  rpack_header_id int(10) unsigned NOT NULL,
  qp_id int(10) unsigned UNIQUE NOT NULL,
  qp_code varchar(255) UNIQUE NOT NULL,
  maximum_marks float(24) NOT NULL,
  duration int(10) NOT NULL,
  batch_id int(10) unsigned UNIQUE NOT NULL,
  PRIMARY KEY(rpack_header_id)
);

ALTER TABLE rpack1
  ADD CONSTRAINT `fk_rpack1_rpack_header_id` FOREIGN KEY (rpack_header_id) REFERENCES in_rpack_header(rpack_header_id) ON DELETE CASCADE;

-- --------------------------------------------------------
-- Table structure for table rpack2
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS rpack2(
  rpack_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  qp_id int(10) unsigned NOT NULL,
  item_id int(10) unsigned UNIQUE NOT NULL,
  item_text varchar(255) NOT NULL,
  item_marks float(24) unsigned NOT NULL,
  item_type varchar(255) NOT NULL,
  cognitive_level ENUM('REMEMBER', 'UNDERSTAND', 'APPLY', 'ANALYZE', 'EVALUATE', 'CREATE'),
  PRIMARY KEY(rpack_id)
);

ALTER TABLE rpack2
  ADD CONSTRAINT `fk_rpack2_qp_id` FOREIGN KEY (qp_id) REFERENCES rpack1(qp_id) ON DELETE CASCADE;

-- --------------------------------------------------------
-- Table structure for table epack3
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS rpack3(
  rpack_id int(10) unsigned NOT NULL,
  item_id int(10) unsigned NOT NULL,
  option_text varchar(255) NOT NULL,
  PRIMARY KEY(rpack_id)
);

ALTER TABLE rpack3
  ADD CONSTRAINT `fk_rpack3_rpack_id` FOREIGN KEY (rpack_id) REFERENCES rpack2(rpack_id) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rpack3_item_id` FOREIGN KEY (item_id) REFERENCES rpack2(item_id) ON DELETE CASCADE;

-- --------------------------------------------------------
-- Table structure for table rpack4
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS rpack4(
  rpack_id int(10) unsigned NOT NULL,
  qp_id int(10) unsigned NOT NULL,
  batch_id int(10) unsigned NOT NULL,
  examinee_batch_id int(10) unsigned NOT NULL,
  examinee_id int(10) unsigned NOT NULL,
  item_id int(10) unsigned NOT NULL,
  response_id int(10) unsigned NOT NULL,
  response_text varchar(511) NOT NULL,
  PRIMARY KEY(rpack_id)
);

ALTER TABLE rpack4
  ADD CONSTRAINT `fk_rpack4_qp_id` FOREIGN KEY (qp_id) REFERENCES rpack1(qp_id) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rpack4_batch_id` FOREIGN KEY (batch_id) REFERENCES rpack1(batch_id) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rpack4_item_id` FOREIGN KEY (item_id) REFERENCES rpack2(item_id) ON DELETE CASCADE;