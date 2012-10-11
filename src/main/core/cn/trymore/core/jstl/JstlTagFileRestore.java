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

package cn.trymore.core.jstl;

import java.util.Set;

import cn.trymore.oa.model.system.ModelFileAttach;

/**
 * 标签库: 前端输出文件对应JSON数据列表
 * 
 * @author Jeccy.Zhao
 *
 */
public class JstlTagFileRestore 
{
	
	/**
	 * Restores list of file attachments in page.
	 * The generated string looks like:
	 * <pre>
	 * [{
		"name":"icon_evil.gif",
		"result":{
			"status":1,
			"data":{
				"name":"icon_evil.gif",
				"url":"http://tp4.sinaimg.cn/1653905027/50/5601547226/1"
			}
		}
    },
	{
		"name":"icon_evil.gif",
		"result":{
			"status":1,
			"data":{
				"name":"icon_evil.gif",
				"url":"http://tp4.sinaimg.cn/1653905027/50/5601547226/1"
			}
		}
    }
]
	 </pre>
	 * 
	 * @param fileAttachs
	 *            list of file attachments
	 * @return
	 */
	public static String fileRestore(Set<ModelFileAttach> fileAttachs)
	{
		StringBuilder builder = new StringBuilder();
		builder.append("[");
		
		if (fileAttachs != null)
		{
			for (ModelFileAttach fileAttach : fileAttachs)
			{
				String jsonText = buildJsonByFile (fileAttach);
				if (jsonText != null)
				{
					builder.append(jsonText);
					builder.append(",");
				}
			}
		}
		
		if (builder.toString().endsWith(","))
		{
			builder.deleteCharAt(builder.toString().length() - 1);
		}
		
		builder.append("]");
		
		return builder.toString();
	}
	
	 /**
	  * 
	  * @param fileAttachs
	  * @param type
	  * @return
	  */
	public static String fileRestoreByType(Set<ModelFileAttach> fileAttachs,String type)
	{
		System.out.println(type);
		if(type==null || "".equals(type))type="others";
		StringBuilder builder = new StringBuilder();
		builder.append("[");
		
		if (fileAttachs != null)
		{
			for (ModelFileAttach fileAttach : fileAttachs)
			{
				if(type.equalsIgnoreCase(fileAttach.getFileType())){
					String jsonText = buildJsonByFile (fileAttach);
					if (jsonText != null)
					{
						builder.append(jsonText);
						builder.append(",");
					}
				}
			}
		}
		
		if (builder.toString().endsWith(","))
		{
			builder.deleteCharAt(builder.toString().length() - 1);
		}
		
		builder.append("]");
		System.out.println(builder.toString());
		return builder.toString();
	}
	
	/**
	 * Builds JSON text with the specified file model.
	 * 
	 * {
	 * "name":"icon_evil.gif",
		"result":{
			"status":1,
			"data":{
				"name":"icon_evil.gif",
				"url":"http://tp4.sinaimg.cn/1653905027/50/5601547226/1"
			}
		}
		}
	 * 
	 * @param fileAttach
	 *           the file attachment model
	 * @return
	 */
	private static String buildJsonByFile (ModelFileAttach fileAttach)
	{
		if (fileAttach != null)
		{
			StringBuilder builder = new StringBuilder();
			
			builder.append("{");
			builder.append("\"name\":\"" + fileAttach.getFileName() + "\",");
			builder.append("\"result\": {\"status\":1,\"data\":{");
			builder.append("\"name\":\"" + fileAttach.getFileName() + "\",");
			builder.append("\"url\":\"" + fileAttach.getFilePath() + "\"}}}");
			
			return builder.toString();
		}
		
		return null;
	}
	
}
