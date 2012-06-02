package cn.trymore.core.log;

import java.lang.reflect.Method;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.aop.MethodBeforeAdvice;

import cn.trymore.oa.model.system.ModelSystemLog;
import cn.trymore.oa.service.system.ServiceSystemLog;

/**
 * 系统日志AOP控制与日志记录.
 * 
 * @author Jeccy.Zhao
 *
 */
public class LogAdvice implements MethodBeforeAdvice
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(LogAdvice.class);
	
	/**
	 * The system log service 
	 */
	@Resource
	private ServiceSystemLog serviceSystemLog;

	/*
	 * (non-Javadoc)
	 * @see org.springframework.aop.MethodBeforeAdvice#before(java.lang.reflect.Method, java.lang.Object[], java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void before(Method method, Object[] args, Object target)
			throws Throwable
	{
		if (method.getDeclaringClass() == org.apache.struts.actions.DispatchAction.class)
		{
			if (args != null && args.length > 0)
			{
				String targetMethodName = null;
				Class targetClass = target.getClass();
				
				for (Object arg : args)
				{
					if (arg instanceof HttpServletRequest)
					{
						targetMethodName = ((HttpServletRequest) arg).getParameter("action");
						break;
					}
				}
				
				if (targetMethodName != null)
				{
					Method targetMethod = targetClass.getDeclaredMethod(targetMethodName, method.getParameterTypes());
					if (targetMethod != null)
					{
						boolean isLogAnnotation = targetMethod.isAnnotationPresent(LogAnnotation.class);
						if (isLogAnnotation)
						{
							LogAnnotation logAnnotation = targetMethod.getAnnotation(LogAnnotation.class);
							String description = logAnnotation.description();
							if (LOGGER.isDebugEnabled())
							{
								LOGGER.debug("Action method: " + method.getName() + " Description:" + description);
							}
							
							// TODO 获取当前登录用户
							try
							{
								ModelSystemLog systemLog = new ModelSystemLog();
								systemLog.setCreatetime(new Date());
								systemLog.setExeOperation(description);
								systemLog.setUserId(1);
								systemLog.setUserName("test");
								
								this.serviceSystemLog.save(systemLog);
							} 
							catch (Exception e)
							{
								LOGGER.error(e.getMessage());
							}
						}
					}
					
					System.out.println("TargetMethod:" + targetMethodName);
					System.out.println("TargetClass:" + targetClass.getName());
				}
			}
		}
	}
	
	public ServiceSystemLog getServiceSystemLog()
	{
		return serviceSystemLog;
	}

	public void setServiceSystemLog(ServiceSystemLog serviceSystemLog)
	{
		this.serviceSystemLog = serviceSystemLog;
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}

}
