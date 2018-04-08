package com.taiji.core.exception;

import com.taiji.core.base.result.Result;
/**
 * 
 * @作者 赵国超
 * @描述 自定义全局异常
 * 2018年2月28日
 */
public class CustomerException extends RuntimeException {

	Result result = new Result();
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CustomerException(String message) {
		result.setMsg(message);
		result.setSuccess(false);
	}

	public Result getRestResult() {
		return result;
	}
}
