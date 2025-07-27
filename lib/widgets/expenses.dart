import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Groceries',
      amount: 50.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Bus Ticket',
      amount: 2.5,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Movie Night',
      amount: 15.0,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Office Supplies',
      amount: 30.0,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Gift',
      amount: 20.0,
      date: DateTime.now(),
      category: Category.other,
    ),
  ];

  _openAddExpenseModal() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Container(
          height: double.infinity,
          child: Center(child: NewExpense(onAddExpense: _addExpense)),
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _undoRemoveExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context)
        .size
        .width; // This line is used to adjust the bottom padding when the keyboard is open
    final height = MediaQuery.of(context)
        .size
        .height; // This line is used to adjust the bottom padding when the keyboard is open

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Logic to add a new expense
              _openAddExpenseModal();
            },
          ),
        ],
      ),
      body: width > 600
          ? Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: Column(
                    children: [
                      Text(
                        _registeredExpenses.isEmpty
                            ? 'No expenses added yet!'
                            : 'You have ${_registeredExpenses.length} expenses.',
                      ),
                      Expanded(
                        child: ExpensesList(
                          expenses: _registeredExpenses,
                          onRemoveExpense: _removeExpense,
                          onUndoRemoveExpense: _undoRemoveExpense,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Column(
              children: [
                Chart(expenses: _registeredExpenses),
                // Expanded(
                //   child: Text(
                //     _registeredExpenses.isEmpty
                //         ? 'No expenses added yet!'
                //         : 'You have ${_registeredExpenses.length} expenses.',
                //   ),
                // ),
                Text(
                  'You have ${_registeredExpenses.length} expenses.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ExpensesList(
                    expenses: _registeredExpenses,
                    onRemoveExpense: _removeExpense,
                    onUndoRemoveExpense: _undoRemoveExpense,
                  ),
                ),
              ],
            ),
    );
  }
}
