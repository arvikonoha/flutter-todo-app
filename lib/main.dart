import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'package:todo_fluta/models/tasks.dart';
import 'package:todo_fluta/pages/home/home.dart';

final taskProvider = StateNotifierProvider((ref) => TaskListModel([]));

Future<void> initializeTasks(BuildContext context) async {
  Future<void> initTaskInner() async {
    await context
        .read(taskProvider)
        .openDB()
        .then((value) => context.read(taskProvider).fetchTasks())
        .then((tasks) {
      context.read(taskProvider).initTasks(tasks);
    });
  }

  return await initTaskInner();
}

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: initializeTasks(context),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return MaterialApp(home: TaskHome());
          else
            return MaterialApp(
                home: Scaffold(
                    body: Center(
              child: Text("Loading..."),
            )));
        });
  }
}
