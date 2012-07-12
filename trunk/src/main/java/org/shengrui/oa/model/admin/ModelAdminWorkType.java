package org.shengrui.oa.model.admin;

import java.util.Date;
import java.util.Set;

import org.shengrui.oa.model.system.ModelAppUser;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 员工工作安排
 * 
 * @author Tang
 * 
 */
public class ModelAdminWorkType 
extends ModelBase {

	private static final long serialVersionUID = -1562818088550621796L;

	/**
	 * 工作类型
	 */
	@Expose
	protected String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
