// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:finance_tracker/widgets/delete_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'widgets/no_transactions_yet.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MaterialColor? primaryColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
            padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          ),
        ),
        errorColor: Colors.red,
        primarySwatch: primaryColor,
        fontFamily: 'Quicksand-Bold',
        textTheme: TextTheme(
          headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];
  late AppBar appBar = AppBar();
  bool _showChart = false;

  @override
  void initState() {
    print(
        '_MyHomePageState: Intiating ListenerBinding to listen for AppStateChanges');
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('_MyHomePageState: State = ' + state.toString());
  }

  @override
  void dispose() {
    print('_MyHomePageState: Disposing the Listener');
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  void _addTransaction(
      {required String title, required double amt, required selectedDateTime}) {
    final Transaction tx = Transaction(
        title: title,
        id: Object.hash(title, amt, selectedDateTime).toString(),
        amt: amt,
        dateTime: selectedDateTime);

    setState(() {
      _transactions.add(tx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((t) => t.id == id);
    });
  }

  void _showDeleteTransaction(Transaction t) {
    showModalBottomSheet(
      context: context,
      builder: (_) => DeleteTransaction(
        deleteTransaction: _deleteTransaction,
        transaction: t,
      ),
      isDismissible: true,
    );
  }

  void _showAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => NewTransaction(addTransaction: _addTransaction),
    );
  }

  List<Transaction> get _recentTransacs {
    DateTime sevenDaysBack = DateTime.now().subtract(Duration(days: 7));

    return _transactions
        .where((t) => t.dateTime.isAfter(sevenDaysBack))
        .toList();
    // list.where() : Checks each element for specified condition and returns An Iterable containing all Elements that passed.
  }

  Widget get _noTransactionsYet {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: NoTransactionsYet(),
    );
  }

  Widget get _mainScrollView {
    double availHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    bool isSmallLandscape = isLandscape && availHeight < 350;

    return SingleChildScrollView // This Wrap was a LifeSaver :D
        (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isSmallLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
                Switch.adaptive(
                  activeColor: Theme.of(context).primaryColor,
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                )
              ],
            ),
          if (!isSmallLandscape || _showChart)
            SizedBox(
              height: isSmallLandscape
                  ? availHeight * 0.8
                  : availHeight * 0.3 > 200
                      ? availHeight * 0.28
                      : availHeight * 0.5,
              child: Chart(recentTransacs: _recentTransacs),
            ), // Chart

          SizedBox(
            height: isSmallLandscape
                ? availHeight * 0.8
                : availHeight * 0.3 > 200
                    ? availHeight * 0.72
                    : availHeight * 0.5,
            child: TransactionList(
                // Transactionlist
                transactions: _transactions,
                deleteTransac: _showDeleteTransaction),
          ),
        ],
      ),
    );
  }

  Widget get _appBar {
    return AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
            onPressed: () => _showAddTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
  }

  Widget get _iosAppBar {
    return CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: GestureDetector(
          onTap: () => _showAddTransaction(context),
          child: Icon(CupertinoIcons.add_circled)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Platform.isIOS ? _iosAppBar : _appBar;

    final pageBody = SafeArea(
        child: _transactions.isEmpty ? _noTransactionsYet : _mainScrollView);

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar as PreferredSizeWidget,
            body: pageBody,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () => _showAddTransaction(context),
                child: Icon(Icons.add),
              ),
            ),
          );
  }
}
