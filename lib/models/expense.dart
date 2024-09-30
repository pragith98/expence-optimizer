
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// Format date
final formattedDate = DateFormat.yMd();

enum Category {
  food,
  travel,
  leasure,
  work
}

final categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leasure: Icons.beach_access,
  Category.travel: Icons.travel_explore,
  Category.work: Icons.work
};

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.date
  }) :id = const Uuid().v4();

  String get getFormattedDate {
    return formattedDate.format(date);
  }

  IconData get getCategoryIcon {
    return categoryIcons[category]!;
  }
}