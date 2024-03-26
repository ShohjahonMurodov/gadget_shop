class CategoryModels {
  CategoryModels({required this.categoryName, required this.docId});

  final String categoryName;
  final String docId;

  factory CategoryModels.fromJson(Map<String, dynamic> json) {
    return CategoryModels(
      categoryName: json["category_name"] as String? ?? "",
      docId: json["doc_id"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "doc_id": "",
      "category_name": categoryName,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      "category_name": categoryName,
    };
  }
}
