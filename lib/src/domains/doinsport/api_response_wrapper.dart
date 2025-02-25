class ApiResponseWrapper<T> {
  final List<T> data;
  final int totalItems;

  ApiResponseWrapper({required this.data, required this.totalItems});

  factory ApiResponseWrapper.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) contentMapper,
  ) {
    var list = json['hydra:member'] as List;
    List<T> items = list.map((item) => contentMapper(item)).toList();

    return ApiResponseWrapper<T>(
      data: items,
      totalItems: json['hydra:totalItems'],
    );
  }
}
