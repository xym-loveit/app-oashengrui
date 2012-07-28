package cn.trymore.core.web.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Date;
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
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.util.UtilApp;
import cn.trymore.core.util.UtilFile;
import cn.trymore.oa.model.system.ModelFileAttach;
import cn.trymore.oa.service.system.ServiceFileAttach;

/**
 * The servlet for file uploading.
 * 
 * @author Jeccy.Zhao
 *
 */
public class FileUploadServlet
extends HttpServlet
{

	private static final long serialVersionUID = 4757212133352817333L;
	
	/**
	 * The file attach service.
	 */
	private ServiceFileAttach serviceFileAttach = (ServiceFileAttach) UtilApp.getBean("serviceFileAttach");
	
	/**
	 * The servlet configuration
	 */
	private ServletConfig servletConfig = null;
	
	/**
	 * The file upload destination path.
	 */
	private String uploadPath = "";
	
	/**
	 * The file upload temporary path.
	 */
	private String tempPath = "";
	
	/**
	 * The file category
	 */
	private String fileCat = "others";
	
	public void init(ServletConfig servletConfig) throws ServletException
	{
		this.servletConfig = servletConfig;
		super.init(servletConfig);
	}
	
	/**
	 * Initializations, like:
	 * 
	 * 1. Define the temporary path for file upload.   <br/>
	 * 2. Define the destination path for file upload. <br/>
	 * 3. Create the above directories if not existed. 
	 * 
	 */
	public void init() throws ServletException
	{
		this.uploadPath = servletConfig.getServletContext().getRealPath("/uploads/");
		
		System.out.println(this.uploadPath);
		
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
			
			String fileIds="";
			
			ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
			List<FileItem> fileList = (List<FileItem>) servletFileUpload.parseRequest(request);
			Iterator<FileItem> itor = fileList.iterator();
			Iterator<FileItem> itor1 = fileList.iterator();
			String file_type = "";
			while(itor1.hasNext()){
				FileItem item = itor1.next();
				if(item.isFormField() && "file_type".equals(item.getFieldName())){
					file_type = item.getString();
				}
			}
			FileItem fileItem;
			while (itor.hasNext())
			{
				fileItem = itor.next();
				
				if (fileItem.getContentType() == null)
				{
					continue;
				}
				
				// obtains the file path and name
				String filePath = fileItem.getName();
				
				String fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
				// generates new file name with the current time stamp.
				String newFileName = this.fileCat + "/" + UtilFile.generateFilename(fileName);
				// ensure the directory existed before creating the file.
				File dir = new File(this.uploadPath + "/" + newFileName.substring(0, newFileName.lastIndexOf("/") + 1));
				if (!dir.exists())
				{
					dir.mkdirs();
				}
				
				// stream writes to the destination file
				fileItem.write(new File(this.uploadPath + "/" + newFileName));
				
				ModelFileAttach fileAttach = null;
				if (request.getParameter("noattach") == null)
				{
					// storages the file into database.
					fileAttach = new ModelFileAttach();
					fileAttach.setFileName(fileName);
					fileAttach.setFilePath(newFileName);
					fileAttach.setTotalBytes(Long.valueOf(fileItem.getSize()));
					fileAttach.setNote(this.getStrFileSize(fileItem.getSize()));
					fileAttach.setFileExt(fileName.substring(fileName.lastIndexOf(".") + 1));
					fileAttach.setCreatetime(new Date());
					fileAttach.setDelFlag(ModelFileAttach.FLAG_NOT_DEL);
					fileAttach.setFileType(!"".equals(file_type)?file_type:this.fileCat);
					
					ModelAppUser user = ContextUtil.getCurrentUser();
					if (user != null)
					{
						fileAttach.setCreatorId(Long.valueOf(user.getId()));
						fileAttach.setCreator(user.getFullName());
					}
					else
					{
						fileAttach.setCreator("Unknow");
					}
					
					this.serviceFileAttach.save(fileAttach);
				}
				
				//add by Tang 这部分代码用于临时保存fileIds，用完后一定要注意及时销毁。
				if (fileAttach != null)
				{
					fileIds=(String) request.getSession().getAttribute("fileIds");
					if(fileIds==null)
					{
						fileIds=fileAttach.getId();
					}
					else
					{
						fileIds=fileIds+","+fileAttach.getId();
					}
				}
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter writer = response.getWriter();
				writer.println("{\"status\": 1, \"data\":{\"id\":" + (fileAttach != null ? fileAttach.getId() : "\"\"") + ", \"url\":\"" + newFileName + "\"}}");
			}
			request.getSession().setAttribute("fileIds", fileIds);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			response.getWriter().write("{\"status\":0, \"message\":\"上传失败:" + e.getMessage() + "\"");
		}
	}
	
	/**
	 * Obtains the decimal formated file size.
	 * 
	 * @param size
	 * @return
	 */
	protected String getStrFileSize (double size)
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

	public void setServiceFileAttach(ServiceFileAttach serviceFileAttach)
	{
		this.serviceFileAttach = serviceFileAttach;
	}

	public ServiceFileAttach getServiceFileAttach()
	{
		return serviceFileAttach;
	}

}
