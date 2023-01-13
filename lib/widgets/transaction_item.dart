import 'package:intl/intl.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionITem extends StatefulWidget {
  const TransactionITem(
    Key key, {
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);
  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionITem> createState() => _TransactionITemState();
}

class _TransactionITemState extends State<TransactionITem> {
  late Color _bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple
    ];
    _bgColor = availableColors[
        Random().nextInt(4)]; //here 4 is the max and it is excluded
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: widget.transaction.color
            // (widget.transaction.date.weekday == DateTime.saturday ||
            //         widget.transaction.date.weekday == DateTime.friday)
            //     ? Colors.black
            //     : Theme.of(context).primaryColor,
            ,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle:
              Text(DateFormat.yMMMMEEEEd().format(widget.transaction.date)),
          trailing: MediaQuery.of(context).size.width > 500
              ? TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).errorColor),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  onPressed: () => widget.deleteTx(
                    widget.transaction.id,
                  ),
                )
              : IconButton(
                  onPressed: () => widget.deleteTx(widget.transaction.id),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                ),
        ),
      ),
    );
  }
}
