import 'package:expense_manager/core/base_bloc.dart';
import 'package:expense_manager/model/category_model.dart';
import 'package:expense_manager/model/transaction_model.dart';
import 'package:expense_manager/repo/transaction_repo.dart';

class TransactionBloc extends BaseBloc {
  final _repo = TransactionRepo();

  CategoryModel _selectedCategory = CategoryModel(id: '', name: 'All Category');

  CategoryModel get selectedCategory => _selectedCategory;
  set selectedCategory(CategoryModel selectedCategory) {
    _selectedCategory = selectedCategory;
    notifyListeners();
  }

  Stream<List<TransactionModel>> getAllTransactionStream() {
    if (selectedCategory.id.isEmpty) {
      return _repo.getAllTransactionStream();
    } else {
      return _repo.getTransactionByCategory(catId: selectedCategory.id);
    }
  }
}
