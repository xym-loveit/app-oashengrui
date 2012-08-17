package cn.trymore.core.acl;

@SuppressWarnings("rawtypes")
public class DataPolicyEngine
{
	//本地线程，用于存储线程公共对象
	private static ThreadLocal threadLocalSession = new ThreadLocal();
	
	/**
	 * 获取本地执行线程
	 *
	 * @return ThreadLocal 
	 * 
	 */
	public static ThreadLocal getThreadLocalSession() 
	{
		return threadLocalSession;
	}
	
	/**
	 * 获取在线程内设置存储的对象
	 */
	public static Object get() 
	{
		return threadLocalSession.get();
	}
	
	/**
	 * 在线程内设置存储对象
	 */
	@SuppressWarnings("unchecked")
	public static void set(Object obj) 
	{
		threadLocalSession.set(obj);
	}
	
	/**
	 * 移除在线程内设置存储的对象
	 */
	public static void remove() 
	{
		threadLocalSession.remove();
	}
	
}
