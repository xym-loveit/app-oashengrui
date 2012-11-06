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

package cn.trymore.oa.model.system;

import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.shengrui.oa.model.system.ModelAppUser;

import cn.trymore.core.model.ModelBase;

/**
 * SystemLog Base Java Bean, base class for the.oa.model, mapped directly to database table
 * 
 * Avoid changing this file if not necessary, will be overwritten. 
 *
 * TODO: add class/table comments
 */
public class ModelSystemLog 
extends ModelBase 
{
	
	private static final long serialVersionUID = -1440779837642485708L;
	
	protected String userName;
	
	protected ModelAppUser user = new ModelAppUser();
	
	protected Date createtime;
	
	protected String exeOperation;

	protected String detail;
	
	protected String ip;
	
	protected String cost;
	
	/**
	 * 用于过滤条件
	 */
	protected String startTime;
	
	protected String endTime;
	
	protected String districtId;
	/**
	 * @return the districtId
	 */
	public String getDistrictId() {
		return districtId;
	}

	/**
	 * @param districtId the districtId to set
	 */
	public void setDistrictId(String districtId) {
		this.districtId = districtId;
	}

	public ModelAppUser getUser() {
		return user;
	}

	public void setUser(ModelAppUser user) {
		this.user = user;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	/**
	 * Default Empty Constructor for class SystemLog
	 */
	public ModelSystemLog () 
	{
		super();
	}	

	/**
	 * 执行时间	 * @return java.util.Date
	 * @hibernate.property column="createtime" type="java.util.Date" length="19" not-null="true" unique="false"
	 */
	public Date getCreatetime() 
	{
		return this.createtime;
	}
	
	/**
	 * Set the createtime
	 * @spring.validator type="required"
	 */	
	public void setCreatetime(java.util.Date aValue) 
	{
		this.createtime = aValue;
	}	

	/**
	 * 执行操作	 * @return String
	 * @hibernate.property column="exeOperation" type="java.lang.String" length="512" not-null="true" unique="false"
	 */
	public String getExeOperation() 
	{
		return this.exeOperation;
	}
	
	/**
	 * Set the exeOperation
	 * @spring.validator type="required"
	 */	
	public void setExeOperation(String aValue) 
	{
		this.exeOperation = aValue;
	}	
	
	public String getUserName()
	{
		return userName;
	}

	public void setUserName(String userName)
	{
		this.userName = userName;
	}
	
	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) 
	{
		if (!(object instanceof ModelSystemLog)) 
		{
			return false;
		}
		
		ModelSystemLog rhs = (ModelSystemLog) object;
		
		return new EqualsBuilder()
				.append(this.userName, rhs.userName)
				.append(this.user, rhs.user)
				.append(this.createtime, rhs.createtime)
				.append(this.exeOperation, rhs.exeOperation)
				.isEquals();
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() 
	{
		return new ToStringBuilder(this)
				.append("userName", this.userName) 
				.append("user", this.user) 
				.append("createtime", this.createtime) 
				.append("exeOperation", this.exeOperation) 
				.toString();
	}

	/**
	 * @return the startTime
	 */
	public String getStartTime() {
		return startTime;
	}

	/**
	 * @param startTime the startTime to set
	 */
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}
