import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  const TransactionList(
    this.transactions,
    this.deleteTx, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                const Padding(padding: EdgeInsets.all(5)),
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionITem(
                  ValueKey(transactions[index].id)
                  // UniqueKey() this is useless here because everytime the setstate is called it gives a new key to the items with every rebuild because every rebuild rebuild all list items
                  ,
                  transaction: transactions[index],
                  deleteTx: deleteTx);
              // Card(
              //   child: Row(children: [
              //     Container(
              //       margin: const EdgeInsets.symmetric(
              //           vertical: 15, horizontal: 10),
              //       decoration: BoxDecoration(
              //           border: Border.all(
              //         color: Theme.of(context).primaryColor,
              //         width: 2,
              //       )),
              //       padding: const EdgeInsets.all(10),
              //       child: Text(
              //         '\$${transactions[index].amount.toStringAsFixed(2)}',
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             color: Theme.of(context).primaryColor,
              //             fontFamily: Theme.of(context)
              //                 .primaryTextTheme
              //                 .bodyLarge!
              //                 .fontFamily), //this give us the default theme font family
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           transactions[index].title,
              //           style: Theme.of(context).textTheme.headline6,
              //         ),
              //         Text(
              //             DateFormat.yMMMMEEEEd()
              //                 .format(transactions[index].date),
              //             style: const TextStyle(
              //                 fontSize: 12, color: Colors.black45))
              //       ],
              //     )
              //   ]),
              // );
            },
            itemCount: transactions.length,
          );
  }
}
