package cn.trymore.core.web.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.trymore.core.util.UtilString;

/**
 * 文档下载
 * @author Tang
 * 使用方法：直接写/download?path=""就可以
 */


public class FileDownloadServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5563238888658319929L;
	
	
	/**
	 * The servlet configuration
	 */
	private ServletConfig servletConfig = null;
	
	public void init(ServletConfig servletConfig) throws ServletException
	{
		this.servletConfig = servletConfig;
		super.init(servletConfig);
	}
	
	

	protected void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		// 服务器相对路径    
		String path = req.getParameter("path");
		
		// 获取文件名
		String fileName = req.getParameter("filename");
		
		// 获取文件编码
		String charset = req.getParameter("charset");
		
		if (UtilString.isNotEmpty(charset))
		{
			charset = "UTF-8";
		}
		
		//  服务器绝对路径    
		path = servletConfig.getServletContext().getRealPath("/uploads/")+"/"+path;

		//  检查文件是否存在   
		File obj = new File(path);

		if (!obj.exists()) {
			res.setContentType("text/html;charset=" + charset);
			res.getWriter().print("指定文件不存在！");
			return;
		}
		//  读取文件名：用于设置客户端保存时指定默认文件名   
		int index = path.lastIndexOf("/");
		
		//  前提：传入的path字符串以“\”表示目录分隔符    
		if (!UtilString.isNotEmpty(fileName))
		{
			fileName = path.substring(index + 1);
		}
		
		//  写流文件到前端浏览器    
		ServletOutputStream out = res.getOutputStream();
		res.setHeader("Content-disposition", "attachment;filename=" + fileName);
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			bis = new BufferedInputStream(new FileInputStream(path));
			bos = new BufferedOutputStream(out);
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (IOException e) {
			throw e;
		} finally {
			if (bis != null) {
				bis.close();
			}
			if (bos != null) {
				bos.close();
			}
		}
	}
}