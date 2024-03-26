import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadget_shop/data/category/category_models.dart';
import 'package:gadget_shop/data/local/local_varibalse.dart';
import 'package:gadget_shop/services/local_notification_service.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/fuctions/utility_functions.dart';

class CategoriesViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<CategoryModels> categories = [];

  Future<void> getCategories() async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .get()
        .then((snapshot) {
      categories =
          snapshot.docs.map((e) => CategoryModels.fromJson(e.data())).toList();
    });
    _notify(false);
  }

  Stream<List<CategoryModels>> listenCategories() => FirebaseFirestore.instance
      .collection(AppConstants.categories)
      .snapshots()
      .map(
        (event) => event.docs
            .map((doc) => CategoryModels.fromJson(doc.data()))
            .toList(),
      );

  insertCategory(CategoryModels categoryModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .add(categoryModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc(cf.id)
          .update({"doc_id": cf.id});

      LocalNotificationService.localNotificationService.showNatification(
        title: "${categoryModel.categoryName} nomli category qo'shildi!",
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

  updateCategory(CategoryModels categoryModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc(categoryModel.docId)
          .update(categoryModel.toJsonForUpdate());

      LocalNotificationService.localNotificationService.showNatification(
        title: "${categoryModel.categoryName} nomli category update bo'ldi!",
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

  deleteCategory(String docId, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc(docId)
          .delete();

      LocalNotificationService.localNotificationService.showNatification(
        title: "Category o'chirildi!",
        body: "",
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
