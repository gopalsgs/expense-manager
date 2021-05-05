import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/model/category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stream_transform/stream_transform.dart';

class CategoriesRepo {
  final _generalCategoryCollectionRef =
      FirebaseFirestore.instance.collection('generalCategories');

  final _customCategoryCollectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('categories');

  Stream<List<CategoryModel>> getGeneralCategories() {
    return _generalCategoryCollectionRef.snapshots().map(_parseQuerySnapshot);
  }

  Stream<List<CategoryModel>> getCustomCategories() {
    return _customCategoryCollectionRef.snapshots().map(_parseQuerySnapshot);
  }

  Stream<List<CategoryModel>> getAllCategories() {
    final Stream<List<CategoryModel>> customCategory = getCustomCategories();
    final Stream<List<CategoryModel>> generalCategory = getGeneralCategories();

    return generalCategory.combineLatest(customCategory, (a, b) {
      for (var item in b.toList()) {
        if (!a.contains(item)) {
          a.add(item);
        }
      }
      return a;
    });
  }

  Future addNewCategory(String categoryName) {
    return _customCategoryCollectionRef.doc().set({'name': categoryName});
  }

  List<CategoryModel> _parseQuerySnapshot(QuerySnapshot snapshot) =>
      snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
}
