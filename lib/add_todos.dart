import 'package:flutter/material.dart';

class AddTodoDialog extends StatelessWidget {
  // add a value from textField to main.dart 
  final todoController = TextEditingController();

  @override 
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add new task"),
      content: TextField(
        controller: todoController,
        decoration: InputDecoration.collapsed(
          hintText: "What do you want to do?",
          border: UnderlineInputBorder(),
        ),
      ), //TextField
      actions: [
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: Text("Cancel"), 
          onPressed: () {
            Navigator.of(context).pop();
          },
        ), // FlatButton
        RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text("Add"), 
          onPressed: () {
            Navigator.of(context).pop(todoController.text);
          },
        ), // RaisedButton 
      ]
    ); // AlertDialog
  }

}