import 'package:flutter/animation.dart';
import 'package:gadget_shop/data/category/category_models.dart';
import 'package:gadget_shop/data/product/product_model.dart';

List<CategoryModel> globalCategories = [];
List<ProductModel> globalProducts = [];
late AnimationController globalAnimationController;
int idContLocal = 1;
