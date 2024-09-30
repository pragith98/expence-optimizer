import 'package:expense_optimizer/models/expense.dart';
import 'package:expense_optimizer/widgets/add_new_expense.dart';
import 'package:expense_optimizer/widgets/expense_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // Expense list
  final List<ExpenseModel> _expenseList = [
    ExpenseModel(title: 'title 1', 
                 amount: 100, 
                 date: DateTime.now(), 
                 category: Category.food),
    ExpenseModel(title: 'title 2', 
                 amount: 300, 
                 date: DateTime.now(), 
                 category: Category.leasure),
    ExpenseModel(title: 'title 3', 
                 amount: 400, 
                 date: DateTime.now(), 
                 category: Category.work),
    ExpenseModel(title: 'title 4', 
                 amount: 800, 
                 date: DateTime.now(), 
                 category: Category.food)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses Optimizer',
          style: TextStyle(color: Colors.white),  
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          Container(
            color: Colors.yellow,
            child: IconButton(
              onPressed: openAddExpensesOverlay, 
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          ExpenseList(
            expenseList: _expenseList,
            onDeleteExpense: onDeleteExpense,
          )
        ],
      ),
    );
  }

  void onDeleteExpense(ExpenseModel expense) {
    ExpenseModel toDelete = expense;
    final int indexToDelete = _expenseList.indexOf(toDelete);

    setState(() {
      _expenseList.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Deleted!'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: () {
            setState(() {
              _expenseList.insert(indexToDelete, toDelete);
            });
          }
        ),
      )
    );
  }

  void onAddExpense(ExpenseModel expense) {
    setState(() {
      _expenseList.add(expense);
    });
  }

  void openAddExpensesOverlay() {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return AddNewExpense(onAddExpense: onAddExpense);
      }
    );
  }
}