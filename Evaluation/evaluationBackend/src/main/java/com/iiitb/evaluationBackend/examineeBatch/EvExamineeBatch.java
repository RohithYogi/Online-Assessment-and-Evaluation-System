package com.iiitb.evaluationBackend.examineeBatch;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class EvExamineeBatch {
	
	@Id
	private int examineeBatchId;
	private String status;
	public EvExamineeBatch() {
	
		
	}
	public EvExamineeBatch(int drive_id,String status) {
		this.examineeBatchId = drive_id;
		this.setStatus_id(status);
	}
	
	public int getexaminee_batch_id() {
		return examineeBatchId;
	}

	public void setexaminee_batch_id(int examinee_batch_id) {
		this.examineeBatchId = examinee_batch_id;
	}
	public String getStatus_id() {
		return status;
	}
	public void setStatus_id(String status) {
		this.status = status;
	}
	
}
