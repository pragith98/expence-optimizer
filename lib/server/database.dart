import 'package:expense_optimizer/models/expense.dart';
import 'package:hive/hive.dart';

class Database {
  // Create db instance;
  final _myBox = Hive.box('expensesDb');

  List<ExpenseModel> expenseList = [];

  void createInitDatabase() {
    expenseList = [
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
  }

  void loadData() {
    final dynamic data = _myBox.get('EXPENSE_DATA');

    // Validation
    if(data != null && data is List<dynamic>) {
      expenseList = data.cast<ExpenseModel>().toList();
    }
  }

  Future<void> updateData() async {
    await _myBox.put('EXPENSE_DATA', expenseList);
  }
}