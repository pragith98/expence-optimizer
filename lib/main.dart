import 'package:expense_optimizer/models/expense.dart';
import 'package:expense_optimizer/pages/expenses.dart';
import 'package:expense_optimizer/server/categories_adapter.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  await Hive.openBox('expensesDb');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Optimizer',
      home: Expenses(),
    );
  }
}