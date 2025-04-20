public enum PagingUtil {
    public static func isLastPage(index: Int, pagingInterval: Int, count: Int) -> Bool {
        return index % pagingInterval == (pagingInterval - 1) &&
               index / pagingInterval == (count - 1) / pagingInterval
    }
}
