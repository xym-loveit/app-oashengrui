package cn.trymore.core.util;

import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import cn.trymore.core.bean.PairObject;
import cn.trymore.core.common.Constants;

/**
 * The utility functionalities of File.
 * 
 * @author  Jeccy.Zhao
 *
 */
public class UtilFile 
{
	
	/**
	 * Returns true if the specified file existed; false otherwise
	 * 
	 * @param filePath
	 *          path of the file
	 * @return true if file existed; false otherwise
	 */
	public static boolean fileExisted (String filePath) 
	{
		File file = new File(filePath);
		return file.exists();
	}
	
	/**
	 * Returns true if the specified path is directory
	 * 
	 * @param path
	 *          path of the folder
	 * @return true if path is directory; false otherwise
	 */
	public static boolean isDirectory (String path) 
	{
		File file = new File(path);
		return file.isDirectory();
	}
	
	/**
	 * Returns the file name without extension
	 * from the specified file path. 
	 * 
	 * @param filePath
	 *          path of the file
	 * @return the file name without exetension
	 */
	public static String getFileNameWithoutExtension (String filePath) 
	{
		if (UtilString.isNotEmpty(filePath)) 
		{
			int sepLastIndex = filePath.lastIndexOf(File.separator);
			if (sepLastIndex > -1) 
			{
				filePath = filePath.substring(sepLastIndex + 1);
			}
			return filePath.substring(0, filePath.lastIndexOf(".") > -1 ? filePath.lastIndexOf(".") : filePath.length() - 1);
		}
		return filePath;
	}
	
	/**
	 * Obtains the last file path
	 * 
	 * @param filePath
	 * @return
	 */
	public static String getLastFilePath (final String filePath)
	{
		String lastFilePath = filePath;
			
		if (filePath.contains(Constants.FILE_SEPARATOR))
		{
			lastFilePath = lastFilePath.substring(lastFilePath.lastIndexOf(Constants.FILE_SEPARATOR) + Constants.FILE_SEPARATOR.length());
		}
		
		return lastFilePath;
	}
	
	/**
	 * Creates the specified file and returns true if creation succeed
	 * 
	 * @param filePath
	 *          path of the file to be created
	 * @throws IOException 
	 */
	public static void createFile (String filePath) throws IOException 
	{
		if (!fileExisted(filePath)) 
		{
			File file = new File (filePath);
			if (!fileExisted(file.getParent())) 
			{
				file.getParentFile().createNewFile();
			}
			file.createNewFile();
		}
	}
	
	/**
	 * Returns the files laid in the specified folder path
	 * 
	 * @param path
	 *          path of the folder
	 * @return the files laid in the specified folder path
	 */
	public static File[] getFiles (String path) 
	{
		if (isDirectory(path))
		{
			File file = new File(path);
			return file.listFiles(new FileFilter() {
				@Override
				public boolean accept(File file) 
				{
					if (file.getName().startsWith("."))
					{
						return false;
					}
					
					/*
					if (!file.isDirectory() && !file.getName().endsWith(".xml"))
					{
						return false;
					}
					*/
					
					return true;
				}
			});
		}
		return null;
	}
	
	/**
	 * Returns the file information with the specified file path
	 * 
	 * @param filePath
	 *           the file path
	 * @return the file information
	 */
	public static PairObject<String, PairObject<String, String>> getFileInformation (String filePath) 
	{
		if (filePath != null && !filePath.isEmpty()) 
		{
			int pos = filePath.lastIndexOf(File.separator);
			if (pos > -1) 
			{
				String fileDir = filePath.substring(0, pos);
				String fileName = filePath.substring(pos+1);
				String fileExt = null;
				int posExt = fileName.lastIndexOf(".");
				if (posExt > -1) 
				{
					fileExt = fileName.substring(posExt);
					fileName = fileName.substring(0, posExt);
				}
				return new PairObject<String, PairObject<String, String>>(fileDir, new PairObject<String, String>(fileName, fileExt));
			}
		}
		return null;
	}
	
	/**
     * Returns the file's contents as a string.
     * 
     * @param file
     *            file
     * @return the file's contents as a string
     * @throws IOException
     *             when the specified file cannot be read
     */
    public static String getStringFromFile(File file) throws IOException 
    {
        return new String(getBytesFromFile(file));
    }
	
    /**
     * Returns the file's contents as a string.
     * 
     * @param pathTofile
     *            path to the file
     * @return the file's contents as a string
     * @throws IOException
     *             when the specified file cannot be read
     */
    public static String getStringFromFile(String pathTofile) throws IOException 
    {
        return getStringFromFile(new File(pathTofile));
    }
    
    /**
     * Creates the specified folder based on the path
     * 
     * @param folderPath
     *          the folder path
     * @return
     */
    public static String createFolder(String folderPath) 
    {
		String txt = folderPath;
		
		try 
		{
			java.io.File myFilePath = new java.io.File(txt);
			txt = folderPath;
			
			if (!myFilePath.exists())
			{
				myFilePath.mkdir();
			}
		} 
		catch (Exception e) 
		{
		}
		
		return txt;
	}
    
    /**
     * Removes the specified folder path
     * 
     * @param path
     *         the folder path
     * @return true if the folder removed
     */
    public static boolean removeFolder (String path)
    {
    	File f = new File(path);
    	if (!f.exists())
    	{
    		return false;
    	}
    	
    	if (f.isFile())
    	{
    		return deleteFile(path);
    	}
    	else
    	{
    		return deleteFolder(path);
    	}
    }
    
    /**
     * Removes the specified file
     * 
     * @param path
     *         the file path
     * @return true if the file removed
     */
    private static boolean deleteFile (String path)
    {
    	File f = new File(path);
    	if (f.exists() && f.isFile())
    	{
    		f.delete();
    		return true;
    	}
    	return false;
    }
    
    /**
     * Removes the specified folder path
     * 
     * @param path
     *         the folder path
     * @return true if the folder removed
     */
    private static boolean deleteFolder (String path)
    {
    	if (!path.endsWith(File.separator))
    	{
    		path = path + File.separator;
    	}
    	
    	File f = new File(path);
    	if (f.exists() && f.isDirectory())
    	{
    		File[] files = f.listFiles();
    		for (int i = 0; i < files.length; i++)
    		{
    			if (files[i].isFile())
    			{
    				deleteFile(files[i].getAbsolutePath());
    			}
    			else
    			{
    				deleteFolder(files[i].getAbsolutePath());
    			}
    		}
    	}
    	
    	if (f.delete())
    	{
    		return true;
    	}
    	
    	return false;
    }
    
    /**
     * Returns the file's contents as a byte array.
     * 
     * @param file
     *            file
     * @return the file's contents as a byte array
     * @throws IOException
     *             when the specified file cannot be read
     */
    public static byte[] getBytesFromFile(File file) throws IOException 
    {
        InputStream is = new FileInputStream(file);
        long length = file.length();
        if (length > Integer.MAX_VALUE) 
        {
            throw new IOException(file.getName() + " is too large to be read into a byte array");
        }

        byte[] bytes = new byte[(int) length];
        int offset = 0;
        int numRead = 0;
        while (offset < bytes.length
                && (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) 
        {
            offset += numRead;
        }

        if (offset < bytes.length) 
        {
            throw new IOException("Could not completely read file " + file.getName());
        }

        is.close();
        return bytes;
    }
}
