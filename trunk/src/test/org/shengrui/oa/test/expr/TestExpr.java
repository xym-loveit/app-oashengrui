package org.shengrui.oa.test.expr;

import com.greenpineyu.fel.FelEngine;
import com.greenpineyu.fel.FelEngineImpl;
import com.greenpineyu.fel.context.FelContext;

public class TestExpr
{
	
	public static void main(String[] args)
	{
		FelEngine fel = new FelEngineImpl();
		FelContext cxt = fel.getContext();
		cxt.set("x", 100);
		System.out.println(fel.eval("x > 0 && x < 1000"));
		
	}
	
}
