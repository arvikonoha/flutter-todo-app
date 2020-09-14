import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_fluta/main.dart';

import 'package:todo_fluta/pages/home/addtask/addtask.dart';
import 'package:todo_fluta/pages/home/appbar/appbar.dart';
import 'package:todo_fluta/pages/home/tasks/todos/todos.dart';
import 'package:todo_fluta/pages/home/title/hometitle.dart';

class TaskHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Material(
      child: Column(
        children: <Widget>[
          CustAppbar(),
          HomeTitle(),
          Addtask(),
          Consumer(builder: (context, watch, _) {
            final state = watch(taskProvider.state);
            final tasks = state;

            return tasks.length > 0
                ? TodoHome(tasks: tasks)
                : Container(
                    alignment: Alignment.topCenter,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 40),
                    child: Text("No tasks added yet",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black38,
                                fontStyle: FontStyle.italic))),
                  );
          })
        ],
      ),
    );
  }
}
