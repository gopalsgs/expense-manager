import 'package:expense_manager/model/category_model.dart';
import 'package:expense_manager/model/transaction_model.dart';

import '../../../core/base_bloc.dart';
import '../../../repo/transaction_repo.dart';
import 'package:flutter/foundation.dart';

class AddTransactionBloc extends BaseBloc {
  
  final TransactionRepo _repo = TransactionRepo();

  CategoryModel _selectedCategory = CategoryModel(id: '', name: 'Select Category');

  CategoryModel get selectedCategory => _selectedCategory;
  set selectedCategory(CategoryModel selectedCategory) {
    _selectedCategory = selectedCategory;
    notifyListeners();
  }

  Future addNewTransaction({
    @required TransactionModel transaction,
  }) async {
    await _repo.addNewTransaction(transaction);
  }
}
