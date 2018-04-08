package com.taiji.core.logback;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.Logger;

public class LOG {
	// 日志级别
	public static final String OFF = "off";
	public static final String FATAL = "fatal";
	public static final String ERROR = "error";
	public static final String WARN = "warn";
	public static final String INFO = "info";
	public static final String DEBUG = "debug";
	public static final String TRACE = "trace";
	public static final String ALL = "all";

	public static final int MSG_MAX_LENGTH = 600;

	/**
	 * 记录日志
	 * 
	 * @param LOGGER
	 * @param request
	 * @param massage
	 */
	public static void off(Logger LOGGER, HttpServletRequest request, String massage) {
		record(LOGGER, request, OFF, massage);
		LOGGER.error(massage);
	}

	public static void off(Logger LOGGER, String massage) {
		record(LOGGER, OFF, massage);
		LOGGER.error(massage);
	}

	public static void fatal(Logger LOGGER, HttpServletRequest request, String massage) {
		record(LOGGER, request, FATAL, massage);
		LOGGER.error(massage);
	}

	public static void fatal(Logger LOGGER, String massage) {
		record(LOGGER, FATAL, massage);
		LOGGER.error(massage);
	}

	public static void error(Logger LOGGER, HttpServletRequest request, String massage) {
		record(LOGGER, request, ERROR, massage);
		LOGGER.error(massage);
	}

	public static void error(Logger LOGGER, String massage) {
		record(LOGGER, ERROR, massage);
		LOGGER.error(massage);
	}

	public static void warn(Logger LOGGER, HttpServletRequest request, String massage) {
		record(LOGGER, request, WARN, massage);
		LOGGER.fatal(massage);
	}

	public static void warn(Logger LOGGER, String massage) {
		record(LOGGER, WARN, massage);
		LOGGER.fatal(massage);
	}

	public static void info(Logger LOGGER, HttpServletRequest request, String massage) {
		record(LOGGER, request, INFO, massage);
		LOGGER.error(massage);
	}

	public static void info(Logger LOGGER, String massage) {
		record(LOGGER, INFO, massage);
		LOGGER.error(massage);
	}

	public static void debug(Logger LOGGER, HttpServletRequest request, String massage) {
		record(LOGGER, request, DEBUG, massage);
		LOGGER.debug(massage);
	}

	public static void debug(Logger LOGGER, String massage) {
		record(LOGGER, DEBUG, massage);
		LOGGER.debug(massage);
	}

	public static void trace(Logger LOGGER, HttpServletRequest request, String massage) {
		record(LOGGER, request, TRACE, massage);
		LOGGER.fatal(massage);
	}

	public static void trace(Logger LOGGER, String massage) {
		record(LOGGER, TRACE, massage);
		LOGGER.fatal(massage);
	}

	public static void all(Logger LOGGER, HttpServletRequest request, String massage) {
		record(LOGGER, request, ALL, massage);
		LOGGER.fatal(massage);
	}

	public static void all(Logger LOGGER, String massage) {
		record(LOGGER, ALL, massage);
		LOGGER.fatal(massage);
	}

	public static void record(Logger LOGGER, HttpServletRequest request, String level, String massage) {
		// TODO 实现日志储存
	}

	private static void record(Logger lOGGER, String off2, String massage) {
		// TODO 实现日志储存

	}

}
