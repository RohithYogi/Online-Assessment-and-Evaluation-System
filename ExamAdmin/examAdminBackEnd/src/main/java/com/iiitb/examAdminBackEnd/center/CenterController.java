package com.iiitb.examAdminBackEnd.center;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class CenterController {
	@Autowired
	private CenterService centerService;
	
	@RequestMapping("/centers")
	public List<Center> getAllCenters() {
		return centerService.getAllCenters();
	}
	
	@RequestMapping(method=RequestMethod.DELETE, value="/centers/{id}")
	public void deleteCenter(@PathVariable int id) {
		centerService.deleteCenter(id);
	}
}
