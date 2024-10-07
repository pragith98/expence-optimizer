import 'package:expense_optimizer/models/expense.dart';
import 'package:flutter/material.dart';

class AddNewExpense extends StatefulWidget {
  final void Function(ExpenseModel expense) onAddExpense;
  const AddNewExpense({
    super.key, 
    required this.onAddExpense
  });

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController(text: '0');
  Category _selectedCategory = Category.food;

  // Date variables
  late DateTime _initialDate;
  late DateTime _firstDate;
  late DateTime _lastDate;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initialDate = DateTime.now();
    _firstDate = DateTime(
      _initialDate.year - 1,
      _initialDate.month,
      _initialDate.day
    );
    _lastDate = DateTime(
      _initialDate.year + 1,
      _initialDate.month,
      _initialDate.day
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Title field
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text("Title"),
              helperText: 'Add new expense title'
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
      
          Row(
            children: [
              // Amount field
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    helperText: 'Add amount'
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
      
              // Date field
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(formattedDate.format(_selectedDate)),
                    IconButton(
                      onPressed: _openDateModel, 
                      icon: const Icon(Icons.calendar_month))
                  ],
                )
              )
            ],
          ),
      
          Row(
            children: [
              // Category select
              DropdownButton(
                value: _selectedCategory,
                items: _getCategoryList(), 
                onChanged: (value) { 
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              ),
      
              // Action buttons
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () { 
                        Navigator.pop(context);
                      }, 
                      child: const Text("Cancel")
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: _handleFormSubmit, 
                      style:  const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.blueAccent
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      )
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem> _getCategoryList() {
    return Category.values.map(
      (category) => DropdownMenuItem(
        value: category,
        child: Text(category.name),
      ),
    ).toList();
  }

  Future<void> _openDateModel() async {
    try {
      final date = await showDatePicker(
        context: context, 
        initialDate: _initialDate,
        firstDate: _firstDate, 
        lastDate: _lastDate
      );

      setState(() {
        _selectedDate = date!;
      });

    } catch (error) {
      // print(error.toString());
    }
  }

  void _handleFormSubmit() {
    final amount = double.parse(_amountController.text.trim());
    final title = _titleController.text.trim();
    final category = _selectedCategory;
    final date = _selectedDate;

    if(amount <= 0) return;

    if(title == '') return;

    ExpenseModel expense = ExpenseModel(
      title: title, 
      amount: amount, 
      category: category, 
      date: date
    );

    widget.onAddExpense(expense);
    Navigator.pop(context);
  }
}