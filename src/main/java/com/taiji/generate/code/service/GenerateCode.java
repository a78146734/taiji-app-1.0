package com.taiji.generate.code.service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.exception.MethodInvocationException;
import org.apache.velocity.exception.ParseErrorException;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.apache.velocity.runtime.RuntimeConstants;
import org.springframework.core.env.Environment;

import com.alibaba.druid.pool.DruidDataSource;
import com.taiji.core.config.spring.SpringContextHolder;
import com.taiji.core.utils.StringUtils;


/**
 * Description: 根据表生成代码<br>
 * Copyright:DATANG SOFTWARE CO.LTD<br>
 * 
 * @author anjl
 * 
 */
public class GenerateCode {
	/**
	 * 日志对象
	 */
	private Logger logger = LogManager.getLogger(getClass());
	/**
	 * 用户当前目录
	 */
	public static final String USER_DIR = System.getProperty("user.dir");
	/**
	 * 文件分隔符
	 */
	public static final String FILE_SEPARATOR = System.getProperty("file.separator");
	
	public static String fileDir;
	
	private Environment env = SpringContextHolder.getBean(Environment.class);

	static {
		Properties p = new Properties();
		InputStream inStream = GenerateCode.class.getClassLoader().getResourceAsStream("velocity.properties");
		try {
			p.load(inStream);
			fileDir = GenerateCode.class.getResource("/"+p.getProperty("template.version")).getPath().replaceAll("%20"," ");
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}
	
	/**
	 * 初始化
	 */
	public GenerateCode() {
		try {
			Properties p = new Properties();
			InputStream inStream = GenerateCode.class.getClassLoader().getResourceAsStream("velocity.properties");
			p.load(inStream);	
			Velocity.init(p);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 初始化
	 */
	public GenerateCode(String projectPath) {
		try {
			Properties p = new Properties();
			InputStream inStream = GenerateCode.class.getClassLoader().getResourceAsStream("velocity.properties");
			p.load(inStream);										  
			Velocity.setProperty(Velocity.FILE_RESOURCE_LOADER_PATH, projectPath+"config");
			Velocity.init(p);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Description: 代码生成工具的主函数<br>
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		GenerateCode generateCode = new GenerateCode();
		generateCode.generate();
	}

	/**
	 * Description: 代码生成<br>
	 */
	public void generate() {
		if (logger.isDebugEnabled()) {
			logger.debug("==========开始生成==========");
		}
		// 获取配置文件
		Properties properties = getProperties();
		// 获取表名
		String[] tableNames = getTableName(properties);
		// 循环生成代码
		
		try {
			List<String> warnings = new ArrayList<String>();
			boolean overwrite = true;
			/*File configFile = new File(USER_DIR + FILE_SEPARATOR + FILE_SEPARATOR + "config" + FILE_SEPARATOR  + "generatorConfig.xml");
			ConfigurationParser cp = new ConfigurationParser(warnings);
			Configuration config = cp.parseConfiguration(configFile);
			DefaultShellCallback callback = new DefaultShellCallback(overwrite);
			MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
			myBatisGenerator.generate(null);*/
			if (logger.isDebugEnabled()) {
				for (String string : warnings) {
					logger.debug(string);
				}
			}
			for (String tableName : tableNames) {
				// 设置上下文
				VelocityContext context = getContext(tableName, properties,null);
				
				generateQB(tableName, properties, context);//生成实体类
				generateService(tableName, properties, context);
				generateServiceImpl(tableName, properties, context);
				generateAction(tableName, properties, context);//action
				generateXxxAdd(tableName, properties, context);
				generateXxxList(tableName, properties, context);
				generateXxxUpdate(tableName, properties, context);
				generateXxxDetail(tableName, properties, context);
				System.out.println("==========生成成功==========");
				logger.debug("==========生成成功==========");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}  catch (SQLException e) {
			e.printStackTrace();
		} 
		if (logger.isDebugEnabled()) {
			logger.debug("==========生成结束==========");
		}
	}

	/**
	 * Description: 生成QB<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	public void generateQB(String tableName, Properties properties, VelocityContext context) {
		try {
			
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			
			// 获取模板
			Template template = ve.getTemplate("entity.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(context.get("Name").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("basePackage").toString());
			System.out.println(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			path.append(properties.getProperty("entity"));
			path.append(FILE_SEPARATOR);
			System.out.println(path.toString());
			File directory = new File(path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			System.out.println(directory);
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+convertFirstLetterToUpperCase(tableName) + ".java"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Description: 生成component层代码<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	private void generateComponent(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("Component.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(context.get("Name").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			path.append(properties.getProperty("component"));
			path.append(FILE_SEPARATOR);
			File directory = new File(path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+convertFirstLetterToUpperCase(tableName) + "Component.java"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Description: 生成service接口代码<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	
	
	
	
	public void generateMapper(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("Repository.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(context.get("Name").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			path.append(properties.getProperty("dao"));
			path.append(FILE_SEPARATOR);
			File directory = new File( path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+convertFirstLetterToUpperCase(tableName) + "Repository.java"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Description: 生成service接口代码<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	public void generateService(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("Service.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(context.get("Name").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			path.append(properties.getProperty("service"));
			path.append(FILE_SEPARATOR);
			File directory = new File( path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+"/"+FILE_SEPARATOR+convertFirstLetterToUpperCase(tableName) + "Service.java"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Description: 生成service实现类代码<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	public void generateServiceImpl(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("ServiceImpl.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(context.get("Name").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			path.append(properties.getProperty("service"));
			path.append(FILE_SEPARATOR);
			File directory = new File(path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+convertFirstLetterToUpperCase(tableName)+ "ServiceImpl.java"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Description: 生成Action代码<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	public void generateAction(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板EAP_SYS_ROLE
			Template template = ve.getTemplate("Controller.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(context.get("Name").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("basePackage").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			path.append(properties.getProperty("web"));
			File directory = new File(path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToUpperCase(tableName) + "Controller.java"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	public String getProjectPath(VelocityContext context) {
		return context.get("projectPath").toString()+"/";
	}
	
	/**
	 * Description: 生成主页面代码<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	public void generateXxxAdd(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("Add.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(properties.getProperty("jspbasePackage"));
			path.append(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			File directory = new File(path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName))  + "Add.jsp"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Description: 生成列表页面<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	public void generateXxxList(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("List.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(properties.getProperty("jspbasePackage"));
			path.append(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			File directory = new File(path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "List.jsp"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Description: 生成增加页面<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	private void generateXxxCreate(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("Add.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(properties.getProperty("jspbasePackage"));
			path.append(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			File directory = new File(path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName))  + "Create.jsp"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Description: 生成修改页面<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	public void generateXxxUpdate(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("Update.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(properties.getProperty("jspbasePackage"));
			path.append(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			File directory = new File(path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName))  + "Update.jsp"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Description: 生成明细页面<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	public void generateXxxDetail(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("Detail.vm");
			//
			StringBuffer path = new StringBuffer();
			path.append(getProjectPath(context));
			path.append(properties.getProperty("jspbasePackage"));
			path.append(context.get("basePackage").toString());
			path.append(context.get("module").toString());
			path.append(FILE_SEPARATOR);
			path.append(context.get("function").toString());
			path.append(FILE_SEPARATOR);
			File directory = new File(path.toString());
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "Detail.jsp"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Description: 生成mybatis配置文件<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @param context
	 *            上下文
	 */
	public void generateXxxMybatis(String tableName, Properties properties, VelocityContext context) {
		try {
			VelocityEngine ve = new VelocityEngine();
			Properties proper = new Properties();
			proper.setProperty(RuntimeConstants.FILE_RESOURCE_LOADER_PATH, fileDir); //此处的fileDir可以直接用绝对路径来
			proper.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
			proper.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");
			//指定,如"D:/template",但记住只要指定到文件夹就行了
			ve.init(proper);   //初始化
			// 获取模板
			Template template = ve.getTemplate("gereratorConfig.vm");
			//
			StringBuffer path = new StringBuffer();
			File directory = new File(properties.getProperty("file.resource.loader.path"));
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR + "generatorConfig.xml"),"UTF-8"));
			// 合并
			if (template != null) {
				template.merge(context, writer);
			}
			writer.flush();
			writer.close();
		} catch (ResourceNotFoundException e) {
			e.printStackTrace();
		} catch (ParseErrorException e) {
			e.printStackTrace();
		} catch (MethodInvocationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public void generateJS(String tableName, Properties properties, VelocityContext context){
		StringBuffer path = new StringBuffer();
		path.append(getProjectPath(context));
		path.append(properties.getProperty("jspbasePackage"));
		path.append(context.get("basePackage").toString());
		path.append(context.get("module").toString());
		path.append(FILE_SEPARATOR);
		path.append(context.get("function").toString());
		path.append(properties.get("js"));
		File directory = new File(path.toString());
		if (!directory.isDirectory()) {
			directory.mkdirs();
		}
		try {
			
			BufferedWriter writer0 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "Detail.js"),"UTF-8"));
			writer0.flush();
			writer0.close();
			
			BufferedWriter writer1 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "List.js"),"UTF-8"));
			writer1.flush();
			writer1.close();
			
			BufferedWriter writer2 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "Add.js"),"UTF-8"));
			writer2.flush();
			writer2.close();
			
			BufferedWriter writer3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "Update.js"),"UTF-8"));
			writer3.flush();
			writer3.close();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void generateCss(String tableName, Properties properties, VelocityContext context){
		StringBuffer path = new StringBuffer();
		path.append(getProjectPath(context));
		path.append(properties.getProperty("jspbasePackage"));
		path.append(context.get("basePackage").toString());
		path.append(context.get("module").toString());
		path.append(FILE_SEPARATOR);
		path.append(context.get("function").toString());
		path.append(properties.get("css"));
		File directory = new File(path.toString());
		if (!directory.isDirectory()) {
			directory.mkdirs();
		}
		try {
			BufferedWriter writer0 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "Detail.css"),"UTF-8"));
			writer0.flush();
			writer0.close();
			
			BufferedWriter writer1 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "List.css"),"UTF-8"));
			writer1.flush();
			writer1.close();
			
			BufferedWriter writer2 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "Add.css"),"UTF-8"));
			writer2.flush();
			writer2.close();
			
			BufferedWriter writer3 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(directory+FILE_SEPARATOR+ convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)) + "Update.css"),"UTF-8"));
			writer3.flush();
			writer3.close();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*public static boolean WriteProperies(String projectPath){
		Properties properties = new Properties();
		InputStream inStream = GenerateCode.class.getClassLoader().getResourceAsStream("velocity.properties");
			try {
				properties.load(inStream);
				inStream.close();
				//重新写入配置文件
				FileOutputStream file = new FileOutputStream(projectPath+"config/velocity.properties");
				
				properties.setProperty("file.resource.loader.path", projectPath+"config"); 
				properties.store(file, "velocity 配置文件"); 
				file.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return true;
		}*/
	
	/**
	 * Description: 去除字符串的下划线，并把每部分的首字母转换为大写<br>
	 * 
	 * @param string
	 *            字符串
	 * @return 转换后的字符串
	 */
	public static String convertFirstLetterToUpperCase(String string) {
		String newTableName = "";
		String[] str = string.split("_");
		for (String part : str) {
			part = part.toLowerCase();
			if (part.length() == 1) {
				newTableName += part.toUpperCase();
			} else if (part.length() > 1) {
				String firstLetter = part.substring(0, 1).toUpperCase();
				String otherLetter = part.substring(1);
				newTableName += firstLetter + otherLetter;
			}
		}
		return newTableName;
	}

	/**
	 * Description: 把字符串的首字母转换为小写<br>
	 * 
	 * @param string
	 *            字符串
	 * @return 转换后的字符串
	 */
	public static String convertFirstLetterToLowerCase(String string) {
		String newString = "";
		if (string.length() == 1) {
			newString = string.toLowerCase();
		} else if (string.length() > 1) {
			String firstLetter = string.substring(0, 1).toLowerCase();
			String otherLetter = string.substring(1);
			newString = firstLetter + otherLetter;
		}
		return newString;
	}

	/**
	 * Description: 获取配置文件<br>
	 * 
	 * @return 配置文件
	 */
	public Properties getProperties() {
		Properties properties = new Properties();
		try {
			InputStream inStream = GenerateCode.class.getClassLoader().getResourceAsStream("velocity.properties");
			properties.load(inStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties;
	}

	/**
	 * Description: 设置上下文<br>
	 * 
	 * @param tableName
	 *            表名
	 * @param properties
	 *            配置文件
	 * @return 上下文
	 * @throws IOException 
	 */
	public VelocityContext getContext(String tableName, Properties properties,HashMap< String, String> map) throws SQLException, IOException {
		properties.setProperty("file.resource.loader.path", map.get("projectPath")+"config");
		VelocityContext velocityContext = new VelocityContext();
		 for (String key : map.keySet()) {
			 velocityContext.put(key, map.get(key));
			}
		 
		 Properties pro = new Properties();
//			InputStream  inStream = GenerateCode.class.getClassLoader().getResourceAsStream("jdbc.properties");
//			pro.load(inStream);
//			velocityContext.put("driverClass", pro.getProperty("driverClass"));
//			velocityContext.put("connectionURL", pro.getProperty("connectionURL"));
//			velocityContext.put("userId", pro.getProperty("userId"));
//			velocityContext.put("password", pro.getProperty("password"));
			velocityContext.put("tableName", tableName);
			velocityContext.put("genPur", map.get("genPur"));
			/*String schema = pro.getProperty("userId");*/
//			schema=schema.replace("\t", "");
//			schema=schema.replace(" ", "");
		//	velocityContext.put("schema", schema);
			
		Map<String, String> map0 = getPrimaryKey(tableName);
		List<String> primaryKeys = new ArrayList<String>();
		primaryKeys.add(map0.get("primaryKeys"));
		if (!primaryKeys.isEmpty()) {
			velocityContext.put("hasPrimaryKey", true);
			velocityContext.put("primaryKeys", primaryKeys);
			velocityContext.put("primaryKey", map0.get("primaryKey"));
		} else {
			try {
				throw new Exception("表没有设置主键");
			} catch (Exception e) {
				e.printStackTrace();
			}
			//velocityContext.put("hasPrimaryKey", false);
		}
		List<Column> columns = getColumn(tableName, primaryKeys);
		velocityContext.put("columns", columns);
		String rootPackage = convertRootPackage(velocityContext.get("basePackage").toString());
		if (StringUtils.isNotBlank(rootPackage)) {
			velocityContext.put("rootPackage", rootPackage);
		}
		velocityContext.put("userName", System.getProperty("user.name"));
		GenerateCode generateCode = new GenerateCode();
		velocityContext.put("generateCode", generateCode);
		velocityContext.put("convert", properties.getProperty("convert"));
		velocityContext.put("upperTableName", convertFirstLetterToUpperCase(tableName));
		velocityContext.put("lowerTableName", convertFirstLetterToLowerCase(convertFirstLetterToUpperCase(tableName)));
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		velocityContext.put("date", df.format(new Date()));
		
		
		return velocityContext;
	}

	/**
	 * Description: 从配置文件中获取表名<br>
	 * 
	 * @param properties
	 *            配置文件
	 * @return 一个表名数组
	 */
	public String[] getTableName(Properties properties) {
		String[] tableNames = null;
		if (StringUtils.isNotBlank(properties.getProperty("tableName"))) {
			tableNames = properties.getProperty("tableName").split(",");
		}
		return tableNames;
	}
	
	
	//springboot读取配置文件数据库信息
	String url= env.getProperty("spring.datasource.url");
	String username = env.getProperty("spring.datasource.username");
	String password = env.getProperty("spring.datasource.password");
	String driverClass = env.getProperty("spring.datasource.driverClassName");
	
	/**
	 * Description: 获取数据库连接<br>
	 * 
	 * @return 数据库连接
	 */
	private Connection getConnection() {
		Connection connection = null;
		try {
			//根据配置文件数据库信息，获取连接
			Class.forName(driverClass);
			connection = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 
		return connection;
	}

	/**
	 * Description: 获取表的主键信息<br>
	 * 
	 * @param schema
	 *            模式
	 * @param tableName
	 *            表名
	 * @return 主键信息
	 */
	public Map<String, String> getPrimaryKey(String tableName) {
		 Map<String, String> map = new  HashMap<String, String>();
		try {
			Connection connection = getConnection();
			DatabaseMetaData metaData = connection.getMetaData();
			
			
			
			ResultSet resultSet = metaData.getPrimaryKeys(null, username.toUpperCase(), tableName.toUpperCase());
			while (resultSet.next()) {
				if (logger.isDebugEnabled()) {
					logger.debug(tableName.toUpperCase() + "表的主键" + resultSet.getString("COLUMN_NAME"));
				}
				map.put("primaryKeys",convertFirstLetterToUpperCase(resultSet.getString("COLUMN_NAME")));
				map.put("primaryKey",resultSet.getString("COLUMN_NAME"));
			}
			resultSet.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * Description: 获取表的列信息<br>
	 * 
	 * @param schema
	 *            模式
	 * @param tableName
	 *            表名
	 * @return 列信息
	 */
	private List<Column> getColumn(String tableName, List<String> primaryKeys) {
		List<Column> list = new ArrayList<Column>();
		try {
			Connection connection = getConnection();
			DatabaseMetaData metaData = connection.getMetaData();
			ResultSet resultSet = metaData.getColumns(null, username.toUpperCase(), tableName.toUpperCase(), null);
			Column column = null;
			while (resultSet.next()) {
				if (logger.isDebugEnabled()) {
					logger.debug(tableName.toUpperCase() + "表的列名" + resultSet.getString("COLUMN_NAME"));
				}
				
				column = new Column();
				column.setColumn(resultSet.getString("COLUMN_NAME"));
				column.setColumnName(convertFirstLetterToUpperCase(resultSet.getString("COLUMN_NAME")));
				column.setColumnSize(resultSet.getInt("COLUMN_SIZE"));
				column.setNullable(resultSet.getInt("NULLABLE"));
				//column.setRemarks(resultSet.getString("REMARKS"));
				
				//oracle获取表注释方式 anjl2016-5-16 如果需要其他数据库，请添加..
				Statement st = connection.createStatement();
				ResultSet rs= st.executeQuery("select comments from all_col_comments where comments is not null and table_name='"+tableName+"' and column_name='"+resultSet.getString("COLUMN_NAME")+"'");
				while(rs.next()){
					column.setRemarks(rs.getString("comments"));//获取表字段注释
				}
				
				if (logger.isDebugEnabled()) {
				}
				column.setNullable(resultSet.getInt("NULLABLE"));
				column.setTypeName(resultSet.getString("TYPE_NAME"));
				if (primaryKeys.contains(convertFirstLetterToUpperCase(resultSet.getString("COLUMN_NAME")))) {
					column.setIsprimaryKey(true);
				} else {
					column.setIsprimaryKey(false);
				}
				list.add(column);
			}
			resultSet.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sortColum(list);
	}
	
	/***
	 * 
	 * @author anjl
	 * @see 该方法对获取到的column进行排序，将创建时间和更细时间等信息排序到末尾
	 * @param list
	 * @return
	 * 
	 */
	
	private List<Column> sortColum(List<Column> list){
		List<Column> listFlag = new LinkedList<Column>();
		for (int i=0;i<list.size();i++) {
			String flag = list.get(i).getColumn().toLowerCase();
			System.out.println(flag);
			if(flag.equals("create_time_")||
			   flag.equals("creater_")||
			   flag.equals("update_time_")||
			   flag.equals("updater_")){
				  
				   listFlag.add(list.get(i));
				   list.remove(i);
				   i--;
				   
			}
		}
		list.addAll(listFlag);
		System.out.println(listFlag.toString());
		listFlag = null;
		System.out.println(list.toString());
		return list;
	}
	
	/**
	 * Description: 把配置文件中的根目录转换为xxx.xxx的形式<br>
	 * 
	 * @param rootPackage
	 * @return 转换后的跟目录
	 */
	private String convertRootPackage(String rootPackage) {
		String newRootPackage = "";
		String[] str = rootPackage.split("/");
		for (String part : str) {
			part = part.toLowerCase();
			if (StringUtils.isNotBlank(part)) {
				newRootPackage += part + ".";
			}
		}
		return newRootPackage;
	}
}
