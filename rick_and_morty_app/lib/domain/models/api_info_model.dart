class ApiInfoModel {

  final int count;
  final int pages;
  final String? next;
  final String? prev;

  ApiInfoModel({
    required this.count,
    required this.pages,
    this.next = '',
    this.prev = '',
  });

  List<Object?> get props => [count, pages, next, prev];
}