package cn.trymore.core.util.excel;

public class ExcelConstants 
{
	
	static class ComparisionType 
	{
		public static final byte BETWEEN = 1;
		public static final byte NOTBETWEEN = 2;
		public static final byte EQUALTO = 3;
		public static final byte NOT_EQUALTO = 4;
		public static final byte GREATERTHAN = 5;
		public static final byte LESSTHAN = 6;
		public static final byte GREATERTHAN_OR_EQUALTO = 7;
		public static final byte LESSTHAN_OR_EQUALTO = 8;
	}

	static class ConditionType 
	{
		public static final byte CELL_VALUE_IS = 1;
		public static final byte FORMULA_IS = 2;
	}
}