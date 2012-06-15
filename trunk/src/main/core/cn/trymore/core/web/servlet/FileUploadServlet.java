package cn.trymore.core.web.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.trymore.core.util.UtilFile;

public class FileUploadServlet
extends HttpServlet
{

	private static final long serialVersionUID = 4757212133352817333L;
	
	private ServletConfig servletConfig = null;
	
	private String uploadPath = "";
	
	private String tempPath = "";
	
	private String fileCat = "others";
	
	public void init(ServletConfig servletConfig) throws ServletException
	{
		this.servletConfig = servletConfig;
		super.init(servletConfig);
	}
	
	public void init() throws ServletException
	{
		this.uploadPath = servletConfig.getServletContext().getRealPath("/uploads/");
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
	
	/*
	 * (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		try
		{
			DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
			diskFileItemFactory.setSizeThreshold(4096);
			diskFileItemFactory.setRepository(new File(this.tempPath));
			
			ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
			List<FileItem> fileList = (List<FileItem>) servletFileUpload.parseRequest(request);
			Iterator<FileItem> itor = fileList.iterator();
			
			FileItem fileItem;
			while (itor.hasNext())
			{
				fileItem = itor.next();
				if (fileItem.getContentType() == null)
				{
					continue;
				}
				String filePath = fileItem.getName();
				String fileName = filePath.substring(filePath.lastIndexOf("\\") + 1);
				
				// ensure the directory existed before creating the file.
				String newFileName = this.fileCat + "/" + UtilFile.generateFilename(fileName);
				File dir = new File(this.uploadPath + "/" + newFileName.substring(0, newFileName.lastIndexOf("/") + 1));
				if (!dir.exists())
				{
					dir.mkdirs();
				}
				
				fileItem.write(new File(this.uploadPath + "/" + newFileName));
				
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter writer = response.getWriter();
				writer.println(newFileName);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
			response.getWriter().write("error:" + e.getMessage());
		}
		
	}
	
	/**
	 * Obtains the decimal formated file size.
	 * 
	 * @param size
	 * @return
	 */
	protected String getFileSize (double size)
	{
		DecimalFormat decimalFormat = new DecimalFormat("0.00");
		
		double byteSize;
		if (size > 1048576.0D)
		{
			byteSize = size / 1048576.0D;
			return decimalFormat.format(byteSize) + " M";
		}
		
		if (size > 1024.0D)
		{
			byteSize = size / 1024.D;
			return decimalFormat.format(byteSize) + " KB";
		}
		
		return size + " bytes";
	}
	
	public void setServletConfig(ServletConfig servletConfig)
	{
		this.servletConfig = servletConfig;
	}

	public ServletConfig getServletConfig()
	{
		return servletConfig;
	}

	public void setUploadPath(String uploadPath)
	{
		this.uploadPath = uploadPath;
	}

	public String getUploadPath()
	{
		return uploadPath;
	}

	public void setTempPath(String tempPath)
	{
		this.tempPath = tempPath;
	}

	public String getTempPath()
	{
		return tempPath;
	}

}
