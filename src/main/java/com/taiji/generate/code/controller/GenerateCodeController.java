package com.taiji.generate.code.controller;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.velocity.VelocityContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.taiji.core.base.controller.BaseController;
import com.taiji.core.utils.StringUtils;
import com.taiji.generate.code.entity.CodeData;
import com.taiji.generate.code.service.GenerateCode;
import com.taiji.user.service.SysResourceService;
/**
 * @author anjl
 * 代码生成Action
 */
@Controller
@RequestMapping
public class GenerateCodeController extends BaseController {
	
	private static final String TRUE = "1";
	
	@Autowired
	private SysResourceService sysResourceService;
	/**
	 * @author anjl
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@PostMapping("/generCode")
	@ResponseBody
	public Object generCode(HttpServletRequest request, HttpServletResponse response,CodeData cd) throws UnsupportedEncodingException{
			
			//数据校验
			if(!this.checkData(cd).equals(TRUE)){
				return renderError(this.checkData(cd));
			}
			//封装数据
			HashMap<String, String> map = new HashMap<String, String>();
			String tableName =  cd.getTableName();
			String projectPath = cd.getProjectPath();
			map.put("projectPath", projectPath);
			map.put("Name", cd.getSysname());
			map.put("basePackage", cd.getBasePackage());
			map.put("module", cd.getModule());
			map.put("function", cd.getFunction());
			map.put("schema", cd.getSchema());
			map.put("author", cd.getAuthor());
			map.put("genPur",String.valueOf(cd.isGenPur()));
			String genfile = cd.getGenfile();
			String[] strr = genfile.substring(0, genfile.length()-1).split(",");
			
			
			// 循环生成代码
			List<String> warnings = new ArrayList<String>();
			boolean overwrite = true;
			GenerateCode genCode = new GenerateCode(projectPath);
			// 获取配置文件
			Properties properties = genCode.getProperties();
			
			try {
				VelocityContext context = genCode.getContext(tableName, properties,map);
				
				//校验表是否设置了主键
				Map<String, String> primaryKeys = genCode.getPrimaryKey(tableName);
				if(primaryKeys.isEmpty()){
					return renderError("表："+tableName+" 没有设置主键");
				}
				
				for(int i=0;i<strr.length;i++){
					if(strr[i].equals("js")){
						context.put("js", "yes");
					}else if(strr[i].equals("css")){
						context.put("css", "yes");
					}
				}
				for(int i=0;i<strr.length;i++){
					if(strr[i].equals("dao")){
						/*genCode.generateXxxMybatis(tableName, properties, context);
						File configFile = new File(map.get("projectPath") + GenerateCode.FILE_SEPARATOR + "config" + GenerateCode.FILE_SEPARATOR  + "generatorConfig.xml");
						ConfigurationParser cp = new ConfigurationParser(warnings);
						Configuration config = cp.parseConfiguration(configFile);
						DefaultShellCallback callback = new DefaultShellCallback(overwrite);
						MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
						myBatisGenerator.generate(null);*/
						genCode.generateMapper(tableName, properties, context);
					}else if(strr[i].equals("service")){
						genCode.generateService(tableName, properties, context);
						genCode.generateServiceImpl(tableName, properties, context);
					}else if(strr[i].equals("action")){
						genCode.generateAction(tableName, properties, context);//action
					}else if(strr[i].equals("add")){
						genCode.generateXxxAdd(tableName, properties, context);
					}else if(strr[i].equals("detail")){
						genCode.generateXxxDetail(tableName, properties, context);
					}else if(strr[i].equals("update")){
						genCode.generateXxxUpdate(tableName, properties, context);
					}else if(strr[i].equals("list")){
						genCode.generateXxxList(tableName, properties, context);
					}else if(strr[i].equals("js")){
						genCode.generateJS(tableName, properties, context);
					}else if(strr[i].equals("css")){
						genCode.generateCss(tableName, properties, context);
					}
				}
				
				if(cd.isGenPur()){
					StringBuffer path = new StringBuffer();
					path.append("/jsp/");
					path.append(context.get("Name").toString());
					path.append(context.get("basePackage"));
					path.append(context.get("module"));
					path.append("/");
					path.append(context.get("function"));
					path.append("/");
					sysResourceService.insertGenPur(path.toString(),tableName,cd.getAuthor());
				}
				
			} catch (IOException e) {
				renderError("生成失败！");
				e.printStackTrace();
			}  catch (SQLException e) {
				renderError("生成失败！");
				e.printStackTrace();
			} catch (InterruptedException e) {
				renderError("生成失败！");
				e.printStackTrace();
			} catch (Exception e) {
				renderError("绑定权限失败！");
				e.printStackTrace();
			}
			
		return renderSuccess("生成成功！");
	}
	
	public String checkData(CodeData cd){
		if(StringUtils.isBlank(cd.getTableName())){
			return "TableName为空！";
		}else if(StringUtils.isBlank(cd.getProjectPath())){
			return "ProjectPath为空！";
		}else if(StringUtils.isBlank(cd.getSysname())){
			return "Name为空！";
		}else if(StringUtils.isBlank(cd.getBasePackage())){
			return "BasePackage为空！";
		}else if(StringUtils.isBlank(cd.getModule())){
			return "Module为空！";
		}else if(StringUtils.isBlank(cd.getFunction())){
			return "Function为空！";
		}else if(StringUtils.isBlank(cd.getAuthor())){
			return "Author为空！";
		}else if(StringUtils.isBlank(cd.getGenfile())){
			return "Genfile为空！";
		}else{
			return TRUE;
		}
		
	}
	
	
	/**
	 * 生成代码页面访问路径
	 * @author anjl
	 * @return String
	 * 
	 */
	@GetMapping("/code")
	public String code(){
		return "utils/generate/GenerCode";
	}
	
	
	/**
	 * 获取项目路径
	 * @author anjl
	 * @return String
	 */
	@GetMapping("obtainPath")
	@ResponseBody
	public Object obtainPath(HttpServletRequest request){
		String path = "";
		try {
			path = request.getSession().getServletContext().getRealPath("/");
			
			path = path.replaceAll("\\", "/");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return path;
	}
	
}
