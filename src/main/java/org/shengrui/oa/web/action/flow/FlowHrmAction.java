package org.shengrui.oa.web.action.flow;

import org.apache.log4j.Logger;

/**
 * 工作流设置 - 人资审批流程设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class FlowHrmAction
extends FlowBaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(FlowHrmAction.class);
			
	/**
	 * The slug name for human resource flow
	 */
	public static final String PROCESS_TYPE_SLUG = "hrm";
	
	
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
}
