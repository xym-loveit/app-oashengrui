package cn.trymore.core.util;

import java.util.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class UtilDate {
	
	public UtilDate(){}
	
	private static String defaultDatePattern = "yyyy-MM-dd HH:mm";
	private static SimpleDateFormat defaultFormatter = new SimpleDateFormat(defaultDatePattern);
	
	public static String getDatePattern(){
		return defaultDatePattern;
	}
	
	public static SimpleDateFormat getDefaultDateFormatter(){
		return defaultFormatter;
	}
	
	public static Timestamp getNowTime(){
		return new Timestamp(new java.util.Date().getTime());
	}
	
	public static String parseTime(Date date) {
		return new SimpleDateFormat(defaultDatePattern).format(date);
	}
	
	public static String parseTime(Date date, String pattern) {
		return new SimpleDateFormat(pattern).format(date);
	}
	
	public static String parseTime(Timestamp time){
		return getDefaultDateFormatter().format(new java.sql.Date(time.getTime()));
	}
	
	public static Date getMonthTime(java.util.Date date){
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
		cal.set(Calendar.HOUR_OF_DAY, cal.getActualMinimum(Calendar.HOUR_OF_DAY));
		cal.set(Calendar.MINUTE, cal.getActualMinimum(Calendar.MINUTE));
		cal.set(Calendar.SECOND, cal.getActualMinimum(Calendar.SECOND));
		cal.set(Calendar.MILLISECOND, cal.getActualMinimum(Calendar.MILLISECOND));
		return cal.getTime();
	}
	
	/**
	 * 
	 * @param date
	 * @return
	 */
	public static Integer getCurrentYear(){
		return Calendar.getInstance().get(Calendar.YEAR);
	}
	
	/**
	 * 
	 * @param date
	 * @return
	 */
	public static Integer getCurrentMonth(){
		return Calendar.getInstance().get(Calendar.MONTH) + 1;
	}
	
	/**
	 * 
	 * @param date
	 * @return
	 */
	public static Integer getCurrentDay(){
		return Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
	}
	
	
	/**
     * get the date's month start time.
     * @param date
     * @return
     * @author <a href="mailto:rory.cn@gmail.com">somebody</a>
     */
	public static Date getMonthStartTime(Date date){
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
		cal.set(Calendar.HOUR_OF_DAY, cal.getActualMinimum(Calendar.HOUR_OF_DAY));
		cal.set(Calendar.MINUTE, cal.getActualMinimum(Calendar.MINUTE));
		cal.set(Calendar.SECOND, cal.getActualMinimum(Calendar.SECOND));
		cal.set(Calendar.MILLISECOND, cal.getActualMinimum(Calendar.MILLISECOND));
		return cal.getTime();
	}
	
	/**
	 * get the date's month end time.
	 * @param date
	 * @return
	 * @author <a href="mailto:rory.cn@gmail.com">somebody</a>
	 */
	public static Date getMonthEndTime(Date date){
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		cal.set(Calendar.HOUR_OF_DAY, cal.getActualMaximum(Calendar.HOUR_OF_DAY));
		cal.set(Calendar.MINUTE, cal.getActualMaximum(Calendar.MINUTE));
		cal.set(Calendar.SECOND, cal.getActualMaximum(Calendar.SECOND));
		cal.set(Calendar.MILLISECOND, cal.getActualMaximum(Calendar.MILLISECOND));
		return cal.getTime();
	}
	
	public static void main(String[] args){
		System.out.println(UtilDate.getCurrentYear());
		System.out.println(UtilDate.parseTime(new Date(), "HH:mm:ss"));
	}
	
}
