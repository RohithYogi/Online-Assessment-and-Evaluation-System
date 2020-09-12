DROP DATABASE oaes_assessment_db;
CREATE DATABASE oaes_assessment_db;
USE oaes_assessment_db;
--
-- Database: `oaes_assessment_db`
--

-- --------------------------------------------------------
-- Table structure for table as_examdrive
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_examdrive(
  examdrive_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  examdrive_code varchar(255) UNIQUE NOT NULL,
  examdrive_name varchar(255) NOT NULL,
  status ENUM('NOT_STARTED','IN_PROGRESS','COMPLETED') DEFAULT 'NOT_STARTED',
  PRIMARY KEY (examdrive_id)
);

-- --------------------------------------------------------
-- Table structure for table as_examinee
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_examinee(
  examinee_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  examinee_code varchar(255) UNIQUE NOT NULL,
  examinee_name varchar(255) NOT NULL,
  examinee_password varchar(255) NOT NULL,
  examinee_branch varchar(255),
  examinee_email varchar(255),
  PRIMARY KEY(examinee_id)
);

-- --------------------------------------------------------
-- Table structure for table as_center
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_center(
  center_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  center_code varchar(255) UNIQUE NOT NULL,
  center_name varchar(255) NOT NULL,
  PRIMARY KEY(center_id)
);

-- --------------------------------------------------------
-- Table structure for table `as_drive_center_examinee`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_drive_center_examinee(
  drive_center_examinee_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  examdrive_id int(10) unsigned,
  examinee_id int(10) unsigned,
  center_id int(10) unsigned,
  PRIMARY KEY(drive_center_examinee_id),
  CONSTRAINT `uk_as_drive_center_examinee` UNIQUE(examdrive_id,examinee_id,center_id)
);

ALTER TABLE as_drive_center_examinee
  ADD CONSTRAINT `fk_as_drive_center_examinee_examdrive_id` FOREIGN KEY (examdrive_id) REFERENCES as_examdrive(examdrive_id) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_as_drive_center_examinee_examinee_id` FOREIGN KEY (examinee_id) REFERENCES as_examinee(examinee_id) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_as_drive_center_examinee_center_id` FOREIGN KEY (center_id) REFERENCES as_center(center_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_batch`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_batch(
  batch_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  batch_code varchar(255) UNIQUE NOT NULL,
  batch_start_time datetime NOT NULL,
  batch_end_time datetime NOT NULL,
  center_id int(10) unsigned,
  PRIMARY KEY (batch_id)
);

ALTER TABLE as_batch
  ADD CONSTRAINT `fk_as_batch_center_id` FOREIGN KEY (center_id) REFERENCES as_center(center_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_course_master`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_course_master (
  course_master_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  course_code varchar(255) UNIQUE NOT NULL,
  course_name varchar(255) NOT NULL,
  PRIMARY KEY (course_master_id)
);

-- --------------------------------------------------------
-- Table structure for table `as_batch_course`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_batch_course (
  batch_course_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  batch_id int(10) unsigned,
  course_master_id int(10) unsigned,
  qp_status ENUM('PENDING','RECEIVED','ERROR_SENDING') DEFAULT 'PENDING',
  PRIMARY KEY (batch_course_id),
  CONSTRAINT `uk_as_batch_course` UNIQUE (batch_id,course_master_id)
);

ALTER TABLE as_batch_course
  ADD CONSTRAINT `fk_as_batch_course_batch_id` FOREIGN KEY (batch_id) REFERENCES as_batch(batch_id) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_as_batch_course_course_master_id` FOREIGN KEY (course_master_id) REFERENCES as_course_master(course_master_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_invigilator`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_invigilator (
  invigilator_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  invigilator_code varchar(255) UNIQUE NOT NULL,
  invigilator_name varchar(255) NOT NULL,
  invigilator_email varchar(255) UNIQUE NOT NULL,
  invigilator_password varchar(255) NOT NULL,
  batch_course_id int(10) unsigned,
  user_status ENUM('Active', 'NOT_Active'),
  PRIMARY KEY (invigilator_id)
);

ALTER TABLE as_invigilator
  ADD CONSTRAINT `fk_as_invigilator_batch_course_id` FOREIGN KEY (batch_course_id) REFERENCES as_batch_course(batch_course_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_question_paper`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_question_paper(
  qp_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  qp_code varchar(255) UNIQUE NOT NULL,
  batch_course_id int(10) unsigned,
  maximum_marks float(24) NOT NULL DEFAULT 100,
  duration int(10) NOT NULL DEFAULT 180,
  PRIMARY KEY(qp_id)
);

ALTER TABLE as_question_paper
  ADD CONSTRAINT `fk_as_question_paper_batch_course_id` FOREIGN KEY (batch_course_id) REFERENCES as_batch_course(batch_course_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_question_paper`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_instruction(
  instruction_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  instruction_code varchar(255) UNIQUE NOT NULL,
  qp_id int(10) unsigned,
  instruction_text varchar(255) NOT NULL,
  PRIMARY KEY(instruction_id)
);

ALTER TABLE as_instruction
  ADD CONSTRAINT `fk_as_instruction_qp_id` FOREIGN KEY (qp_id) REFERENCES as_question_paper(qp_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_examinee_drive_qp`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_examinee_drive_qp(
  examinee_drive_qp_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  qp_id int(10) unsigned,
  drive_center_examinee_id int(10) unsigned,
  marks_obtained float(24) NOT NULL,
  PRIMARY KEY(examinee_drive_qp_id),
  CONSTRAINT `uk_as_examinee_drive_qp` UNIQUE (qp_id,drive_center_examinee_id)
);

ALTER TABLE as_examinee_drive_qp
  ADD CONSTRAINT `fk_as_examinee_drive_qp_qp_id` FOREIGN KEY (qp_id) REFERENCES as_question_paper(qp_id) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_as_examinee_drive_qp_drive_center_examinee_id` FOREIGN KEY (drive_center_examinee_id) REFERENCES as_drive_center_examinee(drive_center_examinee_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_itemtype_master`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_itemtype_master (
  itemtype_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  itemtype_code varchar(255) UNIQUE NOT NULL,
  itemtype_name varchar(255) NOT NULL,
  itemtype_category ENUM('AUTO','MANUAL') DEFAULT 'MANUAL',
  PRIMARY KEY (itemtype_id)
);

-- --------------------------------------------------------
-- Table structure for table `as_qp_item`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_qp_item (
  qp_item_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  item_code varchar(255) UNIQUE NOT NULL,
  item_text varchar(511) NOT NULL,
  item_marks float(24) unsigned NOT NULL,
  item_type varchar(255) NOT NULL,
  cognitive_level ENUM('REMEMBER','UNDERSTAND','APPLY','ANALYZE','EVALUATE','CREATE'),
  qp_id int(10) unsigned,
  PRIMARY KEY (qp_item_id)
);

ALTER TABLE as_qp_item
  ADD constraint `fk_as_qp_item_qp_id` FOREIGN KEY (qp_id) REFERENCES as_question_paper(qp_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_item_mcq_options`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_item_mcq_options(
  item_mcq_id  int(10) unsigned NOT NULL AUTO_INCREMENT,
  item_mcq_options_code varchar(255) UNIQUE NOT NULL,
  qp_item_id int(10) unsigned,
  mcq_option_text varchar(255) NOT NULL,
  mcq_option_percentage float(24) DEFAULT 0.0,
  PRIMARY KEY(item_mcq_id)
);

ALTER TABLE as_item_mcq_options
  ADD constraint `as_item_mcq_options_qp_item_id` FOREIGN KEY (qp_item_id) REFERENCES as_qp_item(qp_item_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_item_true_false`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_item_true_false(
  item_true_false_id  int(10) unsigned NOT NULL AUTO_INCREMENT,
  item_true_false_code varchar(255) UNIQUE NOT NULL,
  qp_item_id int(10) unsigned,
  true_percentage float(24) DEFAULT 0.0,
  false_percentage  float(24) DEFAULT 0.0,
  PRIMARY KEY(item_true_false_id)
);

ALTER TABLE as_item_true_false
  ADD constraint `as_item_true_false_qp_item_id` FOREIGN KEY (qp_item_id) REFERENCES as_qp_item(qp_item_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_attempt`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_attempt (
  attempt_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  attempt_code varchar(255) UNIQUE NOT NULL,
  attempt_number int(10) unsigned NOT NULL,
  attempt_start_time timestamp NOT NULL,
  attempt_end_time timestamp NOT NULL,
  status ENUM('NOT_Started','IN_Progress','Completed','Abandoned'),
  examinee_drive_qp_id int(10) unsigned,
  PRIMARY KEY (attempt_id)
);

ALTER TABLE as_attempt
  ADD constraint `fk_as_attempt_examinee_drive_qp_id` FOREIGN KEY (examinee_drive_qp_id) REFERENCES as_examinee_drive_qp(examinee_drive_qp_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_response`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_response (
  response_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  response_code varchar(255) UNIQUE NOT NULL,
  qp_item_id int(10) unsigned,
  attempt_id int(10) unsigned,
  PRIMARY KEY (response_id)
);

ALTER TABLE as_response
  ADD constraint `fk_as_response_qp_item_id` FOREIGN KEY (qp_item_id) REFERENCES as_qp_item(qp_item_id) ON DELETE SET NULL,
  ADD constraint `fk_as_response_attempt_id` FOREIGN KEY (attempt_id) REFERENCES as_attempt(attempt_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_response_mcq`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_response_mcq (
  response_mcq_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  response_mcq_code varchar(255) UNIQUE NOT NULL,
  response_text varchar(511) NOT NULL,
  response_id int(10) unsigned,
  PRIMARY KEY (response_mcq_id)
);

ALTER TABLE as_response_mcq
  ADD constraint `fk_as_response_mcq_response_id` FOREIGN KEY (response_id) REFERENCES as_response(response_id) ON DELETE SET NULL;

-- --------------------------------------------------------
-- Table structure for table `as_response_true_false`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS as_response_true_false (
  response_true_false_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  response_true_false_code varchar(255) UNIQUE NOT NULL,
  response_id int(10) unsigned,
  PRIMARY KEY (response_true_false_id)
);

ALTER TABLE as_response_true_false
  ADD constraint `fk_as_response_true_false_response_id` FOREIGN KEY (response_id) REFERENCES as_response(response_id) ON DELETE SET NULL;