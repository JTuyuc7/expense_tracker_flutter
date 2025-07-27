import 'dart:math';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense) onRemoveExpense;
  final void Function(Expense) onUndoRemoveExpense;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
    required this.onUndoRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        // return ListTile(
        //   title: Text(expense.title),
        //   subtitle: Text(expense.category.name),
        //   trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
        // );
        return Dismissible(
          key: ValueKey(expense.id),
          background: Container(color: const Color.fromARGB(255, 218, 73, 63)),
          onDismissed: (direction) {
            onRemoveExpense(expense);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                content: Text('${expense.title} dismissed'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Logic to undo the dismissal
                    // This could involve re-adding the expense to the list
                    // For simplicity, we won't implement this here
                    onUndoRemoveExpense(expense);
                  },
                ),
              ),
            );
          },
          child: ExpenseItem(expense: expense),
        );
      },
    );
  }
}
