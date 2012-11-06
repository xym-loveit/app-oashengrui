/*
 * Copyright (c) 2010-2012 Zhao.Xiang<z405656232x@163.com> Holding Limited.
 * All rights reserved.
 * 
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
