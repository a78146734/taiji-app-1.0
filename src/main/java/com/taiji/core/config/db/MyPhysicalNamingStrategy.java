package com.taiji.core.config.db;

import java.util.Locale;

import org.hibernate.boot.model.naming.Identifier;
import org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl;
import org.hibernate.engine.jdbc.env.spi.JdbcEnvironment;
/**
 * 
 * @作者 赵国超
 * @描述 数据库映射命名方式
 * 2018年2月28日
 */
public class MyPhysicalNamingStrategy extends PhysicalNamingStrategyStandardImpl {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public Identifier toPhysicalCatalogName(Identifier name, JdbcEnvironment context) {
		if (name != null) {
			return Identifier.toIdentifier(addUnderscores(name.getText()));
		}
		return name;
	}

	@Override
	public Identifier toPhysicalSchemaName(Identifier name, JdbcEnvironment context) {
		if (name != null) {
			return Identifier.toIdentifier(addUnderscores(name.getText()));
		}
		return name;
	}

	@Override
	public Identifier toPhysicalSequenceName(Identifier name, JdbcEnvironment context) {
		if (name != null) {
			return Identifier.toIdentifier(preventKeywords(name.getText()));
		}
		return name;
	}

	@Override
	public Identifier toPhysicalTableName(Identifier name, JdbcEnvironment context) {
		if (name != null) {
			return Identifier.toIdentifier(preventKeywords(name.getText()));
		}
		return name;
	}

	@Override
	public Identifier toPhysicalColumnName(Identifier name, JdbcEnvironment context) {
		if (name != null) {
			return Identifier.toIdentifier(preventKeywords(name.getText()));
		}
		return name;
	}

	protected static String preventKeywords(String name) {
		return addUnderscores(name) + "_";
	}

	protected static String addUnderscores(String name) {
		StringBuilder buf = new StringBuilder(name.replace('.', '_'));
		for (int i = 1; i < buf.length() - 1; i++) {
			if (Character.isLowerCase(buf.charAt(i - 1)) && Character.isUpperCase(buf.charAt(i))
					&& Character.isLowerCase(buf.charAt(i + 1))) {
				buf.insert(i++, '_');
			}
		}
		return buf.toString().toUpperCase(Locale.ROOT);
	}

}
