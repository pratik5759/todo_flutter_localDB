import 'package:flutter/material.dart';
import 'package:todo_flutter_local/database/app_database.dart';

import '../data_models/todo_data_model.dart';

class DatabaseProvider extends ChangeNotifier{
  AppDatabase db;
  DatabaseProvider({required this.db});

  List<TodoModel> _listTodo = [];

  void addTodoProvider(TodoModel newTodo) async{
    db.addTodo(newTodo: newTodo);
    _listTodo = await db.fetchTodo();
    notifyListeners();
  }

  List<TodoModel> fetchTodoProvider(){
    return _listTodo;
  }

  void updateTodoProvider(){}

  void deleteTodoProvider(){}

  void getInitialTodoProvider() async{
    _listTodo = await db.fetchTodo();
    notifyListeners();
  }

}