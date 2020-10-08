package com.iiitb.examAdminBackEnd.batch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class BatchController {

	@Autowired
	private BatchService batchService;
	
	@RequestMapping("batchByExamdrive/{id}")
	public List<Batch> getBatchesByExamdrive(@PathVariable int id){
		return batchService.getBatchesByExamdrive(id);
	}
}
