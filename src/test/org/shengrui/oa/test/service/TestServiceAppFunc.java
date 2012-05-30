package org.shengrui.oa.test.service;

import org.shengrui.oa.model.system.ModelAppFunction;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.service.system.ServiceAppFunction;
import org.shengrui.oa.service.system.ServiceAppMenu;
import org.shengrui.oa.test.BaseTest;

import cn.trymore.core.exception.ServiceException;

public class TestServiceAppFunc
extends BaseTest
{
	private ServiceAppFunction serviceAppFunc;
	
	private ServiceAppMenu serviceAppMenu;
	
	@Override
	protected void setUp() throws Exception 
	{
		super.setUp();
		
		this.serviceAppFunc = 
			(ServiceAppFunction) applicationContext.getBean("serviceAppFunc");
		
		this.serviceAppMenu = 
			(ServiceAppMenu) applicationContext.getBean("serviceAppMenu");
	}
	
	public void testSaveFunction() throws ServiceException
	{
		ModelAppFunction domain = new ModelAppFunction();
		
		domain.setFuncKey("_SYSTEM_MENU_EDIT");
		domain.setFuncName("Menu Edit");
		
		ModelAppMenu menu = this.serviceAppMenu.get("2");
		
		if (menu != null)
		{
			domain.setMenu(menu);
		}
		
		this.serviceAppFunc.save(domain);
		
	}
	
	public void setServiceAppFunc(ServiceAppFunction serviceAppFunc)
	{
		this.serviceAppFunc = serviceAppFunc;
	}

	public ServiceAppFunction getServiceAppFunc()
	{
		return serviceAppFunc;
	}
	
}
