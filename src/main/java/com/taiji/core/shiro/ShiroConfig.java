package com.taiji.core.shiro;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.Filter;

import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.io.ResourceUtils;
import org.apache.shiro.mgt.RememberMeManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.DelegatingFilterProxy;

import com.taiji.user.service.SysPuriewResourcerService;

import net.sf.ehcache.CacheManager;

@Configuration
public class ShiroConfig {
	@Value("${spring.shiro.loginUrl:/login}")
	private String loginUrl;
	@Value("{spring.shiro.successUrl:/index}")
	private String successUrl;
	@Value("${spring.shiro.unauthorizedUrl:/unauth}")
	private String unauthorizedUrl;
	@Value("${app.support.shiro.ehcache:classpath:config/dev/ehcache-shiro.xml}")
	private String ehcache;

	@Autowired
	private ShiroRealmDb shiroRealmDb;
	
	@Autowired
	private SysPuriewResourcerService puriewService;

	@Bean("shiroFilter")
	protected ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) throws Exception {
		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		// 必须设置 SecurityManager
		shiroFilterFactoryBean.setSecurityManager(securityManager);
		shiroFilterFactoryBean.setLoginUrl(loginUrl);
		shiroFilterFactoryBean.setSuccessUrl(successUrl);
		shiroFilterFactoryBean.setUnauthorizedUrl(unauthorizedUrl);
		shiroFilterFactoryBean.setFilterChainDefinitionMap(loadFilterChainDefinitions());
		Map<String, Filter> filters = shiroFilterFactoryBean.getFilters();
		filters.put(ShiroPermsByOr.TAG, new ShiroPermsByOr());
		shiroFilterFactoryBean.setFilters(filters);
		return shiroFilterFactoryBean;
	}

	@Bean(name = "securityManager")
	protected SecurityManager securityManager(RememberMeManager meManager, EhCacheManager ehCacheManager) {
		DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
		securityManager.setRealm(shiroRealmDb);
		securityManager.setCacheManager(ehCacheManager);
		securityManager.setRememberMeManager(meManager);
		return securityManager;
	}

	@Bean
	protected RememberMeManager rememberMeManager() {
		CookieRememberMeManager manager = new CookieRememberMeManager();
		manager.setCipherKey(Base64.decode("5aaC5qKm5oqA5pyvAAAAAA=="));
		SimpleCookie cookie = new SimpleCookie("RememberMeManager");
		cookie.setHttpOnly(true);
		cookie.setMaxAge(7 * 24 * 60 * 60);
		manager.setCookie(cookie);
		return manager;
	}

	@Bean
	protected EhCacheManager ehCacheManager() {
		CacheManager cacheManager = CacheManager.getCacheManager("es");
		if (cacheManager == null) {
			try {
				cacheManager = CacheManager.create(ResourceUtils.getInputStreamForPath(ehcache));
			} catch (IOException e) {
				throw new RuntimeException("initialize cacheManager failed");
			}
		}
		EhCacheManager ehCacheManager = new EhCacheManager();
		ehCacheManager.setCacheManager(cacheManager);
		return ehCacheManager;

	}

	protected Map<String, String> loadFilterChainDefinitions() throws Exception {
		Map<String, String> filterChainDefinitionMap = new LinkedHashMap<String, String>();
		filterChainDefinitionMap.put("/commons/**", "anon");
		filterChainDefinitionMap.put("/static/**", "anon");
		filterChainDefinitionMap.put("/service/**", "anon");
		filterChainDefinitionMap.put("/log/**", "anon");
		filterChainDefinitionMap.put("/resource/userMenu", "user");
		List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
		// TODO 查询数据库中的 URLS 和 EXPRESSION, √
		maps=puriewService.globalConfig();
		Map<String, String> otherChains = new HashMap<String, String>();
		for (Map<String, Object> map : maps) {
			if (map == null) {
				break;
			}
			String[] expressions = String.valueOf(map.get("EXPRESSION")).split(",");
			if (expressions == null) {
				break;
			}
			String urls = String.valueOf(map.get("URLS"));
			if (urls == null) {
				break;
			}
			for (String expression : expressions) {
				otherChains.put(expression, urls);
			}
		}
		for (Entry<String, String> objects : otherChains.entrySet()) {
			filterChainDefinitionMap.put(objects.getKey(), ShiroPermsByOr.TAG + "[" + objects.getValue() + "]");
		}
		filterChainDefinitionMap.put("/**", "user");
		return filterChainDefinitionMap;
	}

	@Bean
	protected FilterRegistrationBean delegatingFilterProxy() {
		FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
		DelegatingFilterProxy proxy = new DelegatingFilterProxy();
		proxy.setTargetFilterLifecycle(true);
		proxy.setTargetBeanName("shiroFilter");
		filterRegistrationBean.setFilter(proxy);
		filterRegistrationBean.addInitParameter("targetFilterLifecycle", "true");
		filterRegistrationBean.setEnabled(true);
		filterRegistrationBean.addUrlPatterns("/*");
		return filterRegistrationBean;
	}
}
