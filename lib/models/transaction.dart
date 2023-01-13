import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Color color;
  Transaction(
      {required this.id,
      required this.amount,
      required this.date,
      required this.title,
      this.color = Colors.red});
}
