package org.shengrui.oa.test.service;

import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.service.finan.ServiceFinanExpense;
import org.shengrui.oa.service.flow.ServiceProcessForm;
import org.shengrui.oa.test.BaseTest;

import cn.trymore.core.exception.ServiceException;

public class TestServiceProcessForm
extends BaseTest
{
	
	private ServiceProcessForm serviceProcessForm;
	
	private ServiceFinanExpense serviceFinanExpense;
	
	@Override
	protected void setUp() throws Exception 
	{
		super.setUp();
		
		this.serviceFinanExpense = (ServiceFinanExpense) applicationContext.getBean("serviceFinanExpense");
	}
	
	public void testFetchProcessForm ()
	{
		
		try
		{
			ModelFinanExpense entity = serviceFinanExpense.get("3");
			
			System.out.println(entity.getProcessHistory());
			
		} 
		catch (ServiceException e)
		{
			e.printStackTrace();
		}
		
	}
	
	public ServiceProcessForm getServiceProcessForm()
	{
		return serviceProcessForm;
	}

	public void setServiceProcessForm(ServiceProcessForm serviceProcessForm)
	{
		this.serviceProcessForm = serviceProcessForm;
	}

	public ServiceFinanExpense getServiceFinanExpense()
	{
		return serviceFinanExpense;
	}

	public void setServiceFinanExpense(ServiceFinanExpense serviceFinanExpense)
	{
		this.serviceFinanExpense = serviceFinanExpense;
	}
}
