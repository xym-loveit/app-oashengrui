package org.shengrui.oa.test.service;

import org.shengrui.oa.model.system.ModelAppFunction;
import org.shengrui.oa.model.system.ModelAppMenu;
import org.shengrui.oa.service.system.ServiceAppMenu;
import org.shengrui.oa.test.BaseTest;

import cn.trymore.core.exception.ServiceException;

public class TestServiceAppMenu
extends BaseTest
{
	private ServiceAppMenu serviceAppMenu;
	
	@Override
	protected void setUp() throws Exception 
	{
		super.setUp();
		
		this.serviceAppMenu = (ServiceAppMenu) applicationContext.getBean("serviceAppMenu");
	}
	
	public void _testSaveRootMenu() throws ServiceException
	{
		ModelAppMenu domain = new ModelAppMenu();
		
		domain.setMenuIcon("icon-desktop");
		domain.setMenuTitle("My Desktop");
		domain.setMenuUrl(ModelAppMenu.DEFAULT_MENU_URL);
		domain.setMenuKey("mdesk");
		domain.setMenuOrder(0);
		
		this.serviceAppMenu.save(domain);
	}
	
	public void _testSaveSubMenu() throws ServiceException
	{
		ModelAppMenu domain = new ModelAppMenu();
		
		domain.setMenuIcon("icon-task");
		domain.setMenuTitle("My Task");
		domain.setMenuUrl(ModelAppMenu.DEFAULT_MENU_URL);
		domain.setMenuKey("stask");
		domain.setMenuOrder(0);
		
		domain.setMenuParent(this.serviceAppMenu.get("1"));
		
		this.serviceAppMenu.save(domain);
	}
	
	public void testGet() throws ServiceException
	{
		ModelAppMenu domain = this.serviceAppMenu.get("1");
		assertNotNull(domain);
		
		if (domain.getMenuChildren() != null)
		{
			for (ModelAppMenu child : domain.getMenuChildren())
			{
				assertNotNull(child);
				System.out.println (child);
				
				if (child.getFunctions() != null)
				{
					for (ModelAppFunction func : child.getFunctions())
					{
						System.out.println(func);
					}
				}
				
			}
		}
	}
	
	public void testDeleteRootMenu() throws ServiceException
	{
		this.serviceAppMenu.remove("1");
	}
	
	public void setServiceAppMenu(ServiceAppMenu serviceAppMenu)
	{
		this.serviceAppMenu = serviceAppMenu;
	}

	public ServiceAppMenu getServiceAppMenu()
	{
		return serviceAppMenu;
	}
	
}
