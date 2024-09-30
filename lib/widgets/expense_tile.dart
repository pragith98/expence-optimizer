import 'package:expense_optimizer/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseTile({
    super.key,
    required this.expense
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(expense.amount.toStringAsFixed(2)),
                const Spacer(),
                Row(
                  children: [
                    Icon(expense.getCategoryIcon),
                    const SizedBox(width: 8),
                    Text(expense.getFormattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}