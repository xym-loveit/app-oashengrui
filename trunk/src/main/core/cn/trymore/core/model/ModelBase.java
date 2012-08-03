package cn.trymore.core.model;

import java.util.Date;
import java.util.Set;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.struts.action.ActionForm;

import cn.trymore.core.struts.BeanDateConnverter;
import cn.trymore.oa.model.system.ModelFileAttach;

import com.google.gson.annotations.Expose;

/**
 * The base model
 * 
 * @author Jeccy.Zhao
 *
 */
public abstract class ModelBase 
extends ActionForm
{
	/**
	 * The serial version UID
	 */
	private static final long serialVersionUID = -240826378108165136L;
	
	/**
	 * The model identity
	 */
	@Expose
	protected String id = null;
	
	/**
	 * The attachment files,
	 * 
	 * <pre>
	 * <b>Reminder:</b>
	 * Just take it into use when necessary 
	 * since not all of entities has property of attachment. 
	 * </pre>
	 * 
	 */
	private Set<ModelFileAttach> attachFiles;
	
	static
	{
		ConvertUtils.register(new BeanDateConnverter(), Date.class);
	}
	
	public String getId()
	{
		return id;
	}
	
	public void setId(String id)
	{
		this.id = (id == null || Integer.parseInt(id) <= 0) ? null : id;
	}

	public void setAttachFiles(Set<ModelFileAttach> attachFiles)
	{
		this.attachFiles = attachFiles;
	}

	public Set<ModelFileAttach> getAttachFiles()
	{
		return attachFiles;
	}
}
