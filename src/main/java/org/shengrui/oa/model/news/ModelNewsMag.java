package org.shengrui.oa.model.news;

import java.util.Date;

import org.shengrui.oa.model.system.ModelAppDictionary;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;


import cn.trymore.core.model.ModelBase;
/**
 * 新闻管理
 * 
 * @author pyc
 * 
 * */

public class ModelNewsMag
extends ModelBase
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	/**
	 * 新闻类型ID
	 * */
	private Integer typeDicid;
	
	/**
	 * 新闻标题
	 * 
	 * */
	private String newsSubject;
	/**
	 *新闻内容 
	 * */
	private String newsContent;
	/**
	 * 新闻作者ID
	 * */
	private Integer authorId;
	/**
	 * 新闻作者名
	 * 
	 * */
	private String authorName;
	/**
	 *新闻级别
	 * 
	 * */
	private Integer newsLevel;
	/**
	 * 可见校区
	 * 
	 * */
	private Integer districtVisible;
	/**
	 * 创建时间
	 * 
	 * */
	private Date createtime;
	/**
	 * 最后更新时间
	 * 
	 * */
	private Date updateTime;
	/**
	 * 置顶序号
	 * 
	 * */
	private Integer topIndex;
	/**
	 * 新闻状态
	 * */
	private Integer status;
	
	private Integer depPost;
	
	private Integer districtPost;
	
	protected ModelSchoolDistrict district;
	
	protected ModelSchoolDepartment department;
	
	protected ModelAppDictionary dictionary;
	
	
	/**
	 * 主要用于多状态集合搜索,超级用户
	 */
	private Integer[] searchStatusCondition;
	
	
	public static enum newsStatus{
		TODO_DRAFT(0, "todo_draft"),	// 草稿
		TODO_HEAD(1, "todo_inhead"),	// 已发布并待审核
		APPROVED(2, "approved"),		// 审核通过
		RETURNED(3, "returned");		// 审核退回
		
		
		private Integer value;
		private String text;
		
		newsStatus(Integer value, String text)
		{
			this.value = value;
			this.text = text;
		}
		public Integer getValue(){
			return value;
		}
		
		public String getText()
		{
			return this.text;
		}
	}
	
	public static enum newsLevel
	{
		TODO_COMPANYNEWS(0,"todo_companyNews"),
		TODO_DISTRICT(1,"todoDistrict");
		
		private Integer value;
		private String text;
		
		newsLevel(Integer value, String text)
		{
			this.value = value;
			this.text = text;
		}

		public Integer getValue() {
			return value;
		}

		public void setValue(Integer value) {
			this.value = value;
		}

		public String getText() {
			return text;
		}

		public void setText(String text) {
			this.text = text;
		}
		
	}
	

	public Integer getTypeDicid() {
		return typeDicid;
	}
	public void setTypeDicid(Integer typeDicid) {
		this.typeDicid = typeDicid;
	}
	public String getNewsSubject() {
		return newsSubject;
	}
	public void setNewsSubject(String newsSubject) {
		this.newsSubject = newsSubject;
	}
	public String getNewsContent() {
		return newsContent;
	}
	public void setNewsContent(String newsContent) {
		this.newsContent = newsContent;
	}
	public Integer getAuthorId() {
		return authorId;
	}
	public void setAuthorId(Integer authorId) {
		this.authorId = authorId;
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public Integer getNewsLevel() {
		return newsLevel;
	}
	public void setNewsLevel(Integer newsLevel) {
		this.newsLevel = newsLevel;
	}
	public Integer getDistrictVisible() {
		return districtVisible;
	}
	public void setDistrictVisible(Integer districtVisible) {
		this.districtVisible = districtVisible;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getTopIndex() {
		return topIndex;
	}
	public void setTopIndex(Integer topIndex) {
		this.topIndex = topIndex;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer[] getSearchStatusCondition() {
		return searchStatusCondition;
	}
	public void setSearchStatusCondition(Integer[] searchStatusCondition) {
		this.searchStatusCondition = searchStatusCondition;
	}
	public ModelSchoolDistrict getDistrict() {
		return district;
	}
	public void setDistrict(ModelSchoolDistrict district) {
		this.district = district;
	}
	public ModelSchoolDepartment getDepartment() {
		return department;
	}
	public void setDepartment(ModelSchoolDepartment department) {
		this.department = department;
	}
	public Integer getDepPost() {
		return depPost;
	}
	public void setDepPost(Integer depPost) {
		this.depPost = depPost;
	}
	public Integer getDistrictPost() {
		return districtPost;
	}
	public void setDistrictPost(Integer districtPost) {
		this.districtPost = districtPost;
	}
	public ModelAppDictionary getDictionary() {
		return dictionary;
	}
	public void setDictionary(ModelAppDictionary dictionary) {
		this.dictionary = dictionary;
	}
	
}