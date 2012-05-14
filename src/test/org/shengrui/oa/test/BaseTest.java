package org.shengrui.oa.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import junit.framework.TestCase;

public class BaseTest extends TestCase
{
	
	protected static ApplicationContext applicationContext = 
			new ClassPathXmlApplicationContext(
					new String[]{"spring/application*.xml"});
	
	@Override
	protected void setUp() throws Exception 
	{
		super.setUp();
	}
}
