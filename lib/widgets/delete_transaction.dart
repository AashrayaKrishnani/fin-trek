import 'package:finance_tracker/helpers.dart';
import 'package:finance_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

class DeleteTransaction extends StatefulWidget {
  final Function deleteTransaction;
  final Transaction transaction;

  DeleteTransaction(
      {required this.deleteTransaction, required this.transaction});

  @override
  State<DeleteTransaction> createState() => _DeleteTransactionState();
}

class _DeleteTransactionState extends State<DeleteTransaction> {
  void confirmDelete() {
    widget.deleteTransaction(widget.transaction.id);
    Navigator.of(context)
        .pop(); //  Hides the Modal Sheet Once valid Data is enterred and button is pressed! :D
  }

  Card get transaction {
    Transaction t = widget.transaction;
    return Card(
      margin: const EdgeInsets.all(15),
      elevation: 5,
      child: ListTile(
        // Super Useful ListTile Widget
        leading: CircleAvatar(
          radius: 25,
          child: FittedBox(
            child: Text(
              formatAmt(t.amt),
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white, fontSize: 15),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(
          t.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          formatDateTime(t.dateTime),
        ),
      ),
    );
  }

  Widget get warningText {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 25, 0, 10),
      child: Text(
        'You sure want to Delete?',
        style: Theme.of(context).textTheme.headline6?.copyWith(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w200,
            ),
      ),
    );
  }

  Widget get options {
    ThemeData theme = Theme.of(context);
    ButtonStyle? elevatedButtonStyle = theme.elevatedButtonTheme.style;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: theme.textTheme.headline6
                    ?.copyWith(color: theme.primaryColor, fontSize: 20),
              ),
              style: elevatedButtonStyle?.copyWith(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize: MaterialStateProperty.all(Size.infinite),
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: theme.primaryColor,
                      width: 2,
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(
              autofocus: true,
              onPressed: confirmDelete,
              child: Text(
                'Delete',
                style: theme.textTheme.headline6
                    ?.copyWith(color: Colors.white, fontSize: 20),
              ),
              style: elevatedButtonStyle?.copyWith(
                backgroundColor: MaterialStateProperty.all(theme.errorColor),
                minimumSize: MaterialStateProperty.all(Size.infinite),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: constraints.maxHeight > 300 ? 300 : constraints.maxHeight,
        child: SingleChildScrollView(
          child: Card(
            child: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  warningText,
                  transaction,
                  options,
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
