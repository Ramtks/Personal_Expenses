import 'package:flutter/material.dart';
import './chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTranscations, {super.key});
  final List<Transaction> recentTranscations;
  List<Map<String, dynamic>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0; //declaring a double
      for (var i = 0; i < recentTranscations.length; i++) {
        if (recentTranscations[i].date.day == weekDay.day &&
            recentTranscations[i].date.month == weekDay.month &&
            recentTranscations[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTranscations[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              //expanded is the same as flexible with a fit: flextfit.tight built in
              fit: FlexFit.tight,
              child: ChartBar(
                  label: data['day'],
                  spending: data['amount'],
                  perecentage: totalSpending == 0.0
                      ? 0.0
                      : data['amount'] / totalSpending),
            );
            // Text(
            //     '${data['day']}:${data['amount']}'); //or Text(data['day']+ ':' +data['amount'].toString());
          }).toList(),
        ),
      ),
    );
  }
}
