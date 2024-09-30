import 'package:expense_optimizer/models/expense.dart';
import 'package:expense_optimizer/widgets/expense_tile.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseModel> expenseList;
  final void Function(ExpenseModel expense) onDeleteExpense;

  const ExpenseList({
    super.key,
    required this.expenseList,
    required this.onDeleteExpense
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenseList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Dismissible(
              key: Key(expenseList[index].id),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) => {
                onDeleteExpense(expenseList[index])
              },
              child: ExpenseTile(
                expense: expenseList[index]
              )
            ),
          );
        },
      ),
    );
  }
}