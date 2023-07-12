import 'package:expense/model/expens.dart';
import 'package:expense/widget/Chart/chart.dart';
import 'package:expense/widget/expense_list/expenses_list.dart';
import 'package:expense/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expens> _registeredExpense = [
    Expens(
        title: 'Flutter course',
        date: DateTime.now(),
        amount: 19.99,
        category: Category.work),
    Expens(
        title: 'cinema',
        date: DateTime.now(),
        amount: 15.69,
        category: Category.liesure)
  ];

  void _openAddExensesOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpens: _addExpense),
    );
  }

  void _addExpense(Expens expens) {
    setState(() {
      _registeredExpense.add(expens);
    });
  }

  void _removeExpense(Expens expens) {
    final expenseIndex = _registeredExpense.indexOf(expens);
    setState(() {
      _registeredExpense.remove(expens);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(expenseIndex, expens);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No Expenses found.Start adding some'),
    );

    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expense: _registeredExpense,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Expense-Tracker',
        ),
        actions: [
          IconButton(
            onPressed: _openAddExensesOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width <600 ?Column(
        children: [
          Chart(expenses: _registeredExpense),
          Expanded(
            child: mainContent,
          )
        ],
      ):Row(
        children: [
          Expanded(child: 
           Chart(expenses: _registeredExpense),
          ),
          Expanded(
            child: mainContent,
          )
        ],
      )
    );
  }
}
