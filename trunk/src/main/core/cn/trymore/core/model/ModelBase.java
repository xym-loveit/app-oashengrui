package cn.trymore.core.model;

import java.util.Date;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.struts.action.ActionForm;

import cn.trymore.core.struts.BeanDateConnverter;

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
	
}
