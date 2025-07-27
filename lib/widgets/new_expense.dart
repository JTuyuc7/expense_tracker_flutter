
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart' as expense_models;
// import 'package:expense_tracker/models/expense.dart';

final DateFormat dateFormatter = DateFormat.yMd('en_US');

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(expense_models.Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  expense_models.Category _selectedCategory = expense_models.Category.leisure;
  DateTime? _selectedDate;

  Future<void> _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);
    // final DateTime lastDate = DateTime(now.year + 1, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }

    // showDatePicker(
    //   context: context,
    //   initialDate: now,
    //   firstDate: firstDate,
    //   lastDate: now,
    // ).then((pickedDate) {
    //   if (pickedDate == null) {
    //     return;
    //   }
    //   // Logic to handle the selected date
    //   print('Selected date: ${pickedDate.toLocal()}');
    // });
  }

  void _submitExpenseData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);
    final isInvalidAmount = enteredAmount == null ||  enteredAmount <= 0;
    final selectedDate = _selectedDate;

    if (enteredTitle.trim().isEmpty || isInvalidAmount || selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          content: Text('Please enter valid data.', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      expense_models.Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: selectedDate,
        category: _selectedCategory,
      ),
    );
    Navigator.of(context).pop();
    _titleController.clear();
    _amountController.clear();
    setState(() {
      _selectedCategory = expense_models.Category.leisure;
      _selectedDate = null;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            // onChanged: _onTitleChanged,
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            maxLength: 60,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefix: Text("\$"),
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                          ? 'No Date Chosen'
                          : dateFormatter.format(_selectedDate!),
                    ),

                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.date_range),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // const SizedBox(width: 16),
              DropdownButton(
                value: _selectedCategory,
                focusColor: Theme.of(context).colorScheme.primary,
                items: expense_models.Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    // style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    child: Text(category.name.toUpperCase(), style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  );
                }).toList(),
                onChanged: (value) {
                  
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                  // setState(() {
                  //   _selectedCategory = expense_models.Category.values.firstWhere(
                  //     (category) => category == value,
                  //     orElse: () => expense_models.Category.leisure,
                  //   );
                  // });
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text('Add Expense'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     // Logic to add a new expense
              //     print('Expense Added: ${_titleController.text}  ');
              //   },
              //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              //   child: Text('Cancel'),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
