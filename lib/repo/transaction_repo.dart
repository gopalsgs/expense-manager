import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionRepo {
  final _transactionCollectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('transactions');

  Stream<List<TransactionModel>> getAllTransactionStream() {
    return _transactionCollectionRef
        .orderBy('time', descending: true)
        .snapshots()
        .handleError((e) => print('Error = $e'))
        .map(
          (event) => event.docs
              .map(
                (e) => TransactionModel.fromSnapshot(e),
              )
              .toList(),
        );
  }

  Future addNewTransaction(TransactionModel transaction) {
    return _transactionCollectionRef.doc().set(transaction.toMap());
  }

  Future updateTransaction(TransactionModel transaction) {
    return _transactionCollectionRef
        .doc(transaction.id)
        .update(transaction.toMap());
  }

  Stream<List<TransactionModel>> getTransactionByCategory({String catId}) {
    return _transactionCollectionRef
        .orderBy('time', descending: true)
        .snapshots()
        .handleError((e) => print('Error = $e'))
        .map(
          (event) => event.docs
              .map(
                (e) => TransactionModel.fromSnapshot(e),
              )
              .toList(),
        );
  }
}
