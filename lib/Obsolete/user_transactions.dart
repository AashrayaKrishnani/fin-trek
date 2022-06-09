// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      title: 'IYC trip',
      id: 't1',
      amt: 20000,
      dateTime: DateTime(2021, 12, 12),
    ),
    Transaction(
      title: 'Udemy Courses',
      id: 't2',
      amt: 1500,
      dateTime: DateTime(2022),
    ),
  ];

  void _addTransaction({required String title, required double amt}) {
    final DateTime dateTime = DateTime.now();

    final Transaction tx = Transaction(
        title: title,
        id: amt.toString() + title + dateTime.toString(),
        amt: amt,
        dateTime: dateTime);

    setState(() {
      _transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          addTransaction: _addTransaction,
        ),
        TransactionList(
          transactions: _transactions,
        ),
      ],
    );
  }
}
