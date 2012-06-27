package org.shengrui.oa.test.expr;

import com.googlecode.aviator.AviatorEvaluator;
import com.googlecode.aviator.Expression;

import java.util.Map;
import java.util.HashMap;

public class TestExpr
{
	
	public static void main(String[] args)
	{
		Expression expr = AviatorEvaluator.compile("x > 0 && x < 1000");
		Map<String, Object> env = new HashMap<String, Object>();
		env.put("x", 340);
		
		Boolean result = (Boolean)expr.execute(env);
		System.out.println(result);
	}
	
}
