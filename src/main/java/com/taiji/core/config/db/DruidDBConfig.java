package com.taiji.core.config.db;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Component;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;

/**
 * 数据库连接池
 * 
 * @author 赵国超
 *
 */
@Configuration
@Component
public class DruidDBConfig {
	DataSourceProperties properties;

	DruidDBConfig(DataSourceProperties properties) {
		this.properties = properties;
	}

	@Value("${spring.datasource.initialSize:5}")
	private int initialSize;

	@Value("${spring.datasource.minIdle:5}")
	private int minIdle;

	@Value("${spring.datasource.maxActive:20}")
	private int maxActive;

	@Value("${spring.datasource.maxWait:60000}")
	private int maxWait;

	@Value("${spring.datasource.timeBetweenEvictionRunsMillis:60000}")
	private int timeBetweenEvictionRunsMillis;

	@Value("${spring.datasource.minEvictableIdleTimeMillis:300000}")
	private int minEvictableIdleTimeMillis;

	@Value("${spring.datasource.validationQuery:SELECT 1 FROM DUAL}")
	private String validationQuery;

	@Value("${spring.datasource.testWhileIdle:true}")
	private boolean testWhileIdle;

	@Value("${spring.datasource.testOnBorrow:false}")
	private boolean testOnBorrow;

	@Value("${spring.datasource.testOnReturn:false}")
	private boolean testOnReturn;

	@Value("${spring.datasource.poolPreparedStatements:true}")
	private boolean poolPreparedStatements;

	@Value("${spring.datasource.maxPoolPreparedStatementPerConnectionSize:20}")
	private int maxPoolPreparedStatementPerConnectionSize;

	@Value("${spring.datasource.filters:stat,wall,log4j2}")
	private String filters;

	@Value("{spring.datasource.connectionProperties:druid.stat.mergeSql=true;druid.stat.slowSqlMillis=5000;}")
	private String connectionProperties;

	@Bean // 声明其为Bean实例
	@Primary // 在同样的DataSource中，首先使用被标注的DataSource
	public DataSource dataSource() {
		DruidDataSource datasource = new DruidDataSource();
		datasource.setUrl(properties.getUrl());
		datasource.setUsername(properties.getUsername());
		datasource.setPassword(properties.getPassword());
		datasource.setDriverClassName(properties.getDriverClassName());
		datasource.setInitialSize(initialSize);
		datasource.setMinIdle(minIdle);
		datasource.setMaxActive(maxActive);
		datasource.setMaxWait(maxWait);
		datasource.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);
		datasource.setMinEvictableIdleTimeMillis(minEvictableIdleTimeMillis);
		datasource.setValidationQuery(validationQuery);
		datasource.setTestWhileIdle(testWhileIdle);
		datasource.setTestOnBorrow(testOnBorrow);
		datasource.setTestOnReturn(testOnReturn);
		datasource.setPoolPreparedStatements(poolPreparedStatements);
		datasource.setMaxPoolPreparedStatementPerConnectionSize(maxPoolPreparedStatementPerConnectionSize);
		try {
			datasource.setFilters(filters);
		} catch (SQLException e) {

		}
		datasource.setConnectionProperties(connectionProperties);
		return datasource;
	}

	@Bean
	public ServletRegistrationBean druidServlet() {
		ServletRegistrationBean servletRegistrationBean = new ServletRegistrationBean();
		servletRegistrationBean.setServlet(new StatViewServlet());
		servletRegistrationBean.addUrlMappings("/sys/druid/*");
		Map<String, String> initParameters = new HashMap<String, String>();
		// initParameters.put("loginUsername", "druid");// 用户名
		// initParameters.put("loginPassword", "druid");// 密码
		initParameters.put("resetEnable", "false");// 禁用HTML页面上的“Reset All”功能
		initParameters.put("allow", "127.0.0.1"); // IP白名单 (没有配置或者为空，则允许所有访问)
		// initParameters.put("deny", "192.168.20.38");// IP黑名单
		// (存在共同时，deny优先于allow)
		servletRegistrationBean.setInitParameters(initParameters);
		return servletRegistrationBean;
	}

	@Bean
	public FilterRegistrationBean filterRegistrationBean() {
		FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
		filterRegistrationBean.setFilter(new WebStatFilter());
		filterRegistrationBean.addUrlPatterns("/*");
		filterRegistrationBean.addInitParameter("exclusions", "*.js,*.gif,*.jpg,*.bmp,*.png,*.css,*.ico,/druid/*");
		return filterRegistrationBean;
	}

}
