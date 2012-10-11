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

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import cn.trymore.core.util.UtilString;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.biff.EmptyCell;
import jxl.format.Border;
import jxl.format.RGB;

/**
 * 
 * JXL excel parser
 * 
 * @author Jeccy.Zhao
 *
 */
public class JxlExcelParser extends AbstractExcelParser {
	private Workbook book;
	private Sheet sheet;

	public JxlExcelParser() {
		this.book = null;
		this.sheet = null;
	}

	public JxlExcelParser(String xlsFile) {
		this(xlsFile, 1000);
	}

	public JxlExcelParser(String xlsFile, int htmlTbWidth) {
		this.book = null;
		this.sheet = null;

		this.xlsFile = xlsFile;
		this.htmlTbWidth = htmlTbWidth;
	}

	public void open(int sheetIdx) throws Exception {
		WorkbookSettings workbookSettings = new WorkbookSettings();
		workbookSettings.setEncoding("ISO-8859-1");
		setBook(Workbook.getWorkbook(new File(this.xlsFile), workbookSettings));
		this.sheet = getSheet(sheetIdx);
	}

	public void close() {
		if (this.book != null)
			this.book.close();
	}

	public String getCellStyle(int rowIdx, int columnIdx) {
		return null;
	}

	public String getCellStyle(Object cell) {
		Cell cel = (Cell) cell;
		StringBuilder sb = new StringBuilder();
		sb.append(getCellBackgroundStyle(cel));
		sb.append(getCellBorderStyle(cel));
		sb.append(getCellFontStyle(cel));
		return sb.toString();
	}

	@SuppressWarnings("deprecation")
	public String xlsToHtml(int sheetIdx) throws Exception {
		if ((this.book == null) && (this.sheet == null)) {
			open(sheetIdx);
		}

		PoiExcelParser poi = new PoiExcelParser(this.xlsFile);
		poi.open(sheetIdx);

		StringBuilder sb = new StringBuilder();
		StringBuilder columnSb = new StringBuilder();

		sb.append("<table cellspacing=\"0\" style=\"width:100%;border-collapse:collapse;\">");

		List<Integer> dimension = new ArrayList<Integer>();

		int dmsTotal = 0;
		for (int i = 0; i < getColumnCount().intValue(); ++i) {
			dimension.add(Integer.valueOf(this.sheet.getColumnView(i)
					.getDimension()));
			dmsTotal += this.sheet.getColumnView(i).getDimension();
		}

		int avgSeed = (dmsTotal - this.htmlTbWidth > 0) ? Integer.valueOf(
				(dmsTotal - this.htmlTbWidth) / getColumnCount().intValue())
				.intValue() : 0;

		for (int i = 0; i < getColumnCount().intValue(); ++i) {
			columnSb.append(new StringBuilder().append("<col width='").append(
					((Integer) dimension.get(i)).intValue() - avgSeed).append(
					"px'></col>").toString());
		}

		for (int i = 0; i < getRowCount().intValue(); ++i) {
			StringBuilder sbCell = new StringBuilder();
			boolean flag = false;
			for (int j = 0; j < getColumnCount().intValue(); ++j) {
				Cell cell = (Cell) getCell(i, j);

				if (poi.getCellStyle(i, j) != null) {
					flag = true;
				}

				String style = new StringBuilder().append(
						poi.getCellStyle(i, j))
						.append(getCellBorderStyle(cell)).toString();
				sbCell.append(new StringBuilder().append("<td style=\"")
						.append(style).append("\">").toString());

				Object content = getCellContent(cell);
				if ((content != null)
						&& (!(content.toString().trim().equals("")))
						&& (!(content.toString().trim().equals("&nbsp;"))))
					sbCell.append(getCellContent(cell).toString());
				else {
					sbCell.append("&nbsp;");
				}

				sbCell.append("</td>");
			}

			if (flag) {
				sb.append(new StringBuilder().append("<tr>").append(
						sbCell.toString()).append("</tr>").toString());
			} else {
				sb.append("</table>");
				sb.append("<br>");
				sb
						.append("<table cellspacing=\"0\" style=\"width:100%;border-collapse:collapse;\">");
			}

		}

		sb.append("</table>");
		close();
		return sb.toString();
	}

	public Object getCell(int rowIdx, int columnIdx) {
		return this.sheet.getCell(columnIdx, rowIdx);
	}

	public Object getCellContent(int rowIdx, int columnIdx) {
		return getCellContent((Cell) getCell(rowIdx, columnIdx));
	}

	public Object getCellContent(Object cell) {
		Cell cel = (Cell) cell;
		String content = ((cel != null) && (cel instanceof EmptyCell)) ? "&nbsp;"
				: (cel.getContents().trim() != "") ? UtilString.filter(cel
						.getContents()) : "";

		if (content.trim().startsWith("<")) {
			content = content.replaceFirst("<", "&lt;");
		}

		if (content.trim().endsWith(">")) {
			content = new StringBuilder().append(
					content.substring(0, content.length() - 1)).append("&gt;")
					.toString();
		}

		content = content.replace("\n", "<br>");

		return content;
	}

	public Integer getColumnCount() {
		return Integer.valueOf((this.sheet != null) ? this.sheet.getColumns()
				: 0);
	}

	public Integer getRowCount() {
		return Integer.valueOf((this.sheet != null) ? this.sheet.getRows() : 0);
	}

	private Sheet getSheet(int sheetIdx) {
		this.sheet = this.book.getSheet(sheetIdx);
		return this.sheet;
	}

	public String getCellFontStyle(Cell cell) {
		if ((cell != null) && (!(cell instanceof EmptyCell))) {
			return new StringBuilder().append("font-size:").append(
					cell.getCellFormat().getFont().getPointSize())
					.append("pt;").append("font-weight:").append(
							cell.getCellFormat().getFont().getBoldWeight())
					.append(";").append("font-family:").append(
							cell.getCellFormat().getFont().getName()).append(
							";").append("color:#000;").toString();
		}

		return "";
	}

	public String getCellAlignment(Cell cell) {
		if ((cell != null) && (!(cell instanceof EmptyCell))) {
			String align = cell.getCellFormat().getAlignment().getDescription();
			return (("center".equals(align.toLowerCase())) ? "center" : align);
		}
		return "";
	}

	public String getCellBackgroundStyle(Cell cell) {
		if ((cell != null) && (!(cell instanceof EmptyCell))) {
			RGB rgb = cell.getCellFormat().getBackgroundColour()
					.getDefaultRGB();

			return new StringBuilder().append("background-color:").append(
					getRGBStyle(rgb)).append(";").toString();
		}
		return "";
	}

	private String getRGBStyle(RGB rgb) {
		if (rgb != null) {
			int red = rgb.getRed();
			int green = rgb.getGreen();
			int blue = rgb.getBlue();
			return new StringBuilder().append("rgb(").append(red).append(",")
					.append(green).append(",").append(blue).append(")")
					.toString();
		}
		return null;
	}

	public String getCellBorderStyle(Cell cell) {
		if ((cell != null) && (!(cell instanceof EmptyCell))
				&& (cell.getCellFormat().hasBorders())) {
			StringBuilder sb = new StringBuilder();

			@SuppressWarnings("unused")
			String color = null;

			if ((color = getRGBStyle(cell.getCellFormat().getBorderColour(
					Border.BOTTOM).getDefaultRGB())) != null) {
				sb.append("border-bottom:1pt solid windowtext;");
			}
			if ((color = getRGBStyle(cell.getCellFormat().getBorderColour(
					Border.LEFT).getDefaultRGB())) != null) {
				sb.append("border-left:1pt solid windowtext;");
			}
			if ((color = getRGBStyle(cell.getCellFormat().getBorderColour(
					Border.TOP).getDefaultRGB())) != null) {
				sb.append("border-top:1pt solid windowtext;");
			}
			if ((color = getRGBStyle(cell.getCellFormat().getBorderColour(
					Border.RIGHT).getDefaultRGB())) != null) {
				sb.append("border-right:1pt solid windowtext;");
			}
			return sb.toString();
		}
		return "";
	}

	@SuppressWarnings("unused")
	private String preventLink (String text) {
		if ((text != null) && (!(text.trim().equals("")))) {
			String wikiWord = text;
			Pattern pattern = Pattern.compile("\\s+");
			String[] words = pattern.split(wikiWord.trim());
			for (String word : words) {
				wikiWord = wikiWord.replace(word, new StringBuilder().append(
						"!").append(word).toString());
			}
			return wikiWord;
		}
		return text;
	}
	
	@Override
	public List<ExcelRowData> getRowData(int sheetIndex)
	{
		return null;
	}

	public void setBook(Workbook book) {
		this.book = book;
	}

	public Workbook getBook() {
		return this.book;
	}

	public static void main(String[] args) {
		JxlExcelParser parser = new JxlExcelParser(
				"D:\\x36zhao\\Desktop\\Copy of BB_Arch_integration_schedule_status_2.xls");
				//"D:\\x36zhao\\Desktop\\EP1_Dashboard.xls");
		try {
			System.out.println(parser.xlsToHtml(0));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}