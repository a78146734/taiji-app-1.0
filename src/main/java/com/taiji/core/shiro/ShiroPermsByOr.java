package com.taiji.core.shiro;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;

public class ShiroPermsByOr extends PermissionsAuthorizationFilter {
	public static String TAG="orPerms";
	/**
	 * 自定义鉴权 true 通过 false 未通过
	 */
	@Override
	public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue)
			throws IOException {
		Subject subject = getSubject(request, response);
		String[] perms = (String[]) mappedValue;
		boolean isPermitted = false;
		if (perms != null && perms.length > 0) {
			for (String string : perms) {
				if (subject.isPermitted(string)) {
					isPermitted = true;
					break;
				}
			}
		} else {
			isPermitted = true;
		}
		return isPermitted;
	}

}
