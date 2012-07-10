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
