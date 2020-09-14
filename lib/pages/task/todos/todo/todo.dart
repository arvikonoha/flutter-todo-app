import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_fluta/models/tasks.dart';

typedef void HandleCheck(String id);

class TodoWidget extends StatelessWidget {
  TodoWidget({this.todo, this.handleCheck}) : super(key: ObjectKey(todo));
  final Todo todo;
  final HandleCheck handleCheck;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
      value: todo.isDone,
      onChanged: (value) {
        handleCheck(todo.id);
      },
      title: Text(todo.description,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Colors.red[900],
                  decorationThickness: 5.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold))),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
