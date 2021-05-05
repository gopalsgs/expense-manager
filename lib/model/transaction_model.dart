import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TransactionModel {
  String remark;
  int price;
  String id;
  String categoryId;
  DateTime time;

  TransactionModel({
    @required this.remark,
    @required this.price,
    this.id,
    @required this.categoryId,
    DateTime time,
  }) {
    this.time = time ?? DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'remark': remark,
      'price': price,
      'categoryId': categoryId,
      'time': time,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      remark: map['remark'],
      price: map['price'],
      categoryId: map['categoryId'],
      time: map['time'] != null ? (map['time'] as Timestamp).toDate() : null,
    );
  }

  factory TransactionModel.fromSnapshot(DocumentSnapshot snapshot) =>
      TransactionModel.fromMap(snapshot.data())..id = snapshot.id;

  String toJson() => json.encode(toMap());
  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));
}
