/*package com.taiji.test;

import java.util.List;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.stu.info.entity.Student;
import com.stu.info.service.StudentService;


@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class Test {
	@Autowired
    private StudentService studentService;

    @org.junit.Test
    public void save() {
       //System.out.println(studentService);
    	for(int i=0;i<1;i++) {
    		
    		
    		List<Student>  list = studentService.getAll();
    		for (Student student : list) {
				System.out.println(student);
			}
    		
    		Student student = studentService.find("8a80a410621ed96201621edb50800000");
    		
    		System.out.println(student.toString());
    	}
    }
    

}
*/