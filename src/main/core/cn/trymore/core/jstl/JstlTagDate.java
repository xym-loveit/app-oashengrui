package cn.trymore.core.jstl;

import java.util.Date;

/**
 * 标签库: 时间标签库
 * 
 * Most of the functionalities copy from UtilDateTime
 *
 */
public class JstlTagDate
{
	/**
	 * 获取时间间隔天数
	 * 
	 * @param startday
	 * @param endday
	 * @return
	 */
	public static Integer getIntervalDays(Date startday,Date endday)
	{
		//分别得到两个时间的毫秒数
		long sl=startday.getTime();
		long el=endday.getTime();
	
		long ei=el-sl;
		
		//根据毫秒数计算间隔天数
		return (int)(ei/(1000*60*60*24));
	}
}
