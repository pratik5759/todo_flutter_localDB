
import 'package:todo_flutter_local/database/app_database.dart';

class TodoModel {

  int id;
  String task;
  String desc;
  bool isCompleted;
  int createdAt;
  //int? completedAt;

  TodoModel({
    this.id=0,
    required this.task,
    required this.desc,
    this.isCompleted = false,
    required this.createdAt,
    //this.completedAt = 0
  });

  ///creating toMap function
   /*toMap(TodoModel todoModel){

    return

  }*/

  Map<String,dynamic> toMap(){
    return {
      AppDatabase.TODO_TASK : task,
      AppDatabase.TODO_DESC : desc,
      AppDatabase.TODO_IS_COMPLETED : isCompleted ? 1 : 0,
      AppDatabase.TODO_CREATED_AT : createdAt,
      //AppDatabase.TODO_COMPLETED_AT : completedAt
    };
  }

  ///from map function
  factory TodoModel.fromMap(Map<String,dynamic> map){
    /*var a = TodoModel(
        id: map[AppDatabase.TODO_ID],
        task: map[AppDatabase.TODO_TASK],
        desc: map[AppDatabase.TODO_DESC],
        createdAt: map[AppDatabase.TODO_CREATED_AT],
        completedAt: map[AppDatabase.TODO_COMPLETED_AT],
        isCompleted: map[AppDatabase.TODO_IS_COMPLETED]
    );
    print(a);
    return a;
*/
    return TodoModel(
        id: map[AppDatabase.TODO_ID],
        task: map[AppDatabase.TODO_TASK],
        desc: map[AppDatabase.TODO_DESC],
        createdAt: map[AppDatabase.TODO_CREATED_AT],
        //completedAt: map[AppDatabase.TODO_COMPLETED_AT],
        isCompleted: map[AppDatabase.TODO_IS_COMPLETED] == 1 ? true : false
    );

  }


}