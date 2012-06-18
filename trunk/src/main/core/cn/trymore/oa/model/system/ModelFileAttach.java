package cn.trymore.oa.model.system;

import java.util.Date;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 附件信息
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelFileAttach
extends ModelBase
{
	private static final long serialVersionUID = 122338404223824891L;
	
	/**
	 * 删除标识,1=已删除
	 */
	public static final Integer FLAG_DEL = 1;
	
	/**
	 * 删除标识,0=未删除
	 */
	public static final Integer FLAG_NOT_DEL = 0;
	
	/**
	 * 文件名
	 */
	@Expose
	protected String fileName;
	
	/**
	 * 文件路径
	 */
	@Expose
	protected String filePath;
	
	/**
	 * 创建时间
	 */
	@Expose
	protected Date createtime;
	
	/**
	 * 文件扩展名
	 */
	@Expose
	protected String fileExt;
	
	/**
	 * 文件类型
	 */
	@Expose
	protected String fileType;
	
	/**
	 * 文件说明
	 */
	@Expose
	protected String note;
	
	/**
	 * 上传者
	 */
	@Expose
	protected String creator;
	
	/**
	 * 上传者ID
	 */
	@Expose
	protected Long creatorId;
	
	/**
	 * 文件大小
	 */
	@Expose
	protected Long totalBytes;
	
	/**
	 * 文件删除标记 (1=已删除, 0=未删除)
	 */
	@Expose
	protected Integer delFlag = FLAG_NOT_DEL;

	public String getFileName()
	{
		return fileName;
	}

	public void setFileName(String fileName)
	{
		this.fileName = fileName;
	}

	public String getFilePath()
	{
		return filePath;
	}

	public void setFilePath(String filePath)
	{
		this.filePath = filePath;
	}

	public Date getCreatetime()
	{
		return createtime;
	}

	public void setCreatetime(Date createtime)
	{
		this.createtime = createtime;
	}

	public String getFileExt()
	{
		return fileExt;
	}

	public void setFileExt(String fileExt)
	{
		this.fileExt = fileExt;
	}

	public String getFileType()
	{
		return fileType;
	}

	public void setFileType(String fileType)
	{
		this.fileType = fileType;
	}

	public String getNote()
	{
		return note;
	}

	public void setNote(String note)
	{
		this.note = note;
	}

	public String getCreator()
	{
		return creator;
	}

	public void setCreator(String creator)
	{
		this.creator = creator;
	}

	public Long getCreatorId()
	{
		return creatorId;
	}

	public void setCreatorId(Long creatorId)
	{
		this.creatorId = creatorId;
	}

	public Long getTotalBytes()
	{
		return totalBytes;
	}

	public void setTotalBytes(Long totalBytes)
	{
		this.totalBytes = totalBytes;
	}

	public Integer getDelFlag()
	{
		return delFlag;
	}

	public void setDelFlag(Integer delFlag)
	{
		this.delFlag = delFlag;
	}

	public static Integer getFlagDel()
	{
		return FLAG_DEL;
	}

	public static Integer getFlagNotDel()
	{
		return FLAG_NOT_DEL;
	}
	
}
