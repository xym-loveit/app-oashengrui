package org.shengrui.oa.web.component.category;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.commons.lang.StringUtils;
import org.shengrui.oa.common.Constants;
import org.shengrui.oa.model.ModelCategory;

/**
 * It's a helper class for category.
 * 
 * @author Jeccy.Zhao
 * 
 */
public class CategoryHTMLSupport
{

	private List<ModelCategory> categorySet;

	private String treeHTML = "";

	private String dropDownHTML = "";

	private String liHTML = "";

	private String tbListHTML = "";

	private String navHTML = "";

	private StringBuilder treeBuilder = new StringBuilder();

	private StringBuilder dropBuilder = new StringBuilder();

	private StringBuilder liBuilder = new StringBuilder();

	private StringBuilder listBuilder = new StringBuilder();

	private StringBuilder navBuilder = new StringBuilder();

	private List<String> catIds = new ArrayList<String>();
	
	private boolean htmlRender = true;

	private int count = 0;

	public CategoryHTMLSupport(List<ModelCategory> categorySet)
	{
		this (categorySet, true);
	}
	
	public CategoryHTMLSupport(List<ModelCategory> categorySet, boolean htmlRender) 
	{
		this.categorySet = categorySet;
		this.htmlRender = htmlRender;
		
		getCategorizedHTML(categorySet);
	}
	
	/**
	 * 
	 * @param categorySet
	 * @author <a href="mailto:z405656232x@163.com">JeccyZhao</a>
	 */
	private void getCategorizedHTML(List<ModelCategory> categorySet)
	{
		if (categorySet != null && categorySet.size() > 0)
		{
			count = 0;
			walkCategory(categorySet.iterator(), 0);
		}
		treeHTML = treeBuilder.toString();
		dropDownHTML = dropBuilder.toString();
		tbListHTML = listBuilder.toString();
		liHTML = liBuilder.toString();
		navHTML = navBuilder.toString();
	}

	/**
	 * 
	 * @param it
	 * @param treeSB
	 * @param dropSB
	 * @param depth
	 * @author <a href="mailto:z405656232x@163.com">JeccyZhao</a>
	 */
	private void walkCategory(Iterator<ModelCategory> it, int depth)
	{
		ModelCategory cat = null;
		String dropTextPadding = "";
		String tbListTextPadding = "";
		while (it.hasNext())
		{
			cat = it.next();
			// fill the padding
			dropTextPadding = "";
			tbListTextPadding = "";
			for (int i = 0; i < depth; i++)
			{
				dropTextPadding += "&nbsp;&nbsp;";
				tbListTextPadding += "— ";
			}

			if (!catIds.contains(cat.getId()))
			{
				catIds.add(cat.getId());
			}
			
			if (this.htmlRender)
			{
				appendTreeListBuilder(cat);
				appendDropListBuilder(cat, dropTextPadding);
				appendLiListBuilder(cat, dropTextPadding);
				appendTableListBuilder(cat, tbListTextPadding, ++count);
				appendNavListBuilder(cat, depth);
			}
			
			if (cat.getChildren().size() > 0)
			{
				walkCategory(cat.getChildren().iterator(), depth + 1);
				if (depth % 2 == 0)
				{
					navBuilder.append("</ul></li>");
				}
			}
		}
		treeBuilder
				.append(((cat != null && cat.getChildren().size() > 0) || depth > 0) ? "</ul></li>"
						: "");
	}

	/**
	 * 
	 * @param cat
	 * @param textPadding
	 */
	private void appendTableListBuilder(ModelCategory cat, String textPadding,
			int count)
	{
		listBuilder.append("<tr class='iedit "
				+ (count % 2 == 1 ? "alternate" : "")
				+ (StringUtils.isBlank(textPadding) ? " cat-parent" : "")
				+ "' id='cat-" + cat.getId() + "'>");
		/*
		listBuilder
				.append("<th class='check-column' scope='row'>"
						+ (cat.getEditable() == Constants.DefaultEditableCatVal ? ("<input type='checkbox' value='"
								+ cat.getId() + "' name='delete'/>")
								: "&nbsp;") + "</th>");
		*/
		listBuilder.append("<td class='name column-name'>" + "<a title='编辑 “"
				+ cat.getTitle() + "”' href='#' class='row-title'>"
				+ textPadding + cat.getTitle() + "</a><br/>");
		listBuilder
				.append("<div class='row-actions'>"
						+ "<span class='inline'><a class='editinline' id='editinline-"
						+ cat.getId()
						+ "' href='javascript:void(0);'>快速编辑</a></span>"
						+ (cat.getEditable() == Constants.DefaultEditableCatVal ? "<span class='delete'> | <a href='javascript:void(0);' class='delete:the-list:cat-"
								+ cat.getId() + " submitdelete'>删除</a></span>"
								: "") + "</div>");
		listBuilder.append("</td>");
		listBuilder.append("<td class='description column-description'>"
				+ (cat.getDescription() == null ? "&nbsp;" : cat
						.getDescription()) + "</td>");
		listBuilder.append("<td class='slug column-slug'>"
				+ (cat.getAlias() == null ? "&nbsp;" : cat.getAlias())
				+ "</td>");
		listBuilder.append("<td class='posts column-posts num'>"
				+ cat.getCounts() + "</td>");
		listBuilder.append("</tr>");
	}

	/**
	 * 
	 * @param cat
	 */
	private void appendTreeListBuilder(ModelCategory cat)
	{
		String label = "<label class='selectit'>" + "<input id='in-category-"
				+ cat.getId()
				+ "' type='checkbox' name='post_category' value='"
				+ cat.getId() + "'/>" + cat.getTitle() + "</label>";
		if (cat.getChildren().size() > 0)
		{
			treeBuilder.append("<li id='category-" + cat.getId()
					+ "' class='popular-category'>" + label);
			treeBuilder.append("<ul class='children'>");
		} else
		{
			treeBuilder.append("<li id='category-'" + cat.getId()
					+ "' class='popular-category'>" + label + "</li>");
		}
	}

	/**
	 * 
	 * @param cat
	 * @param textPadding
	 */
	private void appendDropListBuilder(ModelCategory cat, String textPadding)
	{
		dropBuilder.append("<option value='" + cat.getId() + "'>" + textPadding
				+ cat.getTitle() + "</option>");
	}

	/**
	 * 
	 * @param cat
	 * @param textPadding
	 */
	private void appendLiListBuilder(ModelCategory cat, String textPadding)
	{
		liBuilder.append("<li id='cat" + cat.getId()
				+ "'><a href=\"newhome/school/cat/" + cat.getId()
				+ "\" title=\"查看“" + cat.getTitle() + "” 分类下所有文章\">"
				+ textPadding + cat.getTitle() + "</a></li>");
	}

	private void appendNavListBuilder(ModelCategory cat, int depth)
	{
		if (depth % 2 == 0)
		{
			navBuilder.append("<li id='cat" + cat.getId()
					+ "'><a href=\"newhome/school/cat/" + cat.getId()
					+ "\" title=\"查看“" + cat.getTitle() + "” 分类下所有文章\">"
					+ cat.getTitle() + "</a></li>");
		} else
		{
			navBuilder.delete(navBuilder.toString().length() - 5, navBuilder
					.toString().length());
			navBuilder.append("<ul>");
			navBuilder.append("<li id='cat" + cat.getId()
					+ "'><a href=\"newhome/school/cat/" + cat.getId()
					+ "\" title=\"查看“" + cat.getTitle() + "” 分类下所有文章\">"
					+ cat.getTitle() + "</a></li>");
		}
	}

	public String getTreeHTML()
	{
		return treeHTML;
	}

	public void setTreeHTML(String treeHTML)
	{
		this.treeHTML = treeHTML;
	}

	public String getDropDownHTML()
	{
		return dropDownHTML;
	}

	public void setDropDownHTML(String dropDownHTML)
	{
		this.dropDownHTML = dropDownHTML;
	}

	public void setCategorySet(List<ModelCategory> categorySet)
	{
		this.categorySet = categorySet;
	}

	public List<ModelCategory> getCategorySet()
	{
		return this.categorySet;
	}

	public void setTreeBuilder(StringBuilder treeBuilder)
	{
		this.treeBuilder = treeBuilder;
	}

	public StringBuilder getTreeBuilder()
	{
		return treeBuilder;
	}

	public void setDropBuilder(StringBuilder dropBuilder)
	{
		this.dropBuilder = dropBuilder;
	}

	public StringBuilder getDropBuilder()
	{
		return dropBuilder;
	}

	public void setListBuilder(StringBuilder listBuilder)
	{
		this.listBuilder = listBuilder;
	}

	public StringBuilder getListBuilder()
	{
		return listBuilder;
	}

	public void setTbListHTML(String tbListHTML)
	{
		this.tbListHTML = tbListHTML;
	}

	public String getTbListHTML()
	{
		return tbListHTML;
	}

	public List<String> getCatIds()
	{
		return this.catIds;
	}

	public void setCatIds(List<String> catIds)
	{
		this.catIds = catIds;
	}

	public void setLiHTML(String liHTML)
	{
		this.liHTML = liHTML;
	}

	public String getLiHTML()
	{
		return liHTML;
	}

	public void setLiBuilder(StringBuilder liBuilder)
	{
		this.liBuilder = liBuilder;
	}

	public StringBuilder getLiBuilder()
	{
		return liBuilder;
	}

	public void setNavHTML(String navHTML)
	{
		this.navHTML = navHTML;
	}

	public String getNavHTML()
	{
		return navHTML;
	}

	public void setNavBuilder(StringBuilder navBuilder)
	{
		this.navBuilder = navBuilder;
	}

	public StringBuilder getNavBuilder()
	{
		return navBuilder;
	}

}
