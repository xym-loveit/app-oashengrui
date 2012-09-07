package org.shengrui.oa.web.action.export;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.util.UtilFile;
import cn.trymore.core.util.UtilResources;
import cn.trymore.core.util.UtilString;

/**
 * It aims to export files to client, i.e, HTML, PDF, Excel and etc.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ExportAction
extends BaseAppAction
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(ExportAction.class);
	
	/**
	 * The file upload destination path.
	 */
	private String uploadPath = "";
	
	/**
	 * The file upload temporary path.
	 */
	private String tempPath = "";
	
	/**
	 * Exports to HTML file.
	 * 
	 * Behaviors:
	 * It receives HTML content from request and writes to client.
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward exportToHtml (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String content = request.getParameter("html");
		String fileName = request.getParameter("title");
		if (UtilString.isNotEmpty(content, fileName))
		{
			try
			{
				init(request);
				
				String newFileName = UtilFile.generateFilename(fileName) + ".html";
				
				File dir = new File(this.tempPath + "/" + newFileName.substring(0, newFileName.lastIndexOf("/") + 1));
				if (!dir.exists())
				{
					dir.mkdirs();
				}
				
				File file = new File(this.tempPath + "/" + newFileName);
				if(file.exists())
				{
					file.createNewFile();
				}
				
				OutputStream os = new FileOutputStream(file);
				os.write(content.getBytes());
				os.close();
				
				return ajaxPrint(response, "{status:200, file:'" + "temp/" + newFileName + "', name:'" + fileName + "'}");
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when exporting file(`" + fileName + ".html`) to client.", e);
				return ajaxPrint(response, getErrorCallback("文件导出(`" + fileName + ".html`)失败：" + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("请传入相应的参数.."));
		}
	}
	
	private void init(HttpServletRequest request) throws ServletException
	{
		
		this.uploadPath = UtilResources.getWebRootPath() + "uploads";
		
		File localFile = new File(this.uploadPath);
		if (!localFile.exists())
		{
			localFile.mkdirs();
		}
		
		this.tempPath = this.uploadPath + "/temp";
		File tmpFile = new File(this.tempPath);
		if (!tmpFile.exists())
		{
			tmpFile.mkdirs();
		}
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
	
}
