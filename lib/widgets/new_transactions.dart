import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/adaptiveButton.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;
  const NewTransactions(this.addTx, {super.key});

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();
  DateTime? _dateSelected;
  final amountController = TextEditingController();
  @override //the override means that the extends state here already running this code which is initstate here internally so this is to show we are implemnting it intentially
  void initState() {
    //this is a state method that runs one time at the first building of the widget but if the widget get rebuild again it wont run because it is in the class not the build
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransactions oldWidget) {
    //here we can access the old widget if the widget get updated for any reason and it is used for many reasons like comparing etc..
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // the state can be removed at sometime which we can see here like if we close the modal sheet the dispose will run
    // TODO: implement dispose
    super.dispose();
  }

  void submitData() {
    final enteredTitle = titleController.text;
    if (num.tryParse(amountController.text) == null) {
      return;
    }
    if (amountController.text == '') {
      return;
    }
    final enteredAmount = double.parse(amountController.text);
    if (enteredAmount < 0 || enteredTitle.isEmpty || _dateSelected == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _dateSelected);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dateSelected = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) =>
                  submitData(), //here we need a function that take the argument of onSumbitted which is a String but we actually dont use it

              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'amount'),
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),

              onSubmitted: (_) => submitData(),
              // onChanged: (value) {
              //   amountInput = value;
              // },
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Text(
                    _dateSelected == null
                        ? 'No date is chosen!'
                        : 'Picked date: ${DateFormat.yMd().format(_dateSelected!)}',
                    style: TextStyle(
                        fontFamily: Theme.of(context)
                            .primaryTextTheme
                            .headline6
                            ?.fontFamily,
                        fontSize: 14 * curScaleFactor,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  AdaptiveFlatButton(
                    presentDatePicker: _presentDatePicker,
                    txt: 'Pick a date',
                  )
                ],
              ),
            ),
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        // side: BorderSide(
                        //     width: 1, color: Theme.of(context).primaryColor),
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10)),
                    onPressed: submitData,
                    child: const Text(
                      'Add transactions',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
