import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tak/Dict/Dictionary.dart';

void dialog(BuildContext context, String phrase, [String title]){
  showDialog(
    context: context, 
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(phrase),
        actions: <Widget>[
          FlatButton(
            child: Text(phrases['closeButton']),//'FECHAR'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  );
}