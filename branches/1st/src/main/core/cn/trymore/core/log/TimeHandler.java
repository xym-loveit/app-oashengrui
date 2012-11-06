package cn.trymore.core.log;

import java.lang.reflect.Method;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.oa.model.system.ModelSystemLog;
import cn.trymore.oa.service.system.ServiceSystemLog;

public class TimeHandler implements MethodInterceptor {
	private Logger LOGGER = Logger.getLogger(TimeHandler.class);
	/**
	 * The system log service
	 */
	@Resource
	private ServiceSystemLog serviceSystemLog;

	public ServiceSystemLog getServiceSystemLog() {
		return serviceSystemLog;
	}

	public void setServiceSystemLog(ServiceSystemLog serviceSystemLog) {
		this.serviceSystemLog = serviceSystemLog;
	}

	@Override
	public Object invoke(MethodInvocation methodInvocation) throws Throwable {
		// TODO Auto-generated method stub
		String description = "";
		String type = "";
		String ip = "";
		String action = "";
		LOGGER.info(methodInvocation.getArguments()[0] + " 开始执行 "
				+ methodInvocation.getMethod() + " 方法");

		long procTime = System.currentTimeMillis();
		try {
			if (methodInvocation.getMethod().getDeclaringClass() == org.apache.struts.actions.DispatchAction.class) {
				
				Object[] args = methodInvocation.getArguments();
				for (Object arg : args) {
					if (arg instanceof HttpServletRequest) {
						ip = getIpAddr(((HttpServletRequest) arg));
						action = ((HttpServletRequest) arg).getParameter("action");
						break;
					}
				}
				if(action!=null && !"".equals(action)){
					Method method = methodInvocation.getThis().getClass().getDeclaredMethod(action, methodInvocation.getMethod().getParameterTypes());
					boolean isLogAnnotation = method.isAnnotationPresent(LogAnnotation.class);
					if (isLogAnnotation) {
						LogAnnotation logAnnotation = method.getAnnotation(LogAnnotation.class);
						description = logAnnotation.description();
						type = logAnnotation.type();
						if (LOGGER.isDebugEnabled()) {
							LOGGER.debug("Action method: "
									+ action
									+ " Description:" + description+"type:"
									+ type+"\tip:"+ip);
						}
					}
				}
			}
			Object result = methodInvocation.proceed();
			return result;
	}
			finally {

				// 计算执行时间

				procTime = System.currentTimeMillis() - procTime;

				// TODO 获取当前登录用户
				try {
					ModelSystemLog systemLog = new ModelSystemLog();
					systemLog.setCreatetime(new Date());
					systemLog.setExeOperation(type);
					systemLog.getUser().setId(ContextUtil.getCurrentUser().getId());
					systemLog.setUserName(ContextUtil.getCurrentUser()
							.getFullName());
					systemLog.setCost(String.valueOf(procTime));
					systemLog.setIp(ip);
					systemLog.setDetail(description);
					if(this.serviceSystemLog!=null)
						this.serviceSystemLog.save(systemLog);
					else
						System.out.println("servicesystemlog服务注入失败");
				} catch (Exception e) {
					e.printStackTrace();
					LOGGER.error(e.getMessage());
				}
			}
	}

	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

}
