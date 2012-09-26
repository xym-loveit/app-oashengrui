package cn.trymore.core.common;

/**
 * The application constants.
 * 
 * @author Jeccy.Zhao
 *
 */
public final class Constants 
{
	
	/**
	 * file separator
	 */
	public static final String FILE_SEPARATOR = "/"; //File.separator;

	/**
	 * resource of upload folder
	 */
	public static final String RES_UPLOAD = "uploads";

	/**
	 * prefix of file resource
	 */
	public static final String RESOURCE_FILE_PREFIX = System.getProperty("os.name")
			.toUpperCase().indexOf("WINDOWS") > -1 ? "file:/" : "file:";
	
	/**
	 * resource of WEB-INF
	 */
	public static final String RESOURCE_WEB_INF = "WEB-INF";
	
	/**
	 * prefix of classpath resource
	 */
	public static final String RESOURCE_CLASSPATH_PREFIX = "classpath:";
	
	/**
	 * classpath of urlrewrite 
	 */
	public static final String RESOURCE_URLREWRITE = "classpath:urlrw/";
	
	/**
	 * AJAX request parameter
	 */
	public static final String  DefaultAjaxParamFlag = "ajax";
	
	/**
	 * string cut count
	 */
	public static final Integer DefaultEntryShortenTitleLength = 44;
	
	/**
	 * path holding the uploaded files
	 */
	public static final String DefaultFileUploadDir = "uploads";	

	/**
	 * page query parameter
	 */
	public static String  DefaultPageParamFlag = "page";
	
	/**
	 * page size for admin-platform viewer
	 */
	public static final Integer DefaultAdminEntryPageSize  = 10;
	
	/**
	 * page size for general viewer
	 */
	public static final Integer DefaultClientEntryPageSize = 15;
	
	/**
	 * the parameter name for holding the session user
	 */
	public static final String DefaultUsrParamSessionHolder = "SESSION_USR_DATA";
	
	/**
	 * default face photo image
	 */
	public static final String DefaultFaceImg = "resources/images/nophoto.jpg";
	
	/**
	 * home path of web application
	 */
	public static final String WebHomePath = "";
	
	/**
	 * flag value for the edit-able category
	 */
	public static final Integer DefaultEditableCatVal = 1;
	
	/**
	 * hot category list size
	 */
	public static final Integer DefaultHotCategorySize = 5;
	
	/**
	 * the default parameter of maximum words name
	 */
	public static final String DefaultMaxWordsParam = "maxwords";
	
	/**
	 * the default value of maximum words length
	 */
	public static final Integer DefaultMaxWordsLength = 500; 
	
	/**
	 * the default value of referred parameter
	 */
	public static final String DefaultReferParam = "refer";
	
	/**
	 * parameter for the message show in page
	 */
	public static final String DefaultMessageParam	= "msg";
	
	/**
	 * the default full date format
	 */
	public static final String DATE_FORMAT_FULL = "yyyy-MM-dd HH:mm:ss";
	
	/**
	 * the default date format of Y-M-D
	 */
	public static final String DATE_FORMAT_YMD = "yyyy-MM-dd";
	
	/**
	 * the default file URL parameter flag.
	 */
	public static final String DefaultFileUrlParam = "fileUrls";
	
	/**
	 * the session key that hold the user id
	 */
	public static final String SESSION_KEY_USER_ID = "SPRING_SECURITY_UID";
	
	/**
	 * the session key that holds the user employee id
	 */
	public static final String SESSION_KEY_USER_EMPID = "SPRING_SECURITY_EMPID";
	
	/**
	 * the session key that holds the user name
	 */
	public static final String SESSION_KEY_USER_NAME = "SPRING_SECURITY_LAST_USERNAME";
	
	/**
	 * the session key that holds the user full name
	 */
	public static final String SESSION_KEY_USER_FULLNAME = "SPRING_SECURITY_LAST_USERNAME";
	
	/**
	 * the session key that holds the user position
	 */
	public static final String SESSION_KEY_USER_POSITION = "POSITION";
	
	/**
	 * the default table alias in Hibernate
	 */
	public static final String DEFAULT_TABLE_ALIAS_IN_HIBERNATE= "this_";
	
}
