package com;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

/**
 * 
 * @作者 赵国超
 * @描述 项目启动 注解控制事物，扫描包。。。
 * 2018年2月28日
 */
@SpringBootApplication
@ComponentScan(basePackages={ "com" })
@ServletComponentScan
public class TaijiAppSupportApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(TaijiAppSupportApplication.class);
	}

	public static void main(String[] args) {
		System.out.println("");
		SpringApplication.run(TaijiAppSupportApplication.class, args);
	}
}
