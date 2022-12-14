package com.urest.v1.authoring_module.item;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete
@Repository
public interface ItemRepository extends CrudRepository<Item, Integer> {
	public List<Item> findByAuthorId(int qpId);
	
	@Query(nativeQuery =true,value = "SELECT * FROM au_item as i WHERE i.cognitive_level IN (:cgLvl) AND i.difficulty_level IN (:difLvl) AND i.item_type IN (:type) AND i.marks BETWEEN (:startMark) AND (:endMark) AND i.course_master_id=(:courseId)")   
    public List<Item> findByItemId(@Param("cgLvl") List<String> cgLvl,List<String> difLvl,List<String> type,int startMark,int endMark,int courseId);
	
	public List<Item> findByItemIdIn(List<Integer> ids);
}