class ProductModel {
  ProductModel(
      {required this.docId,
      required this.productName,
      required this.price,
      required this.categoryId,
      required this.imageUrl,
      required this.storagePath});

  final String docId;
  final String productName;
  final double price;
  final String categoryId;
  final String imageUrl;
  final String storagePath;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      docId: json["doc_id"] as String? ?? "",
      categoryId: json["category_id"] as String? ?? "",
      productName: json["product_name"] as String? ?? "",
      price: json["price"] as double? ?? 0.0,
      imageUrl: json["image_url"] as String? ?? "",
      storagePath: json["storage_path"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "doc_id": "",
      "product_name": productName,
      "price": price,
      "category_id": categoryId,
      "image_url": imageUrl,
      "storage_path": storagePath,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      "product_name": productName,
      "price": price,
      "category_id": categoryId,
      "image_url": imageUrl,
      "storage_path": storagePath,
    };
  }
}
