import 'package:expense_optimizer/models/expense.dart';
import 'package:expense_optimizer/server/database.dart';
import 'package:expense_optimizer/widgets/add_new_expense.dart';
import 'package:expense_optimizer/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final _myBox = Hive.box('expensesDb');
  Database db = Database();

  @override
  void initState() {
    super.initState();
    
    final expenseData = _myBox.get('EXPENSE_DATA');
    
    if(expenseData == null || expenseData.length < 1) {
      db.createInitDatabase();
    } else {
      db.loadData();
    }
  }

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
            expenseList: db.expenseList,
            onDeleteExpense: onDeleteExpense,
          )
        ],
      ),
    );
  }

  void onDeleteExpense(ExpenseModel expense) {
    ExpenseModel toDelete = expense;
    final int indexToDelete = db.expenseList.indexOf(toDelete);

    setState(() {
      db.expenseList.remove(expense);
      db.updateData();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Deleted!'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: () {
            setState(() {
              db.expenseList.insert(indexToDelete, toDelete);
              db.updateData();
            });
          }
        ),
      )
    );
  }

  void onAddExpense(ExpenseModel expense) {
    setState(() {
      db.expenseList.add(expense);
      db.updateData();
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