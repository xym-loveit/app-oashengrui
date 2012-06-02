package cn.trymore.core.web.paging;

public class PagingBean
{
	
	public static Integer DEFAULT_PAGE_SIZE = Integer.valueOf(20);
	
	public static final int DEFAULT_SHOW_PAGES = 10;
	
	public static final String DEFAULT_TARGET_TYPE = "navTab";
	
	private Integer startIndex = 0;
	
	private Integer pageSize = DEFAULT_PAGE_SIZE;
	
	private Integer totalItems = 0;
	
	private Integer currentPage = 1;
	
	private Integer pageNumShown = DEFAULT_SHOW_PAGES;
	
	private String targetType = DEFAULT_TARGET_TYPE;
	
	private Integer totalPages = 0;
	
	public PagingBean (int currentPage, int pageSize)
	{
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.startIndex = (currentPage - 1 < 0 ? 0 : currentPage - 1) * pageSize;
	}

	public Integer getPageSize()
	{
		return pageSize;
	}

	public void setPageSize(Integer pageSize)
	{
		this.pageSize = pageSize;
	}

	public Integer getTotalItems()
	{
		return totalItems;
	}

	public void setTotalItems(Integer totalItems)
	{
		this.totalItems = totalItems;
	}

	public Integer getStartIndex()
	{
		return startIndex;
	}

	public void setStartIndex(Integer startIndex)
	{
		this.startIndex = startIndex;
	}

	public Integer getCurrentPage()
	{
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage)
	{
		this.currentPage = currentPage;
	}

	public Integer getPageNumShown()
	{
		return pageNumShown;
	}

	public void setPageNumShown(Integer pageNumShown)
	{
		this.pageNumShown = pageNumShown;
	}

	public String getTargetType()
	{
		return targetType;
	}

	public void setTargetType(String targetType)
	{
		this.targetType = targetType;
	}

	public Integer getTotalPages()
	{
		return totalPages;
	}

	public void setTotalPages(Integer totalPages)
	{
		this.totalPages = totalPages;
	}
	
}
