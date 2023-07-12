import 'package:flutter/material.dart';

import 'package:expense/model/expens.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expens, {super.key});
  final Expens expens;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expens.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('\$ ${expens.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expens.category]),
                      const SizedBox(width: 8),
                      Text(expens.formattedDate),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
