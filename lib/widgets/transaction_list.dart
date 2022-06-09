import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTransac;

  TransactionList({required this.transactions, required this.deleteTransac});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  // With ListTile

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.transactions.length,
      itemBuilder: (context, index) {
        Transaction t = widget.transactions[index];

        return TransactionItem(
          key: ValueKey(t.id),
          // Can Also Use UniqueKey() but that'll change each time EVEN A SMALL CHANGE IS MADE to ANYTHING, so it'll be Hectic XD
          t: t,
          deleteTransac: widget.deleteTransac,
        );
      },
    );
  }
}
