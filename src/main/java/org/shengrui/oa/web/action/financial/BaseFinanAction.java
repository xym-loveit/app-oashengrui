package org.shengrui.oa.web.action.financial;

import javax.annotation.Resource;

import org.shengrui.oa.service.finan.ServiceFinanExpense;
import org.shengrui.oa.web.action.flow.FlowBaseAction;

/**
 * The base action for Finance Management.
 * 
 * @author Jeccy.Zhao
 *
 */
public class BaseFinanAction
extends FlowBaseAction
{
	/**
	 * The form key for financial expense
	 */
	protected final String FINAN_FORM_KEY_EXPENSE = "FE";
	
	/**
	 * The form key for financial contract
	 */
	protected final String FINAN_FORM_KEY_CONTRACT = "FC";
	
	/**
	 * The Expense service.
	 */
	@Resource
	protected ServiceFinanExpense serviceFinanExpense;

	public ServiceFinanExpense getServiceFinanExpense() {
		return serviceFinanExpense;
	}

	public void setServiceFinanExpense(ServiceFinanExpense serviceFinanExpense) {
		this.serviceFinanExpense = serviceFinanExpense;
	}
}
