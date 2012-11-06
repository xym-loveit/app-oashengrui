package org.shengrui.oa.model.hrm;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 人才库
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelHrmArchive
extends ModelBase
{

	private static final long serialVersionUID = -709569518809507549L;
	
	/**
	 * 应聘简历ID
	 */
	private ModelHrmResume resume = new ModelHrmResume();
	
	/**
	 * 应聘岗位ID
	 */
	private ModelHrmJobHireInfo jobHireInfo = new ModelHrmJobHireInfo();
	
	/**
	 * 来源
	 */
	private Integer source;
	
	/**
	 * 评定等级
	 */
	private Integer starLevel;
	
	/**
	 * The enumeration of archive source
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EArchiveSource
	{
		OFFERDROPED(1, "offer_dropped"),			// 入职未到
		ELIMINATED(2, "eliminated"),				// 淘汰
		ABSENCE(3, "absence"),						// 未面试
		FAIRWELL(4, "fairewell"),					// 离职
		OUTOFPROBATION(5, "outofprobation");		// 考察期未通过
		
		private Integer value;
		private String text;
		
		EArchiveSource (Integer value, String text)
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
	
	public ModelHrmResume getResume()
	{
		return resume;
	}

	public void setResume(ModelHrmResume resume)
	{
		this.resume = resume;
	}

	public ModelHrmJobHireInfo getJobHireInfo()
	{
		return jobHireInfo;
	}

	public void setJobHireInfo(ModelHrmJobHireInfo jobHireInfo)
	{
		this.jobHireInfo = jobHireInfo;
	}

	public Integer getSource()
	{
		return source;
	}

	public void setSource(Integer source)
	{
		this.source = source;
	}

	public Integer getStarLevel()
	{
		return starLevel;
	}

	public void setStarLevel(Integer starLevel)
	{
		this.starLevel = starLevel;
	}
	
}
