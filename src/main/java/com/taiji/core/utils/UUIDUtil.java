package com.taiji.core.utils;

import java.util.UUID;


public class UUIDUtil {
   public static String getUUID(){
	   return String.valueOf(System.currentTimeMillis());
   }  
   
   public static String get32UUID(){
	   String str = UUID.randomUUID().toString().replace("-", "");
	   return str;
   }  
   
 
   
   public static void main(String[] args) {
	   System.out.println(get32UUID().toUpperCase());
}
}