import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {

  //creating const values (table names)
  static const TODO_TABLE_NAME = "todo";
  static const TODO_ID = "todo_id";
  static const TODO_TASK = "todo_task";
  static const TODO_DESC = "todo_desc";
  static const TODO_IS_COMPLETED = "todo_is_complete";
  static const TODO_CREATED_AT = "todo_created_at";
  static const TODO_COMPLETED_AT = "todo_completed_at";

  /// step 1 create singleton constructor of this class
  AppDatabase._();

  ///step 2 now make a single instance of the singleton constructor
  static final AppDatabase db = AppDatabase._();

  ///step 3 now make the database instance
  Database? myDB;

  ///step 4 now create the get db function which will return instance of db if present else it will create db and then return instance
  Future<Database> getDb() async {
    if(myDB != null){
      return myDB!;
    }else{
      myDB = await initDb();
      return myDB!;
    }
  }

  /// step 5 now create the init function which initializes the db
  Future<Database> initDb() async{

    // step 1 in initDb get the path of documents directory in the phone
    var rootPath = await getApplicationDocumentsDirectory();

    // step 2 in initDb to concatenate or join the rootPath with db name to make final path
    var actualPath = join(rootPath.path,"todoDB.db");

    // step 3 now create the db

    myDB = await openDatabase(actualPath,version: 1,onCreate: (db,version){

      // step 4 when the db is opened then create the table for the database
      db.execute(' create table $TODO_TABLE_NAME ($TODO_ID integer primary key autoincrement,$TODO_TASK text,$TODO_DESC text,$TODO_IS_COMPLETED integer,$TODO_CREATED_AT integer)');

    });

    // step 5 return instance of db
    return myDB!;
  }

  /// step 6 now create addTodo function
  void addTodo({required String task,required String desc,int isCompleted = 0,required int createdAt}) async {

    var db = await getDb();

    db.insert(TODO_TABLE_NAME, {
      TODO_TASK : task,
      TODO_DESC : desc,
      TODO_IS_COMPLETED : isCompleted,
      TODO_CREATED_AT : createdAt
    });

  }

  /// step 7 now create fetchTodo function
  Future<List<Map<String,dynamic>>> fetchTodo() async{

    var db = await getDb();

    var mData = await db.query(TODO_TABLE_NAME);

    return mData;
  }

  /// to update isCompleted
  void updateIsCompleted({required int isCompleted,required id}) async{

    var db = await getDb();
    db.update(TODO_TABLE_NAME, {TODO_IS_COMPLETED: isCompleted},where: "$TODO_ID = $id");
  }


}