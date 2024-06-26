import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadget_shop/data/local/local_varibalse.dart';
import 'package:gadget_shop/data/product/product_model.dart';
import 'package:gadget_shop/services/local_notification_service.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/fuctions/utility_functions.dart';

class ProductsViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<ProductModel> categoryProduct = [];

  Stream<List<ProductModel>> listenProducts() => FirebaseFirestore.instance
      .collection(AppConstants.products)
      .snapshots()
      .map(
        (event) =>
            event.docs.map((doc) => ProductModel.fromJson(doc.data())).toList(),
      );

  Future<void> getProductsByCategory(String categoryDocId) async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection(AppConstants.products)
        .where("category_id", isEqualTo: categoryDocId)
        .get()
        .then((snapshot) {
      categoryProduct =
          snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    });
    _notify(false);
  }

  insertProducts(ProductModel productModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .doc(cf.id)
          .update({"doc_id": cf.id});

      LocalNotificationService.localNotificationService.showNatification(
        title: "${productModel.productName} nomli mahsulot qo'shildi!",
        body: "Mahsulot haqida ma'lumot olishingiz mumkin.",
        id: idContLocal,
      );

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }

  updateProduct(ProductModel productModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .doc(productModel.docId)
          .update(productModel.toJsonForUpdate());

      LocalNotificationService().showNatification(
        title: "${productModel.productName} nomli mahsulot update bo'ldi!",
        body: "Mahsulot haqida ma'lumot olishingiz mumkin.",
        id: idContLocal,
      );

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }

  deleteProduct(ProductModel productModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .doc(productModel.docId)
          .delete();

      FirebaseStorage.instance.ref().child(productModel.storagePath).delete();

      LocalNotificationService().showNatification(
        title: "${productModel.docId} dagi ma'lumot o'chirib yuborildi!",
        body: "Batafsil bilish uchun, ustidan bosing.",
        id: idContLocal,
      );

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
