class EventFilter {
  static Map<String, String> buildQueryParams({
    String? keyword,
    bool? trending,
    int size = 10,
    int page = 1,
    String? category,
  }) {
    final Map<String, String> queryParams = {
      'size': size.toString(),
      'page': page.toString(),
    };

    if (keyword != null && keyword.isNotEmpty) {
      queryParams['keyword'] = keyword;
    }
    if (trending != null) {
      queryParams['trending'] = trending.toString();
    }
    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category;
    }

    return queryParams;
  }
}
