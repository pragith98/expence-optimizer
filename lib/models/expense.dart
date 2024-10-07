
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'expense.g.dart';

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

@HiveType(typeId: 1)
class ExpenseModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final Category category;

  @HiveField(4)
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