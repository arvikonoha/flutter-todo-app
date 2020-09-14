import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_fluta/ui/inpwsub/inpwsub.dart';

typedef void TitleChangedCallback(String title);
typedef void TitleDeleteCallback();

class TaskTitle extends StatelessWidget {
  TaskTitle({this.title, this.onTitleChanged, this.onTaskDelete});
  final String title;
  final TitleChangedCallback onTitleChanged;
  final TitleDeleteCallback onTaskDelete;

  @override
  Widget build(BuildContext context) {
    if (title == null)
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 42.0, vertical: 16.0),
          child: Column(children: [
            CustInputWithForm(
              buttonColor: Colors.black,
              isCircular: true,
              placeholder: "Enter the title",
              initFieldValue: null,
              onFieldSubmit: onTitleChanged,
            ),
            Text(
                'Please enter a task title. The task wont be saved without a title.',
                style: GoogleFonts.alata(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w200, color: Colors.black45)))
          ]));
    else
      return Container(
          padding:
              EdgeInsets.only(bottom: 16.0, top: 16.0, left: 96.0, right: 42.0),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0)),
              ),
              IconButton(
                icon: Icon(Icons.done_all),
                color: Colors.grey,
                tooltip: "Task finished",
                onPressed: () {
                  onTaskDelete();
                },
              )
            ],
          ));
  }
}
