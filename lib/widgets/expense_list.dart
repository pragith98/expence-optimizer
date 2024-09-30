import 'package:expense_optimizer/models/expense.dart';
import 'package:expense_optimizer/widgets/expense_tile.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseModel> expenseList;

  const ExpenseList({
    super.key,
    required this.expenseList
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenseList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ExpenseTile(expense: expenseList[index]),
          );
        },
      ),
    );
  }
}