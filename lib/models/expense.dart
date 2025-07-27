import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final DateFormat dateFormatter = DateFormat.yMd('en_US');

enum Category { food, travel, leisure, work, other }

const categoryNames = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.local_play,
  Category.work: Icons.work,
  Category.other: Icons.help_outline,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String getFormattedDate(DateTime date) {
    return dateFormatter.format(date);
  }

  getIconComponent(BuildContext context) {
    switch (category) {
      case Category.food:
        return Icons.fastfood;
      case Category.travel:
        return Icons.airplanemode_active;
      case Category.leisure:
        return Icons.local_play;
      case Category.work:
        return Icons.work;
      default:
        return Icons.help;
    }
  }

  // @override
  // String toString() {
  //   return 'Expense(id: $id, title: $title, amount: $amount, date: $date)';
  // }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category).toList();

  ExpenseBucket({required this.category, required this.expenses});

  double get totalExpenses {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }
}
