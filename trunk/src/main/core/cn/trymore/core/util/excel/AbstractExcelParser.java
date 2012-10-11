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

package cn.trymore.core.util.excel;

import java.util.List;

/**
 * The generic excel parser class.
 * 
 * @author Jeccy.Zhao
 *
 */
public abstract class AbstractExcelParser {
	
	public static final int EXCEL_HTML = 44;
	public static final int EXCEL_TABLE_WIDTH = 1000;
	public static final int EXCECL_DEFAULT_SHEET_INDEX = 0;
	
	protected String xlsFile;
	protected int htmlTbWidth;

	public void open() throws Exception {
		open(0);
	}

	public abstract void open(int paramInt) throws Exception;

	public abstract void close();

	public abstract String xlsToHtml(int paramInt) throws Exception;

	public abstract String getCellStyle(int paramInt1, int paramInt2);

	public abstract Object getCellContent(int paramInt1, int paramInt2);

	public abstract String getCellStyle(Object paramObject);

	public abstract Object getCellContent(Object paramObject);

	public abstract Integer getRowCount();

	public abstract Integer getColumnCount();

	public abstract Object getCell(int paramInt1, int paramInt2);
	
	public abstract List<ExcelRowData> getRowData (int sheetIndex);
	
	public void setXlsFile(String xlsFile) {
		this.xlsFile = xlsFile;
	}

	public String getXlsFile() {
		return this.xlsFile;
	}

	public int getHtmlTbWidth() {
		return this.htmlTbWidth;
	}

	public void setHtmlTbWidth(int htmlTbWidth) {
		this.htmlTbWidth = htmlTbWidth;
	}
}