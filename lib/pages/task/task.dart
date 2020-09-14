import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_fluta/main.dart';
import 'package:todo_fluta/models/tasks.dart';
import 'package:todo_fluta/pages/home/appbar/appbar.dart';
import 'package:todo_fluta/pages/task/taskseperator/taskseperator.dart';
import 'package:todo_fluta/pages/task/tasktitle/tasktitle.dart';
import 'package:todo_fluta/pages/task/todos/todo/todo.dart';
import 'package:todo_fluta/ui/inpwsub/inpwsub.dart';
import 'package:uuid/uuid.dart';

class TaskPageState extends State<TaskPage> {
  TaskPageState({this.isNew, this.index}) {
    if (isNew) task = Task(title: null, id: Uuid().v4(), todos: []);
  }
  Task task;
  bool isNew;
  int index;

  void addTask() {
    context.read(taskProvider).addTask(task);
    Navigator.pop(context);
  }

  void deleteTask() {
    if (!isNew) context.read(taskProvider).deleteTask(task.id);
    Navigator.pop(context);
  }

  void addTitle(String title) {
    setState(() {
      task.title = title;
    });
  }

  void addTodo(String todo) {
    if (!isNew)
      context.read(taskProvider).addTodo(
          Todo(description: todo, id: Uuid().v4(), isDone: false), task.id);
    else
      setState(() {
        task.todos = [
          ...task.todos,
          Todo(description: todo, id: Uuid().v4(), isDone: false)
        ];
      });
  }

  void handleCheck(String changedId) {
    Todo newTodo = task.getTodo(changedId);
    newTodo.isDone = !newTodo.isDone;
    if (!isNew) {
      context.read(taskProvider).updateTodo(index, newTodo);
    } else {
      setState(() {
        task.todos = [
          for (final todo in task.todos)
            if (todo.id == changedId) newTodo else todo
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final state = watch(taskProvider.state);
      if (!isNew) this.task = state[index];

      return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                CustAppbar(),
                Container(
                  alignment: Alignment.center,
                  child: TaskTitle(
                      title: task?.title,
                      onTitleChanged: addTitle,
                      onTaskDelete: deleteTask),
                ),
                TaskSeparator(),
                Expanded(
                  child: task.todos.length > 0
                      ? SizedBox(
                          height: 36.0,
                          child: ListView.builder(
                              padding: EdgeInsets.only(
                                  left: 4.0,
                                  right: 4.0,
                                  top: 4.0,
                                  bottom: 64.0),
                              itemCount: task.todos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TodoWidget(
                                    todo: task.todos[index],
                                    handleCheck: handleCheck);
                              }),
                        )
                      : Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 40),
                          child: Text("No todos added yet",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black38,
                                      fontStyle: FontStyle.italic))),
                        ),
                )
              ],
            ),
            bottomSheet: task?.title != null
                ? SizedBox(
                    height: 72.0,
                    child: Column(
                      children: isNew
                          ? [
                              CustInputWithForm(
                                initFieldValue: "",
                                placeholder: "Enter a new todo",
                                isCircular: false,
                                buttonColor: Colors.red,
                                onFieldSubmit: addTodo,
                              ),
                              GestureDetector(
                                onTap: addTask,
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration:
                                      BoxDecoration(color: Colors.green[300]),
                                  child: Text(
                                    "Save changes",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                              )
                            ]
                          : [
                              CustInputWithForm(
                                initFieldValue: "",
                                placeholder: "Enter a new todo",
                                isCircular: false,
                                buttonColor: Colors.red,
                                onFieldSubmit: addTodo,
                              ),
                            ],
                    ),
                  )
                : null),
      );
    });
  }
}

class TaskPage extends StatefulWidget {
  TaskPage({this.index, this.isNew});
  final int index;
  final bool isNew;

  @override
  TaskPageState createState() => TaskPageState(index: index, isNew: isNew);
}
