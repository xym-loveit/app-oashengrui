package org.shengrui.oa.common;

import org.shengrui.oa.utilities.UtilString;

public final class Constants 
{
	
	// file separator
	public static final String FILE_SEPARATOR = "/"; //File.separator;

	// resource of upload folder
	public static final String RES_UPLOAD = "uploads";

	// resource of repository folder
	public static final String RES_REPOSITORY = UtilString.join(new Object[] {
			RES_UPLOAD, "repository" }, FILE_SEPARATOR);

	// prefix of file resource
	public static final String RESOURCE_FILE_PREFIX = System.getProperty("os.name")
			.toUpperCase().indexOf("WINDOWS") > -1 ? "file:/" : "file:";
	
	// resource of WEB-INF
	public static final String RESOURCE_WEB_INF = "WEB-INF";
	
	// prefix of classpath resource
	public static final String RESOURCE_CLASSPATH_PREFIX = "classpath:";
	
	// classpath of urlrewrite 
	public static final String RESOURCE_URLREWRITE = "classpath:urlrw/";
	
	// AJAX request parameter
	public static final String  DefaultAjaxParamFlag = "ajax";
	
	// string cut count
	public static final Integer DefaultEntryShortenTitleLength = 44;
	
	// path holding the uploaded files
	public static final String DefaultFileUploadDir = "uploads";	

	// page query parameter
	public static String  DefaultPageParamFlag = "page";
	
	// page size for admin-platform viewer
	public static final Integer DefaultAdminEntryPageSize  = 10;
	
	// page size for general viewer
	public static final Integer DefaultClientEntryPageSize = 15;
	
	// the parameter name for holding the session user
	public static final String DefaultUsrParamSessionHolder = "SESSION_USR_DATA";
	
	// default face photo image
	public static final String DefaultFaceImg = "resources/images/nophoto.jpg";
	
	// home path of web application
	public static final String WebHomePath = "";
	
	// flag value for the edit-able category
	public static final Integer DefaultEditableCatVal = 1;
	
	// hot category list size
	public static final Integer DefaultHotCategorySize = 5;
	
	// the default parameter of maximum words name
	public static final String DefaultMaxWordsParam = "maxwords";
	
	// the default value of maximum words length
	public static final Integer DefaultMaxWordsLength = 500; 
	
	// the default value of referred parameter
	public static final String DefaultReferParam = "refer";
	
	// parameter for the message show in page
	public static final String DefaultMessageParam	= "msg";
	
	// the default user password
	public static final String DefaultPassword = "lzcp2012"; 
	
	// the default email sender address
	public static final String DefaultMailSender = "lzcp2012@163.com";
}
