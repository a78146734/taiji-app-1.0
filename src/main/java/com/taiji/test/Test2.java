package com.taiji.test;

import java.util.ArrayList;
import java.util.List;

public class Test2 {
	public static void main(String[] args) {
		List<String> list = new ArrayList<String>();
		list.add("1");
		list.add("2");
		list.add("3");
		
		System.out.println(list.size());
		
		list.remove(2);
		
		System.out.println(list.size());
		
	}
}
