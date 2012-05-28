package cn.trymore.core.web.paging;

import java.util.LinkedList;
import java.util.List;

/**
 * 
 * Actually, it's copied form some other's whose name is Rory. 
 * Anyway, it release our workaround  \(^o^)/~ 
 * What we need do is learning how to use it and revise it by our requirements.
 * 
 * @author <a href="rory.cn@gmail.com">Rory</a> 
 *
 * @param <T>
 */
public class PaginationSupport<T> 
{

	// ---------------------------------------------------------
	// static variables
	// ---------------------------------------------------------

	// 默认每页显示条数
	public static final int DEFAULT_MAX_PAGE_ITEMS = 10;

	// 默认开始记录条数
	public static final int DEFAULT_OFFSET = 0;

	// 默认显示页码最大数
	public static final int DEFAULT_MAX_INDEX_PAGES = 10;

	// 默认分页显示的最多页数
	public static final int DEFAULT_MAX_PAGE_INDEX_NUMBER = 12;
	
	// index 为索引页位置, 可以选择 "center", "forward", "half-full"
	public static final String DEFALUT_INDEX = "center";

	// ---------------------------------------------------------
	// memeber variables
	// ---------------------------------------------------------

	// 开始记录条数
	private int offset = 0;

	// 每页显示条数
	private int maxPageItems = DEFAULT_MAX_PAGE_ITEMS;

	// 显示页码最大数
	private int maxIndexPages = DEFAULT_MAX_INDEX_PAGES;
	
	//分页显示的最多页数
	private int maxPageIndexNumber = DEFAULT_MAX_PAGE_INDEX_NUMBER;
	
	// 总记录数
	private int totalCount;

	//总页数
	private int totalPage;
	
	//当前页
	private int currentPage;
	
	//当前Start页面
	private int currentPageStartIndex;
	
	//当前End页面
	private int currentPageEndIndex;
	
	// 返回结果集
	private List<T> items = new LinkedList<T>();

	private int itemCount = 0;
	
	// index 为索引页位置, 可以选择 "center", "forward", "half-full"
	private String index = DEFALUT_INDEX;

	// 页数数组
	private int[] pages = new int[0];

	private int[] indexes = new int[0];
	
	public PaginationSupport() {
		setMaxIndexPages(DEFAULT_MAX_INDEX_PAGES);
		setTotalCount(0);
		setOffset(0);
		setItems(new LinkedList<T>());
		setCurrentPageStartIndex();
		setCurrentPageEndIndex();
		itemCount = items.size();
	}
	
	public PaginationSupport(List<T> items, int totalCount) {
		setMaxPageItems(DEFAULT_MAX_PAGE_ITEMS);
		setTotalCount(totalCount);
		setItems(items);
		setOffset(PagerFacade.getOffset());
		setCurrentPageStartIndex();
		setCurrentPageEndIndex();
		itemCount = items.size();
	}

	public PaginationSupport(List<T> items, int totalCount, int offset) {
		setMaxPageItems(DEFAULT_MAX_PAGE_ITEMS);
		setTotalCount(totalCount);
		setItems(items);
		setOffset(offset);
		setCurrentPageStartIndex();
		setCurrentPageEndIndex();
		itemCount = items.size();
	}

	public PaginationSupport(List<T> items, int totalCount, int offset, int maxPageItems) {
		setMaxPageItems(maxPageItems);
		setTotalCount(totalCount);
		setItems(items);
		setOffset(offset);
		setCurrentPageStartIndex();
		setCurrentPageEndIndex();
		itemCount = items.size();
	}

	public PaginationSupport(List<T> items, int totalCount, int offset, int maxPageItems, int maxIndexPages, String index) {
		setMaxPageItems(maxPageItems);
		setTotalCount(totalCount);
		setItems(items);
		setOffset(offset);
		setMaxIndexPages(maxIndexPages);
		setIndex(index);
		setCurrentPageStartIndex();
		setCurrentPageEndIndex();
		itemCount = items.size();
	}

	public List<T> getItems() {
		return items;
	}

	public void setItems(List<T> items) {
		if (items == null) {
			this.items = new LinkedList<T>();
		} else {
			this.items = items;
		}
	}

	public int getPageIndex(){
		return currentPage * maxPageItems;
	}
	
	public int getCurrentOffset(){
		return (currentPage - 1) * maxPageItems + 1;
	}
	
	public int getCurrentPageStartIndex(){
		return currentPageStartIndex;
	}
	
	public void setCurrentPageStartIndex(){
		currentPageStartIndex = offset + 1;
	}
	
	public int getCurrentPageEndIndex(){
		return currentPageEndIndex;
	}
	
	public void setCurrentPageEndIndex(){
		currentPageEndIndex = currentPage < totalPage ? (currentPage * maxPageItems) : totalCount;
	}
	
	public int getMaxPageItems() {
		return maxPageItems;
	}

	public void setMaxPageItems(int maxPageItems) {
		this.maxPageItems = maxPageItems;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		if (totalCount > 0) {
			this.totalCount = totalCount;
			int count = totalCount / maxPageItems;
			if (totalCount % maxPageItems > 0) {
				count++;
			}
			this.totalPage = count;
			indexes = new int[count];
			for (int i = 0; i < count; i++) {
				indexes[i] = maxPageItems * i;
			}
		} else {
			this.totalCount = 0;
		}
	}

	public int[] getPages() {
		return pages;
	}

	public void setPages(int[] pages) {
		this.pages = pages;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int startIndex) {
		if (totalCount <= 0)
			this.offset = 0;
		else if (startIndex >= totalCount)
			this.offset = indexes[indexes.length - 1];
		else if (startIndex < 0)
			this.offset = 0;
		else {
			this.offset = indexes[startIndex / maxPageItems];
		}
		this.currentPage = offset/maxPageItems + 1;
		if (totalPage>maxPageIndexNumber) {
			pages = new int[maxPageIndexNumber];
			pages[0] = 1;
			if(this.currentPage<maxPageIndexNumber/2) {
				for(int i=1; i<=maxPageIndexNumber-3; i++) {
					pages[i] = i+1;
				}
				pages[maxPageIndexNumber-2] = 0;
			}else if(this.currentPage>maxPageIndexNumber/2 && this.currentPage<(totalPage-maxPageIndexNumber/2)){
				int tmp = (maxPageIndexNumber-2)/2;
				pages[1] = 0;
				for(int i=2; i<=maxPageIndexNumber-3; i++) {
					pages[i] = currentPage - tmp + i;
				}
				pages[maxPageIndexNumber-2] = 0;
			}else{
				pages[1] = 0;
				for(int i=2; i<=maxPageIndexNumber-2; i++) {
					pages[i] = totalPage-maxPageIndexNumber+i+1;
				}
			}
			pages[maxPageIndexNumber-1] = totalPage;
		}else{
			pages = new int[totalPage];
			for(int i=0; i<totalPage; i++) {
				pages[i] = i+1;
			}
		}
	}

	public int getNextIndex() {
		int nextIndex = getOffset() + maxPageItems;
		return nextIndex >= totalCount ? getOffset() : nextIndex;
	}

	public int getPreviousIndex() {
		int previousIndex = getOffset() - maxPageItems;
		return previousIndex < 0 ? DEFAULT_OFFSET : previousIndex;
	}

	/**
	 * @return Returns the dEFAULT_MAX_INDEX_PAGES.
	 */
	public static int getDEFAULT_MAX_INDEX_PAGES() {
		return DEFAULT_MAX_INDEX_PAGES;
	}

	public int getMaxIndexPages() {
		return maxIndexPages;
	}

	public void setMaxIndexPages(int maxIndexPages) {
		this.maxIndexPages = maxIndexPages;
	}

	public String getIndex() {
		return index;
	}

	public void setIndex(String index) {
		this.index = index;
	}

	public int getMaxPageIndexNumber() {
		return maxPageIndexNumber;
	}

	public void setMaxPageIndexNumber(int maxPageIndexNumber) {
		this.maxPageIndexNumber = maxPageIndexNumber;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int[] getIndexes() {
		return indexes;
	}

	public void setIndexes(int[] indexes) {
		this.indexes = indexes;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public int getItemCount(){
		return itemCount;
	}
	
	public void setItemCount(int itemCount){
		this.itemCount = itemCount;
	}
	
	/**
	 * @param args
	 * @throws Exception
	 * @author <a href="mailto:rory.cn@gmail.com">somebody</a>
	 */
	public static void main(String[] args)throws Exception{
		PaginationSupport<String> ps = new PaginationSupport<String>(null, 10, 4, 2);
		int[] pages = ps.getPages();
		for(int i=0; i<pages.length; i++) {
			System.out.print(pages[i] + "\t");
		}
		System.out.println(ps.getPreviousIndex());
		System.out.println("_" + ps.getCurrentPage());
	}
}