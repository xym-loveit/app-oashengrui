package cn.trymore.core.model;

import org.apache.struts.action.ActionForm;

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
	protected String id = null;
	
	public String getId()
	{
		return id;
	}
	
	public void setId(String id)
	{
		this.id = (id == null || Integer.parseInt(id) <= 0) ? null : id;
	}
	
}
