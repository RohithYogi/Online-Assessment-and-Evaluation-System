package com.iiitb.assessmentBackEnd.questionPaper;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QuestionPaperService {
	
	@Autowired
	private QuestionPaperRepository asQuestionPaperRepository;
	
	public List<AsQuestionPaperBatchCourse> getAllQps(int examineeId) {
		List<AsQuestionPaperBatchCourse> qpList = new ArrayList<>();
		asQuestionPaperRepository.findAllQuestionPaperNative(examineeId)
		.forEach(qpList::add);
		return qpList;
	}
}
