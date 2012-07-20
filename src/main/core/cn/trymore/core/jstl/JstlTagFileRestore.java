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
