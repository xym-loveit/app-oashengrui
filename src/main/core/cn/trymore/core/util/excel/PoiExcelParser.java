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

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFConditionalFormattingRule;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFSheetConditionalFormatting;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.CellValue;

import cn.trymore.core.util.UtilDate;

/**
 * 
 * POI excel parser.
 * 
 * @author Jeccy.Zhao
 *
 */
public class PoiExcelParser extends AbstractExcelParser {
	
	private static Logger logger = Logger.getLogger(PoiExcelParser.class);
	
	private HSSFWorkbook book;
	private HSSFSheet sheet;
	private HSSFSheetConditionalFormatting cfms;
	private HashMap<HSSFCell, String> cfmCells;

	public PoiExcelParser() {
		this.book = null;
		this.sheet = null;
		this.cfms = null;
		this.cfmCells = new HashMap<HSSFCell, String>();
	}

	public PoiExcelParser(String xlsFile) {
		this(xlsFile, 1000);
	}

	public PoiExcelParser(String xlsFile, int htmlTbWidth) {
		this.book = null;
		this.sheet = null;
		this.cfms = null;
		this.cfmCells = new HashMap<HSSFCell, String>();

		this.xlsFile = xlsFile;
		this.htmlTbWidth = htmlTbWidth;
	}

	public void open(int sheetIdx) throws Exception {
		InputStream input = new FileInputStream(this.xlsFile);
		POIFSFileSystem poi = new POIFSFileSystem(input);
		this.book = new HSSFWorkbook(poi);
		this.sheet = getSheet(sheetIdx);
		this.cfms = this.sheet.getSheetConditionalFormatting();
	}

	public void close() {
	}

	public String getCellStyle(int rowIdx, int columnIdx) {
		return getCellStyle(getCell(rowIdx, columnIdx));
	}

	public String getCellStyle(Object cell) {
		if (cell != null) {
			HSSFCell cel = (HSSFCell) cell;
			String styleCellAlign = getCellAlignment(cel);
			String styleCellBorder = getCellBorderStyle(cel);

			styleCellBorder = "";
			String styleCellFont = getCellFontStyle(cel);
			String styleCellBgcolor = getCellBackgroundStyle(cel);
			return new StringBuilder().append(styleCellAlign).append(
					styleCellBorder).append(styleCellFont).append(
					styleCellBgcolor).toString();
		}
		return null;
	}

	public String getCellAlignment(HSSFCell cell) {
		HSSFCellStyle style = cell.getCellStyle();
		if ((cell != null) && (style != null)) {
			switch (style.getAlignment()) {
			case 2:
				return "text-align:center;";
			case 1:
				return "text-align:left;";
			case 3:
				return "text-align:right;";
			}

		}

		return "";
	}

	public String getCellBackgroundStyle(HSSFCell cell) {
		HSSFCellStyle style = cell.getCellStyle();
		if ((cell != null) && (style != null)) {
			return new StringBuilder().append("background-color:").append(
					(this.cfmCells.containsKey(cell)) ? (String) this.cfmCells.get(cell) : 
						tripleToRGBString(style.getFillForegroundColor())).append(";").toString();
		}

		return "";
	}

	public String getCellBorderStyle(HSSFCell cell) {
		HSSFCellStyle style = cell.getCellStyle();
		StringBuilder sb = new StringBuilder();
		if ((cell != null) && (style != null)) {
			switch (style.getBorderBottom()) {
			case 3:
				sb.append("border-bottom:dashed;");
				break;
			case 7:
				sb.append("border-bottom:dotted;");
				break;
			case 0:
				sb.append("border-bottom:none;");
				break;
			case 2:
				sb.append("border-bottom:medium none;");
				break;
			case 6:
				sb.append("border-bottom:double;");
				break;
			case 8:
				sb.append("border-bottom:medium dashed;");
			case 1:
			case 4:
			case 5:
			}
			switch (style.getBorderLeft()) {
			case 3:
				sb.append("border-left:dashed;");
				break;
			case 7:
				sb.append("border-left:dotted;");
				break;
			case 0:
				sb.append("border-left:none;");
				break;
			case 2:
				sb.append("border-left:medium none;");
				break;
			case 6:
				sb.append("border-left:double;");
				break;
			case 8:
				sb.append("border-left:medium dashed;");
			case 1:
			case 4:
			case 5:
			}
			switch (style.getBorderRight()) {
			case 3:
				sb.append("border-right:dashed;");
				break;
			case 7:
				sb.append("border-right:dotted;");
				break;
			case 0:
				sb.append("border-right:none;");
				break;
			case 2:
				sb.append("border-right:medium none;");
				break;
			case 6:
				sb.append("border-right:double;");
				break;
			case 8:
				sb.append("border-right:medium dashed;");
			case 1:
			case 4:
			case 5:
			}
			switch (style.getBorderTop()) {
			case 3:
				sb.append("border-top:dashed;");
				break;
			case 7:
				sb.append("border-top:dotted;");
				break;
			case 0:
				sb.append("border-top:none;");
				break;
			case 2:
				sb.append("border-top:medium none;");
				break;
			case 6:
				sb.append("border-top:double;");
				break;
			case 8:
				sb.append("border-top:medium dashed;");
			case 1:
			case 4:
			case 5:
			}
			if (tripleToRGBString(style.getBottomBorderColor()) != null)
				sb
						.append(new StringBuilder().append(
								"border-bottom:1px thin ")
								.append(
										tripleToRGBString(style
												.getBottomBorderColor()))
								.append(";").toString());
			else {
				sb.append("border-bottom:1px thin windowtext;");
			}

			if (tripleToRGBString(style.getLeftBorderColor()) != null)
				sb.append(new StringBuilder().append("border-left:1px thin ")
						.append(tripleToRGBString(style.getLeftBorderColor()))
						.append(";").toString());
			else {
				sb.append("border-left:1px thin windowtext;");
			}

			if (tripleToRGBString(style.getRightBorderColor()) != null)
				sb.append(new StringBuilder().append("border-right:1px thin ")
						.append(tripleToRGBString(style.getRightBorderColor()))
						.append(";").toString());
			else {
				sb.append("border-right:1px thin windowtext;");
			}

			if (tripleToRGBString(style.getTopBorderColor()) != null)
				sb.append(new StringBuilder().append("border-top:1px thin ")
						.append(tripleToRGBString(style.getTopBorderColor()))
						.append(";").toString());
			else {
				sb.append("border-top:1px thin windowtext;");
			}

			return sb.toString();
		}
		return "";
	}

	public String getCellFontStyle(HSSFCell cell) {
		HSSFCellStyle style = cell.getCellStyle();
		StringBuilder sb = new StringBuilder();
		if ((cell != null) && (style != null)) {
			HSSFFont font = style.getFont(this.book);

			sb.append(new StringBuilder().append("font-size:").append(
					font.getFontHeightInPoints()).append("pt;").toString());
			sb.append(new StringBuilder().append("font-weight:").append(
					font.getBoldweight()).append(";").toString());

			if (tripleToRGBString(font.getColor()) != null) {
				sb.append(new StringBuilder().append("color:").append(
						tripleToRGBString(font.getColor())).append(";")
						.toString());
			}

			sb.append("font-family:tahoma;");

			if (font.getItalic()) {
				sb.append("font-style:italic;");
			}
			return sb.toString();
		}
		return "";
	}
	
	@SuppressWarnings("rawtypes")
	public String xlsToHtml(int sheetIdx) throws Exception {
		if ((this.book == null) && (this.sheet == null)) {
			open(sheetIdx);
		}
		StringBuilder sb = new StringBuilder();
		sb
				.append(new StringBuilder().append(
						"<table cellspacing=\"0\" style=\"width:").append(
						this.htmlTbWidth).append("px;table-layout:fixed\">")
						.toString());

		Iterator itor = this.sheet.rowIterator();
		while (itor.hasNext()) {
			HSSFRow row = (HSSFRow) itor.next();
			sb.append("<tr>");
			int i = 0;
			for (int size = row.getLastCellNum() - row.getFirstCellNum(); i < size; ++i) {
				HSSFCell cell = (HSSFCell) getCell(row.getRowNum(), i);
				sb.append(new StringBuilder().append("<td ").append(
						getCellStyle(cell)).append(">").toString());
				sb.append(getCellContent(cell));
				sb.append("</td>");
			}
			sb.append("</tr>");
		}

		sb.append("</table>");
		return sb.toString();
	}

	public Object getCell(int rowIdx, int columnIdx) {
		HSSFRow row = this.sheet.getRow(rowIdx);
		HSSFCell cell = null;
		if (row != null) {
			cell = row.getCell(columnIdx);
			if (isCellInConditionalFormat(this.cfms, cell) == null) {
			}
		}

		return cell;
	}

	public Object getCellContent(int rowIdx, int columnIdx) {
		return getCellContent(getCell(rowIdx, columnIdx));
	}

	public Object getCellContent(Object cell) {
		if (cell != null) {
			HSSFCell cel = (HSSFCell) cell;
			HSSFFormulaEvaluator evaluator = new HSSFFormulaEvaluator(this.book);
			CellValue cellValue = evaluator.evaluate(cel);
			switch (cel.getCellType()) {
				case HSSFCell.CELL_TYPE_NUMERIC: 
					if (HSSFDateUtil.isCellDateFormatted(cel))
					{
						return UtilDate.parseTime(cel.getDateCellValue(), "yyyy-MM-dd HH:mm:ss");
					}
					else
					{
						return Double.valueOf(cellValue.getNumberValue());
					}
				case HSSFCell.CELL_TYPE_STRING:
					return cellValue.getStringValue();
				case HSSFCell.CELL_TYPE_BOOLEAN:
					return Boolean.valueOf(cellValue.getBooleanValue());
				case HSSFCell.CELL_TYPE_ERROR:
					return Byte.valueOf(cellValue.getErrorValue());
				case HSSFCell.CELL_TYPE_BLANK:
					break;
				case HSSFCell.CELL_TYPE_FORMULA:
					return cellValue.formatAsString();
				default:
					return null;
			}
		}
		return null;
	}

	public Integer getColumnCount() {
		HSSFRow headerRow = this.sheet.getRow(0);
		int count = headerRow.getLastCellNum() - headerRow.getFirstCellNum();
		//return Integer.valueOf((this.sheet != null) ? headerRow.getRowNum()
		//		: 0);
		//return null;
		return Integer.valueOf(count);
	}
	
	public Integer getRowCount() {
		int count = this.sheet.getLastRowNum() - this.sheet.getFirstRowNum() + 1;
		//this.sheet.
		//Iterator rows = this.sheet.rowIterator();
		//while (rows.hasNext()) {
		//	++count;
		//}
		return Integer.valueOf(count);
	}

	private HSSFSheet getSheet(int sheetIdx) {
		this.sheet = this.book.getSheetAt(sheetIdx);
		return this.sheet;
	}

	private Boolean isCellInConditionalFormat(
			HSSFSheetConditionalFormatting cfms, HSSFCell cell) {
		if ((cell != null) && (cfms != null)) {
			int rowIdx = cell.getRowIndex();
			int columnIdx = cell.getColumnIndex();
			if (cfms.getNumConditionalFormattings() > 0) {
				int i = 0;
				for (int len = cfms.getNumConditionalFormattings(); i < len; ++i) {
					
					if (cfms.getConditionalFormattingAt(i).getNumberOfRules() <= 0) {
						continue;
					}
					
					for (int k = 0; k < cfms.getConditionalFormattingAt(i).getFormattingRanges().length; ++k) {
						
						if (!(cfms.getConditionalFormattingAt(i).getFormattingRanges()[k].isInRange(rowIdx,columnIdx))) {
							continue;
						}
						
						for (int j = 0, size = cfms.getConditionalFormattingAt(i).getNumberOfRules(); j < size; ++j) {
							HSSFConditionalFormattingRule rule = cfms.getConditionalFormattingAt(i).getRule(j);
							handleContionalFormatCell(rule, cell);
						}
						return Boolean.valueOf(true);
					}
				}
			}
		}
		return Boolean.valueOf(false);
	}

	@SuppressWarnings("unused")
	private Boolean isCellInConditionalFormat(
			HSSFSheetConditionalFormatting cfms, int rowIdx, int columnIdx) {
		return isCellInConditionalFormat(cfms, (HSSFCell) getCell(rowIdx,
				columnIdx));
	}

	@SuppressWarnings("rawtypes")
	private HSSFColor getHSSFColor(short color) {
		Hashtable hash = HSSFColor.getIndexHash();
		Iterator itor = hash.keySet().iterator();
		while (itor.hasNext()) {
			Integer itg = (Integer) itor.next();
			if (itg.intValue() == color) {
				return ((HSSFColor) hash.get(itg));
			}
		}
		return null;
	}

	private String tripleToRGBString(short color) {
		HSSFColor colour = getHSSFColor(color);
		StringBuilder sb = new StringBuilder();
		if (colour != null) {
			int i = 0;
			for (int len = colour.getTriplet().length; i < len; ++i) {
				short t = colour.getTriplet()[i];
				if (i < len - 1)
					sb.append(new StringBuilder().append(t).append(",")
							.toString());
				else {
					sb.append(t);
				}
			}
			return new StringBuilder().append("rgb(").append(sb.toString())
					.append(")").toString();
		}
		return null;
	}

	private void handleContionalFormatCell(HSSFConditionalFormattingRule rule,
			HSSFCell cell) {
		if ((cell != null) && (rule != null)) {
			
			Object cellValue = getCellContent(cell);
			String formula1 = rule.getFormula1();
			String formula2 = rule.getFormula2();
			String fmtColor = tripleToRGBString(rule.getPatternFormatting().getFillBackgroundColor());
			
			if (this.cfmCells.containsKey(cell)) {
				return;
			}
			
			if (cellValue == null && cellValue instanceof Double) {
				cellValue = 0.0;
			}
			
			try {
//				switch (cell.getCellType()) {
//					case 0:
//					case 2:
//					case 3:
				switch (rule.getConditionType()) {
					case ExcelConstants.ConditionType.CELL_VALUE_IS:
						switch (rule.getComparisonOperation()) {
							case ExcelConstants.ComparisionType.BETWEEN:		//1
								if (cellValue instanceof Double) {
									if ((Double.parseDouble(cellValue.toString()) >= Double.parseDouble(formula1))
										&& (Double.parseDouble(cellValue.toString()) <= Double.parseDouble(formula2))) {
										this.cfmCells.put(cell, fmtColor);
										return;
									}
								}
								break;
							case ExcelConstants.ComparisionType.EQUALTO:		//3
								if (cellValue instanceof String) {
									if (("\"" + cellValue.toString() + "\"").equals(formula1)) {
										this.cfmCells.put(cell, fmtColor);
										return;
									}
								} else if (cellValue instanceof Double) {
									if (Double.parseDouble(cellValue.toString()) == Double.parseDouble(formula1)) {
										this.cfmCells.put(cell, fmtColor);
										return;
									}
								}
								break;
							case ExcelConstants.ComparisionType.GREATERTHAN:	//5
								if (Double.parseDouble(cellValue.toString()) > Double.parseDouble(formula1)) {
									this.cfmCells.put(cell, fmtColor);
									return;
								}
								break;
							case ExcelConstants.ComparisionType.GREATERTHAN_OR_EQUALTO:		//7
								if (Double.parseDouble(cellValue.toString()) >= Double.parseDouble(formula1)) {
									this.cfmCells.put(cell, fmtColor);
									return;
								}
								break;
							case ExcelConstants.ComparisionType.LESSTHAN:		//6
								if (Double.parseDouble(cellValue.toString()) < Double.parseDouble(formula1)) {
									this.cfmCells.put(cell, fmtColor);
									return;
								}
								break;
							case ExcelConstants.ComparisionType.LESSTHAN_OR_EQUALTO:	//8
								if (Double.parseDouble(cellValue.toString()) <= Double.parseDouble(formula1)) {
									this.cfmCells.put(cell, fmtColor);
									return;
								}
								break;
							case ExcelConstants.ComparisionType.NOT_EQUALTO:			//4
								if (Double.parseDouble(cellValue.toString()) != Double.parseDouble(formula1)) {
									this.cfmCells.put(cell, fmtColor);
									return;
								}
								break;
							case ExcelConstants.ComparisionType.NOTBETWEEN:				//2
								if ((Double.parseDouble(cellValue.toString()) < Double.parseDouble(formula1))
										&& (Double.parseDouble(cellValue.toString()) > Double.parseDouble(formula2))) {
									this.cfmCells.put(cell, fmtColor);
									return;
								}
								break;
						}
					case ExcelConstants.ConditionType.FORMULA_IS:
						break;
				}
//				}
			} catch (Exception e) {
				this.cfmCells.put(cell, "#FFFFFF");
				logger.error("handling the contional format cell errors: " + e);
			}
		}
	}
	
	@Override
	public List<ExcelRowData> getRowData(int sheetIndex)
	{
		try 
		{
			this.open(sheetIndex);
			int colNum = this.getColumnCount();
			int rowNum = this.getRowCount();
			
			List<ExcelRowData> rowDataList = new ArrayList<ExcelRowData>();
			
			for(int i = 0; i< rowNum; i++)
			{
				ExcelRowData exRowData = new ExcelRowData();
				for(int j=0; j< colNum; j++)
				{
					Object dat = this.getCell(i, j);
					String style = this.getCellStyle(i, j);
					exRowData.setRowId(i);
					exRowData.setRowData(String.valueOf(this.getCellContent(dat)));
					exRowData.setRowStyle(style);
				}
				
				rowDataList.add(exRowData);
			}
			this.close();
			return rowDataList;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return null;
	}

	public void setBook(HSSFWorkbook book) {
		this.book = book;
	}

	public HSSFWorkbook getBook() {
		return this.book;
	}

	public void setSheet(HSSFSheet sheet) {
		this.sheet = sheet;
	}

	public HSSFSheet getSheet() {
		return this.sheet;
	}

	public void setCfms(HSSFSheetConditionalFormatting cfms) {
		this.cfms = cfms;
	}

	public HSSFSheetConditionalFormatting getCfms() {
		return this.cfms;
	}

	public void setCfmCells(HashMap<HSSFCell, String> cfmCells) {
		this.cfmCells = cfmCells;
	}

	public HashMap<HSSFCell, String> getCfmCells() {
		return this.cfmCells;
	}

	public static void setLogger(Logger logger) {
		PoiExcelParser.logger = logger;
	}

	public static Logger getLogger() {
		return logger;
	}
	
	public static void main(String[] args) {
		
		PoiExcelParser poiExcelParser = new PoiExcelParser ("D:\\test2.xls");
		List<ExcelRowData> excelRowData = poiExcelParser.getRowData(0);
		for (ExcelRowData row : excelRowData)
		{
			if (row.getRowData() != null)
			{
				for (String data : row.getRowData())
				{
					System.out.println(data);
				}
			}
		}
	}
}