import 'package:app_eat/widgets/colors.dart';
import 'package:app_eat/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  const ShowAlertDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        style: TextStyle(color: green100, fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            button_accept,
            style: TextStyle(
              color: green100,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}