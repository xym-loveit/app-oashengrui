package cn.trymore.core.util;

import java.io.IOException;

/**
 * 
 * @author Jeccy.Zhao
 *
 */
public class UtilNative2Ascii {
	
	public static String JAVA_HOME = System.getenv("JAVA_HOME");
	
	public static String ASCII_Encoding = "UTF-8";
	
	public static String GBK_Encoding = "UTF-8";
	
	public static String NASC_PATH = JAVA_HOME + "\\bin\\native2ascii.exe";
	
	public static String NASC2ASCII_CMD = NASC_PATH + " -encoding " + ASCII_Encoding;
	
	public static String ASCII2NASC_CMD = NASC_PATH + " -reverse -encoding " + GBK_Encoding;
	
	public static String USR_DIR = System.getProperty("user.dir");
	
	public static String Dist_File = USR_DIR + 
							"\\src\\main\\resources\\i18n\\messages_zh_CN.properties";
	
	public static String Target_File = USR_DIR + 
							"\\src\\main\\resources\\i18n\\messages_src.properties";
	
	public UtilNative2Ascii(){}
	
	public static void Native2Ascii(){
		Native2Ascii(Target_File, Dist_File);
	}
	
	public static void Ascii2Native(){
		Ascii2Native(Dist_File,Target_File);
	}
	
	public static void Native2Ascii(String targetFile,String distFile){
		if(JAVA_HOME == null){
			System.out.println("系统环境未能找到JAVA_HOME");
			return;
		}
		try{
			System.out.println("转换完毕...");
			System.out.println("\t" + targetFile + " To " + distFile);
			Runtime.getRuntime().exec(NASC2ASCII_CMD + " " + targetFile + " " + distFile);
			System.out.println("转换完毕...");
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	public static void Ascii2Native(String targetFile,String distFile){
		if(JAVA_HOME == null){
			System.out.println("系统环境未能找到JAVA_HOME");
			return;
		}
		try{
			System.out.println("转换完毕...");
			System.out.println("\t" + targetFile + " To " + distFile);
			Runtime.getRuntime().exec(ASCII2NASC_CMD + " " + targetFile + " " + distFile);
			System.out.println("转换完毕...");
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args){
		//Transfer
		UtilNative2Ascii.Native2Ascii();
		//Reverse
		//Native2AsciiUtil.Ascii2Native();
		
		//System.out.println(CipherUtil.encodeByMD5("test"));
	}

}
