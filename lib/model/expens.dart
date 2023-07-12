import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, liesure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.liesure: Icons.movie,
  Category.work: Icons.work,
};

class Expens {
  Expens({
    required this.title,
    required this.date,
    required this.amount,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpensBucket {
  const ExpensBucket({
    required this.category,
    required this.expense,
  });

  ExpensBucket.forCategory(List<Expens> allExpense, this.category)
      : expense =
            allExpense.where((expens) => expens.category == category).toList();

  final Category category;
  final List<Expens> expense;

  double get totalExpenses {
    double sum = 0;
    for (final expens in expense) {
      sum = sum + expens.amount;
    }

    return sum;
  }
}
