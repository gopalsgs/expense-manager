import 'package:expense_manager/core/ui_util.dart';
import 'package:expense_manager/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/base_bloc.dart';
import '../../../repo/categories_repo.dart';

class CategoriesBloc extends BaseBloc {
  final CategoriesRepo _repo = CategoriesRepo();

  Stream<List<CategoryModel>> getAllCategories() {
    return _repo.getAllCategories();
  }

  Future addNewCategory(BuildContext context, String categoryName) async {
    await _repo.addNewCategory(categoryName);
    UIUtils.showSnackBar(context: context, text: 'Category Created');
  }
}
