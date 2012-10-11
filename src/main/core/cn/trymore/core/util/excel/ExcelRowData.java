/*
 * 
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

package cn.trymore.core.util.excel;

import java.util.ArrayList;
import java.util.List;

/**
 * The container to hold the excel row data.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ExcelRowData {
	private int rowId = 0;
	private List<String> rowList = new ArrayList<String>();
	private List<String> rowStyleList = new ArrayList<String>();
	
	public ExcelRowData(){
		
	}
	
	public void setRowId(int rowid){
		this.rowId = rowid;
	}

	public List<String> getRowStyleList() {
		return rowStyleList;
	}

	public void setRowStyleList(List<String> rowStyleList) {
		this.rowStyleList = rowStyleList;
	}

	public boolean setRowStyle(String style) {
		return this.rowStyleList.add(style);
	}
	
	public int getRowId(){
		return this.rowId;
	}
	
	public boolean setRowData(String rowdata){
		return this.rowList.add(rowdata);
	}
	
	public List<String> getRowData(){
		return this.rowList;
	}
	
	public List<String> getRowList() {
		return rowList;
	}

	public void setRowList(List<String> rowList) {
		this.rowList = rowList;
	}
}
