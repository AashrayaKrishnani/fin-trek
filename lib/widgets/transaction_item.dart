import 'package:flutter/material.dart';

import '../helpers.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.t,
    required this.deleteTransac,
  }) : super(key: key);

  final Transaction t;
  final Function deleteTransac;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Widget get _deleteButton {
    bool enoughWidth = MediaQuery.of(context).size.width > 400;

    ThemeData theme = Theme.of(context);

    if (enoughWidth) {
      return TextButton.icon(
          onPressed: () => widget.deleteTransac(widget.t),
          icon: Icon(
            Icons.delete,
            color: theme.errorColor,
          ),
          label: Text(
            'Delete',
            style: theme.textTheme.headline6?.copyWith(color: theme.errorColor),
          ));
    }
    // Else
    return IconButton(
      // Great IconButton Widget
      icon: Icon(
        Icons.delete,
        color: theme.errorColor,
      ),
      onPressed: () => widget.deleteTransac(widget.t),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    Color color = widget.key.hashCode % 2 == 0
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).primaryColorDark;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          // Super Useful ListTile Widget
          leading: CircleAvatar(
            radius: 25,
            child: FittedBox(
              child: Text(
                formatAmt(widget.t.amt),
                style: textStyle?.copyWith(color: Colors.white, fontSize: 15),
              ),
            ),
            backgroundColor: color,
          ),
          title: Text(
            widget.t.title,
            style: textStyle,
          ),
          subtitle: Text(
            formatDateTime(widget.t.dateTime),
          ),
          trailing: _deleteButton,
        ),
      ),
    );
  }
}
