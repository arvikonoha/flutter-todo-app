import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_fluta/pages/task/task.dart';

class Addtask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 48.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TaskPage(index: -1, isNew: true)));
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                      color: Colors.black12,
                      style: BorderStyle.solid,
                      width: 2.0,
                    )),
                child: Icon(
                  Icons.add,
                  color: Colors.black38,
                ),
              ),
            ),
            Text('Add task',
                style: GoogleFonts.alata(
                    textStyle: TextStyle(
                        color: Colors.black38, fontWeight: FontWeight.bold)))
          ],
        ));
  }
}
