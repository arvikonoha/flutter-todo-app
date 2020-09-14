import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_fluta/models/tasks.dart';
import 'package:todo_fluta/pages/task/task.dart';

List<Color> taskColors = [Colors.red[400], Colors.blue[400], Colors.teal[400]];

class TodoHome extends StatelessWidget {
  TodoHome({this.tasks});
  final List<Task> tasks;
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      margin: EdgeInsets.only(left: 36.0, top: 36.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskPage(
                            isNew: false,
                            index: index,
                          )));
            },
            child: Container(
              width: 196.0,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  color: taskColors[index % 3],
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        top: 36.0, left: 36.0, right: 8.0, bottom: 16.0),
                    child: Text(
                      tasks[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white)),
                    ),
                  ),
                  Divider(
                    height: 10,
                    indent: 36.0,
                    thickness: 1,
                    color: Colors.white54,
                  ),
                  Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    alignment: Alignment.topCenter,
                    child: tasks[index].todos.length > 0
                        ? ListView(
                            padding: EdgeInsets.all(0),
                            children: [
                              ...tasks[index]
                                  .todos
                                  .sublist(
                                      0,
                                      tasks[index].todos.length > 4
                                          ? 4
                                          : tasks[index].todos.length)
                                  .map((todo) => Container(
                                      margin: EdgeInsets.only(
                                          left: 36.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                          right: 16.0),
                                      child: Text(todo.description,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  decoration: todo.isDone
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                                  decorationColor: Colors.white,
                                                  decorationThickness: 2.0,
                                                  color: todo.isDone
                                                      ? Colors.white70
                                                      : Colors.white,
                                                  fontWeight:
                                                      FontWeight.w600)))))
                                  .toList()
                            ],
                          )
                        : Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 40),
                            child: Text("No todos added yet",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic))),
                          ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
