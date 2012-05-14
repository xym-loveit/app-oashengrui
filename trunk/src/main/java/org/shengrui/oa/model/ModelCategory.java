package org.shengrui.oa.model;

import java.util.Set;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.shengrui.oa.utilities.UtilDate;

/**
 * The model of category
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelCategory 
extends ModelBase
{
	/**
	 * The serial version UID
	 */
	private static final long serialVersionUID = -5376877624780304119L;
	
	/**
	 * The category title
	 */
	private String title;
	
	/**
	 * The category description
	 */
	private String description;
	
	/**
	 * The category alias name
	 */
	private String alias;
	
	/**
	 * The category counts
	 */
	private int counts;
	
	/**
	 * The category parent
	 */
	private ModelCategory parent;
	
	/**
	 * The category type
	 */
	private int type;
	
	/**
	 * The category children
	 */
	private Set<ModelCategory> children;
	
	/**
	 * The category creation time
	 */
	private Date createTime;
	
	/**
	 * The category edit-able or not, by default as unlocked
	 */
	private int editable = CategoryEditable.UNLOCKED.getValue();
	
	/**
	 * The enumeration of category type
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum CategoryType
	{
		
		NEWS(0, "news"),
		BLOG(1, "blog");
		
		private int value;
		private String slug;
		
		CategoryType(int value,String slug)
		{
			this.value = value;
			this.slug  = slug;
		}
		
		public int getValue()
		{
			return this.value;
		}
		
		public String getSlug()
		{
			return this.slug;
		}
	}
	
	/**
	 * The enumeration of category edit-able
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum CategoryEditable
	{
		
		LOCKED(0, "locked"),
		UNLOCKED(1, "unlocked");
		
		private int value;
		private String slug;
		
		CategoryEditable(int value,String slug)
		{
			this.value = value;
			this.slug  = slug;
		}
		
		public int getValue()
		{
			return this.value;
		}
		
		public String getSlug()
		{
			return this.slug;
		}
	}
	
	public String getTitle() 
	{
		return title;
	}
	
	public void setTitle(String title) 
	{
		this.title = title;
	}
	
	public String getDescription() 
	{
		return description;
	}
	
	public void setDescription(String description) 
	{
		this.description = (description != null && StringUtils.isNotEmpty(description.trim())) ? description : null;;
	}
	
	public Date getCreateTime() 
	{
		return createTime != null ? createTime : UtilDate.getNowTime();
	}
	
	public void setCreateTime(Date createTime) 
	{
		this.createTime = createTime;
	}
	
	public int getCounts()
	{
		return counts;
	}
	
	public void setCounts(int counts) 
	{
		this.counts = counts;
	}
	
	public String getAlias()
	{
		return alias;
	}
	
	public void setAlias(String alias) 
	{
		this.alias = (alias != null && StringUtils.isNotEmpty(alias.trim())) ? alias : null;
	}
	
	public ModelCategory getParent() 
	{
		return parent;
	}
	
	public void setParent(ModelCategory parent) 
	{
		this.parent = parent;
	}
	
	public void setChildren(Set<ModelCategory> children)
	{
		this.children = children;
	}
	
	public Set<ModelCategory> getChildren()
	{
		return children;
	}

	public void setEditable(int editable) 
	{
		this.editable = editable;
	}

	public int getEditable() 
	{
		return editable;
	}

	public void setType(int type) 
	{
		this.type = type;
	}

	public int getType() 
	{
		return type;
	}
	
}
