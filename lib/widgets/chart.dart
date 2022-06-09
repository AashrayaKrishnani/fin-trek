// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:finance_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  // Only Transactions a week older are assumed to be passed here.
  final List<Transaction> recentTransacs;

  Chart({required this.recentTransacs});

  double amountForDay(DateTime dateTime) {
    double amount = 0;

    for (Transaction t in recentTransacs) {
      if (t.dateTime.weekday == dateTime.weekday) {
        amount += t.amt;
      }
    }

    return amount;
  }

  String weekdayFromInt(int num) {
    String weekday = '';

    switch (num) {
      case 1:
        weekday = 'Mon';
        break;
      case 2:
        weekday = 'Tues';
        break;
      case 3:
        weekday = 'Wed';
        break;
      case 4:
        weekday = 'Thur';
        break;
      case 5:
        weekday = 'Fri';
        break;
      case 6:
        weekday = 'Sat';
        break;
      case 7:
        weekday = 'Sun';
        break;
    }

    return weekday;
  }

  List<Map<String, Object>> get weeklyChartData {
    double totalAmt = 0;

    List<Map<String, Object>> weeklyChartData = List.generate(7, (index) {
      final dateTime = DateTime.now().subtract(Duration(days: index));
      final amount = amountForDay(dateTime);
      totalAmt += amount;
      return {
        'day': weekdayFromInt(dateTime.weekday),
        'amount': amount,
        'index': dateTime.weekday
      };
    });

    for (Map<String, Object> map in weeklyChartData) {
      // Adding percentTotal in each entry
      map.addAll({'factor': double.parse(map['amount'].toString()) / totalAmt});
    }

    weeklyChartData
        .sort((e1, e2) => (e1['index'] as int).compareTo(e2['index'] as int));

    return weeklyChartData;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weeklyChartData
            .map(
              (data) => ChartBar(
                day: data['day'].toString(),
                amt: data['amount'] as double,
                factor: data['factor'] as double,
                isLight: weeklyChartData.indexOf(data) % 2 == 0,
              ),
            )
            .toList(),
      ),
    );
  }
}
