package com.taiji.taijiappsupport;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.service.SysDictionaryDataService;

@RunWith(SpringRunner.class) 
@SpringBootTest 
public class TestRepository {

	@Autowired
	private SysDictionaryDataService dictionaryDataService;    
     
    @Test  
    public void testFindByName() {  
		SysDictionaryData data = null;
		try {
			//data = dictionaryDataService.findByDictionaryDataId(2014072L);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("data: "+data.getDictionaryDataName()+" param: "+data.getParameter1());
    } 
}
