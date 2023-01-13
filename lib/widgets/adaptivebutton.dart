import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final VoidCallback presentDatePicker;
  final String txt;
  const AdaptiveFlatButton(
      {required this.txt, required this.presentDatePicker, super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: presentDatePicker,
            child: Text(txt),
          )
        : TextButton(
            onPressed: presentDatePicker,
            child: Text(
              txt,
              style: const TextStyle(
                  fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
            ));
  }
}
