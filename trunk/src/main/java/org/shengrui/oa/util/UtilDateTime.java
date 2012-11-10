/*
 * $Id: UtilDateTime.java,v 1.2 2005/01/31 05:27:55 jdon Exp $
 *
 *  Copyright (c) 2001, 2002 The Open For Business Project - www.ofbiz.org
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a
 *  copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sublicense,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 *  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 *  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 *  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
 *  OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
 *  THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package org.shengrui.oa.util;

import java.util.*;
import java.sql.Timestamp;
import java.text.*;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

/**
 * Utility class for handling java.util.Date, the java.sql data/time classes and related information
 *
 * @author     <a href="mailto:jonesde@ofbiz.org">David E. Jones</a>
 * @author     <a href="mailto:jaz@ofbiz.org">Andy Zeneski</a>
 * @version    $Revision: 1.2 $
 * @since      2.0
 */
public class UtilDateTime {
	
	//public static void main(String[] args){
	//	System.out.println(UtilDateTime.nowDateString("yyMMddHHmm"));
	//}
	
	private static String defaultDatePattern = "yyyy-MM-dd";
	
	public static Map<String, Integer> week2int = new HashMap<String, Integer>();
	public static Map<Integer, String> int2week = new HashMap<Integer, String>();
	static{
		week2int.put("周日", 8);
		week2int.put("周一", 2);
		week2int.put("周二", 3);
		week2int.put("周三", 4);
		week2int.put("周四", 5);
		week2int.put("周五", 6);
		week2int.put("周六", 7);
		
		int2week.put(0, "周日");
		int2week.put(1, "周一");
		int2week.put(2, "周二");
		int2week.put(3, "周三");
		int2week.put(4, "周四");
		int2week.put(5, "周五");
		int2week.put(6, "周六");
	}
	
    /** Return a Timestamp for right now
     * @return Timestamp for right now
     */
    public static java.sql.Timestamp nowTimestamp() {
        return new java.sql.Timestamp(System.currentTimeMillis());
    }
    
    public static String nowDateString(){
    	return nowDateString(defaultDatePattern);
    }
    
    public static String nowDateString(String pattern){
    	return new SimpleDateFormat(pattern).format(nowDate());
    }
    
    public static String dateString(Date date){
    	return toDateString(date, defaultDatePattern);
    }
    
    public static String toDateString(Date date, String pattern){
    	return new SimpleDateFormat(pattern).format(date);
    }
    
    /** Return a Date for right now
     * @return Date for right now
     */
    public static java.util.Date nowDate() {
        return new java.util.Date();
    }
    
    public static int getIntervalDays(Calendar startday,Calendar endday){
		return getIntervalDays(startday.getTime(), endday.getTime());
	}
    
    public static int getIntervalDays(Date startday,Date endday){
		//确保startday在endday之前
		if(startday.after(endday)){
			Date cal=startday;
			startday=endday;
			endday=cal;
		}
		//分别得到两个时间的毫秒数
		long sl=startday.getTime();
		long el=endday.getTime();
	
		long ei=el-sl;
		//根据毫秒数计算间隔天数
		return (int)(ei/(1000*60*60*24));
	}
    
    public static java.sql.Timestamp getDayStart(java.sql.Timestamp stamp) {
        return getDayStart(stamp, 0);
    }
    
    /**
     * 
     * @param week
     * @param startDate
     * @param endDate
     * @return
     * @author Zhao.Xiang
     */
    public static List<Date> getDatesByWeekInDateRange(String week, Integer count, Date startDate, Date endDate){
    	if(startDate.after(endDate)){
    		Date tmp = startDate;
    		startDate = endDate;
    		endDate = tmp;
    	}
    	Calendar clStart = Calendar.getInstance();
    	clStart.setTime(startDate);
    	Calendar clEnd = Calendar.getInstance();
    	clEnd.setTime(endDate);
    	return getDatesByWeekInDateRange(week, count, 7, clStart, clEnd);
    }
    
    /**
     * 
     * @param week
     * @param startDate
     * @param endDate
     * @return;
     * @author Zhao.Xiang
     */
    public static List<Date> getDatesByWeekInDateRange(String week, Integer count, int weekSeed, Calendar startDate, Calendar endDate){
    	if(startDate.after(endDate)){
    		Calendar tmp = startDate;
    		startDate = endDate;
    		endDate = tmp;
    	}
    	List<Date> dates = new ArrayList<Date>();
    	int ct = 0;
    	int cweekDay = week2int.get(week);
    	int sweekDay = startDate.get(Calendar.DAY_OF_WEEK);
    	//int eweekDay = endDate.get(Calendar.DAY_OF_WEEK);
    	int offset = getIntervalDays(startDate, endDate);
    	
    	if(offset == 0){
    		if(cweekDay == sweekDay){
    			
    		}
    	}else{
    		Calendar clop = startDate;
    		int oftday = (clop.get(Calendar.DAY_OF_WEEK) == 1 ? 8 : clop.get(Calendar.DAY_OF_WEEK)) - week2int.get(week);
    		oftday = oftday % 8 > 0 ? Math.abs(oftday - 7) : oftday;
//    		System.out.println(oftday);
    		clop.add(Calendar.DAY_OF_WEEK, Math.abs(oftday));
    		if(!clop.after(endDate)){
    			dates.add(clop.getTime());
//    			System.out.println(toDateString(clop.getTime()));
    			ct++;
    		}
    		//while(ct < count){
    		while(count != null ? (ct < count) : true){
    			clop.add(Calendar.DAY_OF_WEEK, weekSeed);
    			if(clop.after(endDate)){
    				break;
    			}
    			dates.add(clop.getTime());
//    			System.out.println(toDateString(clop.getTime()));
    			ct++;
    		}
    	}
    	return dates;
    }
    /**
     * 
     * @param week
     * @param startDate
     * @param endDate
     * @return;
     * @author Zhao.Xiang
     */
    public static List<Date> getDatesDateRange(Date startDate, Date endDate){
    	
    	List<Date> dates = new ArrayList<Date>();
    	int offset = getIntervalDays(startDate, endDate);  	
    	if(offset==0){
    		dates.add(startDate);
    		return dates;
    	}
    	for(int i=0;i<=offset;i++){
    		Calendar calendar= Calendar.getInstance();
    		calendar.setTime(startDate);
    		calendar.add(Calendar.DATE, i);
    		dates.add(calendar.getTime());
    	}
    	return dates;
    }
    
   public static List<String> getWeeksStringDateRange(Date startDate, Date endDate){
    	
    	List<String> dates = new ArrayList<String>();
    	int offset = getIntervalDays(startDate, endDate);  	
    	if(offset==0){
    		return dates;
    	}
    	Date temp=startDate;
    	for(int i=7;i<=offset;i=i+7){
    		Calendar calendar= Calendar.getInstance();
    		calendar.setTime(temp);
    		calendar.add(Calendar.DATE, 7);
    		dates.add(UtilDateTime.toDateString(temp)+"--"+UtilDateTime.toDateString(calendar.getTime()));
    		temp=calendar.getTime();

    	}
    	return dates;
    }
    
    
    public static java.sql.Timestamp getDayStart(java.sql.Timestamp stamp, int daysLater) {
        Calendar tempCal = Calendar.getInstance();

        tempCal.setTime(new java.util.Date(stamp.getTime()));
        tempCal.set(tempCal.get(Calendar.YEAR), tempCal.get(Calendar.MONTH), tempCal.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
        tempCal.add(Calendar.DAY_OF_MONTH, daysLater);
        return new java.sql.Timestamp(tempCal.getTime().getTime());
    }

    public static java.sql.Timestamp getNextDayStart(java.sql.Timestamp stamp) {
        return getDayStart(stamp, 1);
    }

    public static java.sql.Timestamp getDayEnd(java.sql.Timestamp stamp) {
        return getDayEnd(stamp, 0);
    }

    public static java.sql.Timestamp getDayEnd(java.sql.Timestamp stamp, int daysLater) {
        Calendar tempCal = Calendar.getInstance();

        tempCal.setTime(new java.util.Date(stamp.getTime()));
        tempCal.set(tempCal.get(Calendar.YEAR), tempCal.get(Calendar.MONTH), tempCal.get(Calendar.DAY_OF_MONTH), 23, 59, 59);
        tempCal.add(Calendar.DAY_OF_MONTH, daysLater);
        return new java.sql.Timestamp(tempCal.getTime().getTime());
    }

    /** Converts a date String into a java.sql.Date
     * @param date The date String: MM/DD/YYYY
     * @return A java.sql.Date made from the date String
     */
    public static java.sql.Date toSqlDate(String date) {
        java.util.Date newDate = toDate(date, "00:00:00");

        if (newDate != null)
            return new java.sql.Date(newDate.getTime());
        else
            return null;
    }

    /** Makes a java.sql.Date from separate Strings for month, day, year
     * @param monthStr The month String
     * @param dayStr The day String
     * @param yearStr The year String
     * @return A java.sql.Date made from separate Strings for month, day, year
     */
    public static java.sql.Date toSqlDate(String monthStr, String dayStr, String yearStr) {
        java.util.Date newDate = toDate(monthStr, dayStr, yearStr, "0", "0", "0");

        if (newDate != null)
            return new java.sql.Date(newDate.getTime());
        else
            return null;
    }

    /** Makes a java.sql.Date from separate ints for month, day, year
     * @param month The month int
     * @param day The day int
     * @param year The year int
     * @return A java.sql.Date made from separate ints for month, day, year
     */
    public static java.sql.Date toSqlDate(int month, int day, int year) {
        java.util.Date newDate = toDate(month, day, year, 0, 0, 0);

        if (newDate != null)
            return new java.sql.Date(newDate.getTime());
        else
            return null;
    }

    /** Converts a time String into a java.sql.Time
     * @param time The time String: either HH:MM or HH:MM:SS
     * @return A java.sql.Time made from the time String
     */
    public static java.sql.Time toSqlTime(String time) {
        java.util.Date newDate = toDate("1/1/1970", time);

        if (newDate != null)
            return new java.sql.Time(newDate.getTime());
        else
            return null;
    }

    /** Makes a java.sql.Time from separate Strings for hour, minute, and second.
     * @param hourStr The hour String
     * @param minuteStr The minute String
     * @param secondStr The second String
     * @return A java.sql.Time made from separate Strings for hour, minute, and second.
     */
    public static java.sql.Time toSqlTime(String hourStr, String minuteStr, String secondStr) {
        java.util.Date newDate = toDate("0", "0", "0", hourStr, minuteStr, secondStr);

        if (newDate != null)
            return new java.sql.Time(newDate.getTime());
        else
            return null;
    }

    /** Makes a java.sql.Time from separate ints for hour, minute, and second.
     * @param hour The hour int
     * @param minute The minute int
     * @param second The second int
     * @return A java.sql.Time made from separate ints for hour, minute, and second.
     */
    public static java.sql.Time toSqlTime(int hour, int minute, int second) {
        java.util.Date newDate = toDate(0, 0, 0, hour, minute, second);

        if (newDate != null)
            return new java.sql.Time(newDate.getTime());
        else
            return null;
    }

    /** Converts a date and time String into a Timestamp
     * @param dateTime A combined data and time string in the format "MM/DD/YYYY HH:MM:SS", the seconds are optional
     * @return The corresponding Timestamp
     */
    public static java.sql.Timestamp toTimestamp(String dateTime) {
        java.util.Date newDate = toDate(dateTime);

        if (newDate != null)
            return new java.sql.Timestamp(newDate.getTime());
        else
            return null;
    }

    /** Converts a date String and a time String into a Timestamp
     * @param date The date String: MM/DD/YYYY
     * @param time The time String: either HH:MM or HH:MM:SS
     * @return A Timestamp made from the date and time Strings
     */
    public static java.sql.Timestamp toTimestamp(String date, String time) {
        java.util.Date newDate = toDate(date, time);

        if (newDate != null)
            return new java.sql.Timestamp(newDate.getTime());
        else
            return null;
    }

    /** Makes a Timestamp from separate Strings for month, day, year, hour, minute, and second.
     * @param monthStr The month String
     * @param dayStr The day String
     * @param yearStr The year String
     * @param hourStr The hour String
     * @param minuteStr The minute String
     * @param secondStr The second String
     * @return A Timestamp made from separate Strings for month, day, year, hour, minute, and second.
     */
    public static java.sql.Timestamp toTimestamp(String monthStr, String dayStr, String yearStr, String hourStr,
        String minuteStr, String secondStr) {
        java.util.Date newDate = toDate(monthStr, dayStr, yearStr, hourStr, minuteStr, secondStr);

        if (newDate != null)
            return new java.sql.Timestamp(newDate.getTime());
        else
            return null;
    }

    /** Makes a Timestamp from separate ints for month, day, year, hour, minute, and second.
     * @param month The month int
     * @param day The day int
     * @param year The year int
     * @param hour The hour int
     * @param minute The minute int
     * @param second The second int
     * @return A Timestamp made from separate ints for month, day, year, hour, minute, and second.
     */
    public static java.sql.Timestamp toTimestamp(int month, int day, int year, int hour, int minute, int second) {
        java.util.Date newDate = toDate(month, day, year, hour, minute, second);

        if (newDate != null)
            return new java.sql.Timestamp(newDate.getTime());
        else
            return null;
    }

    /** Converts a date and time String into a Date
     * @param dateTime A combined data and time string in the format "MM/DD/YYYY HH:MM:SS", the seconds are optional
     * @return The corresponding Date
     */
    public static java.util.Date toDate(String dateTime) {
        // dateTime must have one space between the date and time...
        String date = dateTime.substring(0, dateTime.indexOf(" "));
        String time = dateTime.substring(dateTime.indexOf(" ") + 1);

        return toDate(date, time);
    }
    
    public static java.util.Date toDateByPattern(String dateTime) {
    	return toDateByPattern(dateTime, defaultDatePattern);
    }
    
    public static java.util.Date toDateByPattern(String dateTime, String pattern) {
    	if(dateTime == null || "".equals(dateTime) || "null".equalsIgnoreCase(dateTime))return null;
    	SimpleDateFormat sdf = new SimpleDateFormat(pattern);
    	try {
			return sdf.parse(dateTime);
		} catch (ParseException e) {
			//e.printStackTrace();
			return null;
		}
    }
    /** Converts a date String and a time String into a Date
     * @param date The date String: MM/DD/YYYY
     * @param time The time String: either HH:MM or HH:MM:SS
     * @return A Date made from the date and time Strings
     */
    public static java.util.Date toDate(String date, String time) {
        if (date == null || time == null) return null;
        String month;
        String day;
        String year;
        String hour;
        String minute;
        String second;

        int dateSlash1 = date.indexOf("-");
        int dateSlash2 = date.lastIndexOf("-");

        if (dateSlash1 <= 0 || dateSlash1 == dateSlash2) return null;
        int timeColon1 = time.indexOf(":");
        int timeColon2 = time.lastIndexOf(":");

        if (timeColon1 <= 0) return null;
        month = date.substring(0, dateSlash1);
        day = date.substring(dateSlash1 + 1, dateSlash2);
        year = date.substring(dateSlash2 + 1);
        hour = time.substring(0, timeColon1);

        if (timeColon1 == timeColon2) {
            minute = time.substring(timeColon1 + 1);
            second = "0";
        } else {
            minute = time.substring(timeColon1 + 1, timeColon2);
            second = time.substring(timeColon2 + 1);
        }

        return toDate(month, day, year, hour, minute, second);
    }

    /** Makes a Date from separate Strings for month, day, year, hour, minute, and second.
     * @param monthStr The month String
     * @param dayStr The day String
     * @param yearStr The year String
     * @param hourStr The hour String
     * @param minuteStr The minute String
     * @param secondStr The second String
     * @return A Date made from separate Strings for month, day, year, hour, minute, and second.
     */
    public static java.util.Date toDate(String monthStr, String dayStr, String yearStr, String hourStr,
        String minuteStr, String secondStr) {
        int month, day, year, hour, minute, second;

        try {
            month = Integer.parseInt(monthStr);
            day = Integer.parseInt(dayStr);
            year = Integer.parseInt(yearStr);
            hour = Integer.parseInt(hourStr);
            minute = Integer.parseInt(minuteStr);
            second = Integer.parseInt(secondStr);
        } catch (Exception e) {
            return null;
        }
        return toDate(month, day, year, hour, minute, second);
    }

    /** Makes a Date from separate ints for month, day, year, hour, minute, and second.
     * @param month The month int
     * @param day The day int
     * @param year The year int
     * @param hour The hour int
     * @param minute The minute int
     * @param second The second int
     * @return A Date made from separate ints for month, day, year, hour, minute, and second.
     */
    public static java.util.Date toDate(int month, int day, int year, int hour, int minute, int second) {
        Calendar calendar = Calendar.getInstance();

        try {
            calendar.set(year, month - 1, day, hour, minute, second);
        } catch (Exception e) {
            return null;
        }
        return new java.util.Date(calendar.getTime().getTime());
    }

    /** Makes a date String in the format MM/DD/YYYY from a Date
     * @param date The Date
     * @return A date String in the format MM/DD/YYYY
     */
    public static String toDateString(java.util.Date date) {
        if (date == null) return "";
        Calendar calendar = Calendar.getInstance();

        calendar.setTime(date);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        int year = calendar.get(Calendar.YEAR);
        String monthStr;
        String dayStr;
        String yearStr;

        if (month < 10) {
            monthStr = "0" + month;
        } else {
            monthStr = "" + month;
        }
        if (day < 10) {
            dayStr = "0" + day;
        } else {
            dayStr = "" + day;
        }
        yearStr = "" + year;
        return yearStr + "-" + monthStr + "-" + dayStr; // + "-" + yearStr;
    }

    /** Makes a time String in the format HH:MM:SS from a Date. If the seconds are 0, then the output is in HH:MM.
     * @param date The Date
     * @return A time String in the format HH:MM:SS or HH:MM
     */
    public static String toTimeString(java.util.Date date) {
        if (date == null) return "";
        Calendar calendar = Calendar.getInstance();

        calendar.setTime(date);
        return (toTimeString(calendar.get(Calendar.HOUR_OF_DAY), calendar.get(Calendar.MINUTE), calendar.get(Calendar.SECOND)));
    }

    /** Makes a time String in the format HH:MM:SS from a separate ints for hour, minute, and second. If the seconds are 0, then the output is in HH:MM.
     * @param hour The hour int
     * @param minute The minute int
     * @param second The second int
     * @return A time String in the format HH:MM:SS or HH:MM
     */
    public static String toTimeString(int hour, int minute, int second) {
        String hourStr;
        String minuteStr;
        String secondStr;

        if (hour < 10) {
            hourStr = "0" + hour;
        } else {
            hourStr = "" + hour;
        }
        if (minute < 10) {
            minuteStr = "0" + minute;
        } else {
            minuteStr = "" + minute;
        }
        if (second < 10) {
            secondStr = "0" + second;
        } else {
            secondStr = "" + second;
        }
        if (second == 0)
            return hourStr + ":" + minuteStr;
        else
            return hourStr + ":" + minuteStr + ":" + secondStr;
    }

    /** Makes a combined data and time string in the format "MM/DD/YYYY HH:MM:SS" from a Date. If the seconds are 0 they are left off.
     * @param date The Date
     * @return A combined data and time string in the format "MM/DD/YYYY HH:MM:SS" where the seconds are left off if they are 0.
     */
    public static String toDateTimeString(java.util.Date date) {
        if (date == null) return "";
        String dateString = toDateString(date);
        String timeString = toTimeString(date);

        if (dateString != null && timeString != null)
            return dateString + " " + timeString;
        else
            return "";
    }

    /** Makes a Timestamp for the beginning of the month
     * @return A Timestamp of the beginning of the month
     */
    public static java.sql.Timestamp monthBegin() {
        Calendar mth = Calendar.getInstance();

        mth.set(Calendar.DAY_OF_MONTH, 1);
        mth.set(Calendar.HOUR_OF_DAY, 0);
        mth.set(Calendar.MINUTE, 0);
        mth.set(Calendar.SECOND, 0);
        mth.set(Calendar.AM_PM, Calendar.AM);
        return new java.sql.Timestamp(mth.getTime().getTime());
    }
    
    private static final char[] zeroArray = "0000000000000000".toCharArray();
    
    public static final String zeroPadString(String string, int length) {
        if (string == null || string.length() > length) {
            return string;
        }
        StringBuffer buf = new StringBuffer(length);
        buf.append(zeroArray, 0, length-string.length()).append(string);
        return buf.toString();
     }
    
     /**
      * save the datetime of System.currentTimeMillis() to
      * dtatbase persistence.
      * @param now
      * @return
      */     
     public static final String dateToMillis(long now) {
        return zeroPadString(Long.toString(now), 15);
     }        

    /**
     * datetime is the String of System.currentTimeMillis()
     * 返回标准中国（缺省）的时间显示格�?
     *
     */
    public static String getDateTimeDisp(String datetime) {
      if ((datetime == null) || (datetime.equals("")))
        return "";

      DateFormat formatter
          = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM);
      long datel = Long.parseLong(datetime);
      return formatter.format(new Date(datel));

    }
    
    /**
     * 
     * @param date
     * @param daySeed
     * @return
     */
    public static Date geDay(Date date, int daySeed){
    	Calendar calendar = Calendar.getInstance();
    	calendar.setTime(date);
    	calendar.add(Calendar.DAY_OF_MONTH, daySeed);
    	String dstr = toDateString(calendar.getTime());
 		return Timestamp.valueOf(dstr + " 00:00:00");
 		//return calendar.getTime();
    }
    
    /**
     * 
     * @param date
     * @param weekString
     * @return
     */
    public static Date getDayByWeekString(Date date, String weekString){
    	return getDayByWeekString(date, weekString, false);
    }
    
    /**
     * 
     * @param date
     * @param weekString
     * @return
     */
    public static Date getDayByWeekString(Date date, String weekString, Boolean byAdd){
    	if(week2int.containsKey(weekString) && date != null){
    		Calendar calendar = Calendar.getInstance();
        	calendar.setTime(date);
        	if (byAdd) {
        		calendar.add(Calendar.DAY_OF_MONTH, 1);
        	}
        	int intWeek = calendar.get(Calendar.DAY_OF_WEEK) == 1 ? 8 : calendar.get(Calendar.DAY_OF_WEEK);
        	while(true){
 	        	if(intWeek == week2int.get(weekString)){
 	        		String dstr = toDateString(calendar.getTime());
 	        		return Timestamp.valueOf(dstr + " 00:00:00");
	        		//return calendar.getTime();
	        	}
	        	calendar.add(Calendar.DAY_OF_MONTH, 1);
	        	intWeek = calendar.get(Calendar.DAY_OF_WEEK) == 1 ? 8 : calendar.get(Calendar.DAY_OF_WEEK);
        	}
    	}
    	return null;
    }
    
    /**
     * 
     * @param weekOffset
     * @return
     */
    public static List<String> getWeekDates(int weekOffset) {
    	return getWeekDates(weekOffset, "yyyy-MM-dd");
    }
    
    /**
     * 
     * @param weekNumOff
     * @return
     */
    @SuppressWarnings("deprecation")
	public static List<String> getWeekDates(int weekOffset, String pattern) {
		List<String> list = new ArrayList<String>();
		int dateNumOff = weekOffset * 7;
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		Date now = new Date();
		int day = now.getDay();
		if (day == 0)
			day = 7;
		for (int i = 1; i <= 7; i++) {
			Date tmpDate = new Date(now.getYear(), now.getMonth(), now
					.getDate()
					- day + i + dateNumOff);
			list.add(sdf.format(tmpDate));
		}
		return list;

	}
    public static String monthBeginDate(int year,int month) {
    	 Calendar mth = Calendar.getInstance();
    	 mth.set(Calendar.YEAR,year);
    	 mth.set(Calendar.MONTH,month-1);
         mth.set(Calendar.DAY_OF_MONTH, 1);
     	return (new SimpleDateFormat("yyyy-MM-dd").format(mth.getTime()));
    }
    public static String monthEndDate(int year,int month) {
    	Calendar mth = Calendar.getInstance();
    	mth.set(Calendar.YEAR,year);
    	mth.set(Calendar.MONTH,month-1);
        mth.set(Calendar.DAY_OF_MONTH, 1);
        mth.add(Calendar.MONTH,1);//月增加1天
        mth.add(Calendar.DAY_OF_MONTH,-1);//日期倒数一日,既得到本月最后一天
        return(new SimpleDateFormat("yyyy-MM-dd").format(mth.getTime()));
   }
    public static int currentYear() {
   	 Calendar mth = Calendar.getInstance();
   	 return (mth.get(Calendar.YEAR));
   }
    public static int currentMonth() {
      	 Calendar mth = Calendar.getInstance();
      	 return (mth.get(Calendar.MONTH)+1);
      }
    
    public static String getDateWeekStr(Date date){
    	if(date!=null){
    		Calendar calendar = Calendar.getInstance();
    		calendar.setTime(date);
    		return UtilDateTime.int2week.get(calendar.get(Calendar.DAY_OF_WEEK)-1);
    	}
    	return null;
    }
    
    @SuppressWarnings("deprecation")
	public static String getDateWeekStr (String dateStr) {
    	if (StringUtils.isNotEmpty(dateStr)) {
    		return UtilDateTime.int2week.get(UtilDateTime.toDateByPattern(dateStr).getDay());
    	}
    	return null;
    }
	/**
	 * 本周周一日期
	 */
	public static String currentWeekBeginDate(){
		Calendar mth = Calendar.getInstance();
		mth.set(mth.get(Calendar.YEAR),mth.get(Calendar.MONTH), mth.get(Calendar.DAY_OF_MONTH)-(mth.get(Calendar.DAY_OF_WEEK)+6)%7+1);
		return (new SimpleDateFormat("yyyy-MM-dd").format(mth.getTime()));
	}
	/**
	 * 本周周末日期
	 */
	public static String currentWeekEndDate(){
		Calendar mth = Calendar.getInstance();
		mth.set(mth.get(Calendar.YEAR),mth.get(Calendar.MONTH), mth.get(Calendar.DAY_OF_MONTH)-(mth.get(Calendar.DAY_OF_WEEK)+6)%7+7);
		return (new SimpleDateFormat("yyyy-MM-dd").format(mth.getTime()));
	}
	
	/**
	 * ate所在周的周一日期
	 * @param date
	 * @return
	 */
	public static String currentWeekBeginDate(Date date){
		Calendar mth = Calendar.getInstance();
		mth.setTime(date);
		mth.set(mth.get(Calendar.YEAR),mth.get(Calendar.MONTH), mth.get(Calendar.DAY_OF_MONTH)-(mth.get(Calendar.DAY_OF_WEEK)+6)%7+1);
		return (new SimpleDateFormat("yyyy-MM-dd").format(mth.getTime()));
	}
	/**
	 * date所在周的周末日期
	 * @param date
	 * @return
	 */
	public static String currentWeekEndDate(Date date){
		Calendar mth = Calendar.getInstance();
		mth.setTime(date);
		mth.set(mth.get(Calendar.YEAR),mth.get(Calendar.MONTH), mth.get(Calendar.DAY_OF_MONTH)-(mth.get(Calendar.DAY_OF_WEEK)+6)%7+7);
		return (new SimpleDateFormat("yyyy-MM-dd").format(mth.getTime()));
	}
	
    /**
     * 
     * @param start1
     * @param end1
     * @param start2
     * @param end2
     */
    public static boolean hasInter(Date start1, Date end1, Date start2, Date end2) {
    	if (start1 != null && end1 != null && start2 != null && end2 != null) {
	    	if (start1.compareTo(start2) < 0 && start2.compareTo(end1) < 0) {
	    		return true;
	    	}
	    	
	    	if (start1.compareTo(end2) < 0 && end2.compareTo(end1) < 0) {
	    		return true;
	    	}
	    	
	    	if (start2.compareTo(start1) < 0 && end1.compareTo(end2) < 0) {
	    		return true;
	    	}
    	}
    	return false;
    }
    
    public static void main(String[] args){
    	
//    	System.out.println(UtilDateTime.nowDateString("yyMMddHHmmssSS"));
//    	System.out.println(UtilDateTime.getDayByMonthSeed(new Date(),-1).toLocaleString());
    	
    	//System.out.println(UtilDateTime.int2week.get(UtilDateTime.toDateByPattern("2010-01-20").getDay()));
    	//
//    	System.out.println(UtilDateTime.monthBeginDate(2010, 11));
//    	System.out.println(UtilDateTime.monthEndDate(2010, 11));
//    	System.out.println(UtilDateTime.currentYear());
//    	System.out.println(UtilDateTime.getYearMonthAfterAddMonth(-1));
    	//System.out.println(UtilDateTime.toDateString(Timestamp.valueOf("2010-08-20 00:00:00")));
    	//System.out.println(UtilDateTime.toDate("2010-5-21"));
    	//System.out.println(UtilDateTime.toDateString(UtilDateTime.geDay(new Date(), 8)));
    	//System.out.println(
    	//		UtilDateTime.getDayByWeekString(new Date(),"周四"));
//    	Calendar cd1 = Calendar.getInstance();
//    	cd1.setTime(new Date());
////    	cd1.add(Calendar.DAY_OF_WEEK, );
//    	Calendar cd2 = Calendar.getInstance();
//    	cd2.setTime(new Date());
//    	cd2.add(Calendar.DAY_OF_WEEK, 90);
//    	UtilDateTime.getDatesByWeekInDateRange("周六",5,7,cd1,cd2);
//    	getWeeksStringRange(2012,2);
//    	System.out.println(UtilDateTime.getHours("08:55","12:55"));
    	System.out.println(UtilDateTime.currentWeekBeginDate());
    	System.out.println(UtilDateTime.currentWeekEndDate());
    }

	public static String getYearMonthAfterAddMonth(int monthOffset) {
		// TODO Auto-generated method stub
		Calendar mth = Calendar.getInstance();
		mth.set(Calendar.YEAR,UtilDateTime.currentYear());
    	mth.set(Calendar.MONTH,UtilDateTime.currentMonth()-1);
    	mth.add(Calendar.MONTH, monthOffset);
		return mth.get(Calendar.YEAR)+"-"+(mth.get(Calendar.MONTH)+1);
	}
	 
    /**
     * 
     * @param date
     * @param daySeed
     * @return
     */
    public static Date getDayByMonthSeed(Date date, int monthSeed){
    	Calendar calendar = Calendar.getInstance();
    	calendar.setTime(date);
    	calendar.add(Calendar.MONTH, monthSeed);
    	String dstr = toDateString(calendar.getTime());
 		return Timestamp.valueOf(dstr + " 00:00:00");
 		//return calendar.getTime();
    }
    
    /**
     * 
     * @param date
     * @param daySeed
     * @return
     */
    @SuppressWarnings("deprecation")
	public static List<Date> getDaysByDayBetweenRanges(Date beginDate,Date endDate, int day){
    	List<Date> result = new ArrayList<Date>();
    	List<Date> list=getDatesDateRange(beginDate,endDate);
    	if(list!=null&&list.size()>0){
    		for(Date date:list){
    			if(date.getDay()==day){
    				result.add(date);
    			}
    		}
    	}
    	return result;
    }

	public static Double getHours(String beginTime, String endTime) {
		// TODO Auto-generated method stub
		String beginTimeHour=beginTime.split(":")[0];
		String beginTimeMinute=beginTime.split(":")[1];
		String endTimeHour=endTime.split(":")[0];
		String endTimeMinute=endTime.split(":")[1];
		
		return ((Integer.parseInt(endTimeHour)*60+Integer.parseInt(endTimeMinute))-(Integer.parseInt(beginTimeHour)*60+Integer.parseInt(beginTimeMinute)))/60.0;
	}
	//判断两个时间区间是否有交集，时间格式为08:00-10:00
	public static Boolean hasIntersection(String timeArea1, String timeArea2) {
		// TODO Auto-generated method stub
		String a1=timeArea1.split("-")[0];
		String a2=timeArea1.split("-")[1];
		String b1=timeArea2.split("-")[0];
		String b2=timeArea2.split("-")[1];
		
		if(b2.compareTo(a1)<=0||b1.compareTo(a2)>=0)return false;
		else return true;
	}
	
   @SuppressWarnings("deprecation")
   public static List<String> getWeeksStringRange(int year, int month){
    	
    	List<String> dates = new ArrayList<String>();
    	Calendar calendar= Calendar.getInstance();
    	Date temp=new Date(year-1900,month-1,1);    	
    	calendar.setTime(temp);
    	//14天内,必然出现星期一到星期天
        for (int i= 1; i < 15; i++){
        	calendar.set(Calendar.DAY_OF_MONTH,i);
            if(calendar.get(Calendar.DAY_OF_WEEK) == 2){
            	calendar.get(Calendar.DAY_OF_MONTH);
                break;
           }
        } 
    	String endDate=monthEndDate(year,month);
    	String startDate=UtilDateTime.toDateString(calendar.getTime());
    	while(startDate.compareTo(endDate)<=0)
    	{
    		calendar.add(Calendar.DATE, 6);
    		dates.add(startDate+"--"+UtilDateTime.toDateString(calendar.getTime()));
    		calendar.add(Calendar.DATE, 1);
    		startDate=UtilDateTime.toDateString(calendar.getTime());
    	}
    	return dates;
    }
   
   public static String getTimeBetweenDates(Date sDate,Date eDate){
	   long l=eDate.getTime()-sDate.getTime();
	   long day=l/(24*60*60*1000);
	   long hour=(l/(60*60*1000)-day*24);
	   long min=((l/(60*1000))-day*24*60-hour*60);
	   long s=(l/1000-day*24*60*60-hour*60*60-min*60);
	   return ""+day+"天"+hour+"小时"+min+"分"+s+"秒";
   }
   
   public static Date addDays(Date date,int days){
	   Calendar calendar= Calendar.getInstance();
	   calendar.setTime(date);
	   calendar.add(Calendar.DATE, days);
	   return calendar.getTime();
   }
   
   public static String formatDate2Str(Date date){
	   return (new SimpleDateFormat("yyyy-MM-dd").format(date));
   }
   
   public static int calculateYears(Date date){
	   Date now = new Date();
	   long y = now.getTime() - date.getTime();
	   long year = y/(24*60*60*1000*365);
	   return (int) (year > 0 ? year : 0);
   }
   
   public static boolean compareTime(String time1,String time2,String pattern) throws ParseException{
	   SimpleDateFormat format = new SimpleDateFormat(pattern);
	   Date d1 = null;
	   Date d2 = null;
	   d1 = format.parse(time1);
	   d2 = format.parse(time2);

	   return d1.before(d2);
   }
   
   public static String getTimeField(Date day,int field){
	   if(day == null)return null;
	   Calendar c = Calendar.getInstance();
	   c.setTime(day);
	   return c.get(field)<10?"0"+c.get(field):""+c.get(field);
   }
   
}
