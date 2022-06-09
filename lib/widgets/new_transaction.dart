import 'package:finance_tracker/helpers.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({required this.addTransaction}) {
    print("NewTransaction: constructor");
  }

  @override
  State<NewTransaction> createState() {
    print('NewTransaction: createState() ');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amtController = TextEditingController();
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    print('_NewTransactionState: initState() ');
  }

  @override
  void didUpdateState(NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('_NewTransactionState: didUpdateState()');
  }

  @override
  void dispose() {
    super.dispose();
    print('_NewTransactionState: dispose()');
  }

  _NewTransactionState() {
    print("_NewTransactionState: constructor");
  }

  void submitData() {
    // Validating input
    if (titleController.text.isNotEmpty &&
        double.tryParse(amtController.text.trim()) != null &&
        double.parse(amtController.text) > 0) {
      widget.addTransaction(
          title: titleController.text,
          amt: double.tryParse(amtController.text.trim()),
          selectedDateTime: _selected ?? DateTime.now()
          // using the 'if null' operator that is '??'
          // means: _selected if _selected!=null, else DateTime.now();
          );
    }
    Navigator.of(context)
        .pop(); //  Hides the Modal Sheet Once valid Data is enterred and button is pressed! :D
  }

  Widget get dateTimeText {
    String text = 'Didn\'t do it now?';

    if (_selected != null) {
      text = formatDateTime(_selected!);
    }

    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline6
          ?.copyWith(fontWeight: FontWeight.normal, fontSize: 14),
    );
  }

  void _showDateTimePicker() {
    DateTime now = DateTime.now();

    // showDatePicker() returns a Future<DateTime> object that can be used to call then() to receive the value once it's finished executing.

    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year),
      lastDate: now,
    ).then((pickedDate) {
      // Inside showDatePicker().then()
      if (pickedDate != null) {
        showTimePicker(
                context: context, initialTime: TimeOfDay.fromDateTime(now))
            .then((pickedTime) {
          // Inside showTimePicker().then()
          if (pickedTime != null) {
            _selected = pickedDate.add(
                Duration(hours: pickedTime.hour, minutes: pickedTime.minute));
          } else {
            _selected = pickedDate;
          }
        } // showTimePicker().then() closed
                );
      }
    } // showDatePicker().then()
        );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: constraints.maxHeight,
        child: SingleChildScrollView(
          child: Card(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: titleController,
                    autofocus: titleController.text.isNotEmpty ? false : true,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Amount'),
                    controller: amtController,
                    keyboardType: TextInputType
                        .number, // For IOS use TextInputType.numberWithOptions(decimal: true)
                    onSubmitted: (_) =>
                        submitData(), // (_) means we don't realy ccare about the parameter passed to us ;p
                  ),
                  Row(
                    children: [
                      Expanded(child: dateTimeText),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          onPressed: _showDateTimePicker,
                          child: Text(
                            'Choose Date-Time',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: submitData,
                    child: Text(
                      'Add Transaction',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
