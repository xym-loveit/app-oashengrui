package org.shengrui.oa.component.hibernate;

import java.sql.Types;

import org.hibernate.dialect.MySQL5Dialect;

public class HibernateMysqlDialect extends MySQL5Dialect {
	public HibernateMysqlDialect() {
		super();   
		registerHibernateType(Types.LONGVARCHAR, 65535, "text");
	}
}
