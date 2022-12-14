package com.iiitb.assessmentBackEnd.response;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ResponseController {
	
	@Autowired
	private ResponseService responseService;
	
	@RequestMapping("/qpItem/{qpItemId}/attempt/{attemptId}/response/{responseId}")
	public AsResponse getResponseFromId(@PathVariable int responseId){
		return responseService.getResponseFromId(responseId);
	}
	
//	@RequestMapping("/qpItem/{qpItemId}/attempt/{attemptId}/response")
//	public List<AsResponse> getResponseForQpItemAndAttempt(@PathVariable int qpItemId, @PathVariable int attemptId){
//		return responseService.getResponseForQpItemAndAttempt(qpItemId, attemptId);
//	}
	
	@RequestMapping("/response/lastRow")
	public AsResponse getLastRowFromResponse(){
		return responseService.getLastRowFromResponse();
	}
	
	@RequestMapping("/response/qpItem/{qpItemId}/examinee/{examineeId}/batch/{batchId}")
	public AsResponse getResponseForQpItemAndAttemptForRadioButton(@PathVariable int qpItemId,@PathVariable int examineeId, @PathVariable int batchId){
		return responseService.getResponseForQpItemAndAttemptForRadioButton(qpItemId, examineeId, batchId);
	}
	
	@RequestMapping("/batch/{batchId}/allResponsesForBatch")
	public List<AsResponse> getAllResponsesForBatchId(@PathVariable int batchId){
		return responseService.getAllResponsesForBatchId(batchId);
	}
	
	@RequestMapping("examinee/{examineeId}/batch/{batchId}/allResponses")
	public List<AsResponse> getAllResponsesForExamineeAndBatchIds(@PathVariable int examineeId, @PathVariable int batchId){
		return responseService.getAllResponsesForExamineeAndBatchIds(examineeId, batchId);
	}
	
	@RequestMapping(value = "/response/setResponse", headers="Content-Type=application/json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<AsResponse> addResponse(@RequestBody AsResponse response) {
        return new ResponseEntity<AsResponse>(responseService.addResponse(response),HttpStatus.OK);

    }
	
	@RequestMapping(value = "/response/{responseId}", headers="Content-Type=application/json", method = RequestMethod.PUT)
    @ResponseBody
    public ResponseEntity<AsResponse> updateResponse(@PathVariable int responseId, @RequestBody AsResponse response) {
        return new ResponseEntity<AsResponse>(responseService.updateResponse(responseId, response),HttpStatus.OK);

    }
	
	@RequestMapping(method = RequestMethod.DELETE, value = "/response/{responseId}")
    public void deleteResponse(@PathVariable int responseId) {
        responseService.deleteResponse(responseId);

    }
	
	@RequestMapping(method = RequestMethod.DELETE, value = "/responseUnchecked/examinee/{examineeId}/batch/{batchId}/qpItem/{qpItemId}/responseText/{responseText}")
    public void deleteResponseByQpItemIdExamineeIdBatchId(@PathVariable int qpItemId, @PathVariable int examineeId, @PathVariable int batchId, @PathVariable String responseText) {
        responseService.deleteResponseByQpItemIdExamineeIdBatchId(qpItemId, examineeId, batchId, responseText);
    }
	
//	@RequestMapping(method=RequestMethod.POST, value="/qpItem/{qpItemId}/attempt/{attemptId}/response")
//	@ResponseBody
//	public ResponseEntity<AsResponse> addResponse(@RequestBody AsResponse response, @PathVariable int qpItemId, @PathVariable int attemptId) {
//		return new ResponseEntity<AsResponse>(responseService.addResponseAndResponseMcq(response),HttpStatus.OK);
////		return responseService.addResponseAndResponseMcq(response);
//	}
	
//	@RequestMapping(method=RequestMethod.POST, value="/qpItem/{qpItemId}/attempt/{attemptId}/response")
//	public void addResponse(@RequestBody AsResponse response, @PathVariable int qpItemId, @PathVariable int attemptId) {
//		responseService.addResponse(qpItemId, attemptId, response);
//	}
}
