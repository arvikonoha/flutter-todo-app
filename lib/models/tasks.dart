import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:state_notifier/state_notifier.dart';

class Todo {
  Todo({this.isDone, this.description, this.id});
  final String id;
  final String description;
  bool isDone;
}

class Task {
  Task({this.title, this.id, this.todos});
  String id;
  String title;
  List<Todo> todos = [];

  void addTodo({@required Todo todo}) {
    todos.add(todo);
  }

  void removeTodo({@required Todo todo}) {
    todos.remove(todo);
  }

  Todo getTodo(String id) {
    return todos.firstWhere((element) => element.id == id);
  }
}

class TaskListModel extends StateNotifier<List<Task>> {
  TaskListModel(List<Task> initialTasks)
      : super(initialTasks != null ? initialTasks : []);
  Database db;

  static Future<Database> getDBInstance() async {
    final String path = await getDatabasesPath();
    return await openDatabase(join(path, "task_dbase.db"));
  }

  Future<void> openDB() async {
    final String path = await getDatabasesPath();
    this.db = await openDatabase(join(path, "task_dbase.db"),
        onCreate: (db, version) {
      final String createTaskTable =
          'CREATE TABLE TASK(id VARCHAR(36) PRIMARY KEY,title text NOT NULL)';
      db.execute(createTaskTable).then((value) {
        final String createTodoTable =
            'CREATE TABLE TODO(id VARCHAR(36) PRIMARY KEY,description text NOT NULL,isDone INTEGER NOT NULL,taskID VARCHAR(36),FOREIGN KEY(taskID) REFERENCES TASK(id) ON DELETE CASCADE)';
        db.execute(createTodoTable);
      });
    }, onConfigure: (db) {
      db.execute('PRAGMA foreign_keys = ON');
    }, version: 1);
  }

  static Future<void> updateTodoDB(String taskId, Todo updatedTodo) async {
    await getDBInstance().then((db) => db.rawUpdate(
            "UPDATE TODO SET isDone=?,description=? WHERE taskID=? AND id=?", [
          updatedTodo.isDone ? 1 : 0,
          updatedTodo.description,
          taskId,
          updatedTodo.id
        ]));
  }

  Future<List<Task>> fetchTasks() async {
    final String getTasks = 'SELECT ' +
        'TASK.title as title,' +
        'TASK.id as taskID' +
        ',TODO.id as todoID' +
        ',TODO.description as description' +
        ',TODO.isDone as isDone' +
        ' FROM TASK,TODO WHERE TASK.id=TODO.taskID';
    final tasks = await this.db.rawQuery(getTasks);
    final Set<String> taskSet = Set();

    return tasks
        .map((task) {
          if (!taskSet.contains(task["taskID"])) {
            taskSet.add(task["taskID"]);
            return Task(
                id: task["taskID"],
                title: task["title"],
                todos: tasks
                    .where((todo) => todo["taskID"] == task["taskID"])
                    .map((todo) => Todo(
                        id: todo["todoID"],
                        description: todo["description"],
                        isDone: todo["isDone"] == 1 ? true : false))
                    .toList());
          } else
            return null;
        })
        .where((element) => element != null)
        .toList();
  }

  void initTasks(List<Task> tasks) {
    state = tasks;
  }

  void deleteTask(String taskID) {
    final String deleteTask = "DELETE FROM TASK WHERE id=?";

    db.rawDelete(deleteTask, [taskID]).then((value) {
      state = state.where((element) => element.id != taskID).toList();
    });
  }

  void addTask(Task task) {
    final String insertTaskSQL = "INSERT INTO TASK(id,title) VALUES(?,?)";
    db.rawInsert(insertTaskSQL, [task.id, task.title]).then((value) {
      task.todos.forEach((todo) {
        db.rawInsert(
            "INSERT INTO TODO(id,description,isDone,taskID) VALUES(?,?,?,?)",
            [todo.id, todo.description, todo.isDone ? 1 : 0, task.id]);
      });
      state = [...state, task];
    });
  }

  void addTodo(Todo todo, String taskID) {
    final String insertTodo =
        'INSERT INTO TODO(id,description,isDone,taskID) VALUES(?,?,?,?)';
    db.rawInsert(insertTodo,
        [todo.id, todo.description, todo.isDone ? 1 : 0, taskID]).then((value) {
      state = [
        for (final task in state)
          if (task.id == taskID)
            Task(id: taskID, title: task.title, todos: [...task.todos, todo])
          else
            task
      ];
    });
  }

  void updateTodo(int index, Todo updatedTodo) {
    updateTodoDB(state[index].id, updatedTodo).then((value) {
      state = [
        for (final task in state)
          if (task.id == state[index].id)
            Task(id: task.id, title: task.title, todos: [
              for (final todo in state[index].todos)
                if (todo.id == updatedTodo.id) updatedTodo else todo
            ])
          else
            task
      ];
    });
  }

  Task getTask(String id) {
    return state.firstWhere((element) => element.id == id);
  }
}
