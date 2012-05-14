package org.shengrui.oa.utilities;

import java.io.Serializable;

/**
 * 
 * @author Jeccy.Zhao
 *
 * @param <T>
 * @param <K>
 */
public class PairObject<T,K> implements Serializable 
{
	
	private static final long serialVersionUID = 3823490598416805324L;
	
	private T left;
	private K right;
	
	public PairObject() 
	{ 
		
	}
	
	public PairObject(T left, K right)
	{
		this.left = left;
		this.right = right;
	}
	
	public void setLeft(T left) 
	{
		this.left = left;
	}
	public T getLeft() 
	{
		return left;
	}
	public void setRight(K right) 
	{
		this.right = right;
	}
	public K getRight() 
	{
		return right;
	}
	
	@Override
	public String toString () 
	{
		return "(" + left + ": " + right + ")";
	}
	
}
