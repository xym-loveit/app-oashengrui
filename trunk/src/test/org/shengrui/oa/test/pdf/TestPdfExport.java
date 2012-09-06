package org.shengrui.oa.test.pdf;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;

import org.xhtmlrenderer.pdf.ITextRenderer;


public class TestPdfExport
{
	
	public static void main(String[] args)
	{
		OutputStream os = null;
		try 
		{
			String basePath = System.getProperty("user.dir");
			String inputFile = "d:/index.do.htm";
			String outputFile = basePath + "/test.pdf";
			os = new FileOutputStream(outputFile);	
			
			String xhtmlContent = TestPdfExport.readFileContent(inputFile);
			
			ITextRenderer renderer = new ITextRenderer();
			// 解决中文支持问题 
			// ITextFontResolver fontResolver = renderer.getFontResolver();   
//						fontResolver.addFont(System.getProperty("user.dir")+"/test/fonts/LiberationSans-Bold.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);   
			//fontResolver.addFontDirectory(
			//		System.getProperty("user.dir")+"/test/fonts", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
			
			// 解决图片的相对路径问题 
			renderer.getSharedContext().setBaseURL(new File(basePath).toURI().toURL().toString()); 
			renderer.setDocumentFromString(xhtmlContent);
			
			renderer.layout();
			renderer.createPDF(os, true);
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if (os != null) {
				try {
					os.close();
					os = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public static String readFileContent(String fileName) {
		StringBuilder fileContent = new StringBuilder();
		try {
			File f = new File(fileName);
			FileReader fileReader;

			fileReader = new FileReader(f);

			BufferedReader reader = new BufferedReader(fileReader);
			String line = "";
			while ((line = reader.readLine()) != null) {
				fileContent.append(line);
			}
			reader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileContent.toString();
	}
	
}
