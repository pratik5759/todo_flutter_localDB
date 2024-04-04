import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:todo_flutter_local/database/app_database.dart';

//import '../data_models/todo_data_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  AppDatabase? db;
  List<Map<String,dynamic>> listDBdata = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = AppDatabase.db;
    getTodo();

  }

   void getTodo() async{

    listDBdata = await db!.fetchTodo();
    setState(() {
      print(listDBdata);
    });
   }

  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();


  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(" TASKS ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: listDBdata.isNotEmpty ? ListView.builder(
        itemCount: listDBdata.length,
        itemBuilder: (context, index) {

          ///list item content (LIST_TILE)
          return Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),

            ///list tile with container for decor
            child: InkWell(
              onTap: listDBdata[index][AppDatabase.TODO_COMPLETED_AT] == 0 ? (){
                taskController.text = listDBdata[index][AppDatabase.TODO_TASK];
                descController.text = listDBdata[index][AppDatabase.TODO_TASK];
                showModalBottomSheet(context: context, builder: (context){
                  return Container(
                    child: Column(
                      children: [
                        /// bottomsheet title
                        const Center(
                            child: Text(
                              "Update Task",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          height: 10,
                        ),

                        ///add task texfeild
                        Container(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                                controller: taskController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400)),
                                    hintText: "Task",
                                    hintStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 20))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        /// add task desc
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                              controller: descController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400)),
                                  hintText: "Task Description",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 20))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        /// update and cancle button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  /*setState(() {
                                    listTodo[index].task = taskController.text;
                                    listTodo[index].desc = descController.text;
                                    listTodo[index].createdAt = DateTime.now().millisecondsSinceEpoch;
                                  });*/

                                  Navigator.pop(context);
                                },
                                child: const Text("Update")),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancle")),
                          ],
                        ),
                        const SizedBox(height: 150,)
                      ],
                    ),
                  );
                });
              }:(){},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: listDBdata[index][AppDatabase.TODO_IS_COMPLETED] == 1
                        ? Colors.green
                        : Colors.grey.shade300,
                    boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 5)]),

                child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      child: Checkbox(
                        value: listDBdata[index][AppDatabase.TODO_IS_COMPLETED] == 1 ? true : false,
                        onChanged: (bool? value) {
                          var currentVal = listDBdata[index][AppDatabase.TODO_IS_COMPLETED];
                          var updatedValue = currentVal == 1 ? 0 : 1;
                          db!.updateIsCompleted(isCompleted: updatedValue, id: listDBdata[index][AppDatabase.TODO_ID]);
                          getTodo();

                        }
                      ),
                    ),
                    title: Text(listDBdata[index][AppDatabase.TODO_TASK],style: TextStyle(fontWeight: FontWeight.bold,decoration: listDBdata[index][AppDatabase.TODO_IS_COMPLETED] == 1 ? TextDecoration.lineThrough : TextDecoration.none),),
                    subtitle: Text(listDBdata[index][AppDatabase.TODO_DESC],style: TextStyle(fontWeight: FontWeight.w300),),
                    trailing: SizedBox(width:70,child: Text(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(listDBdata[index][AppDatabase.TODO_CREATED_AT])),overflow: TextOverflow.clip,)),),
              ),
            ),
          );
        },
      ) : Center(child: Container(child: Lottie.asset("assets/animations/no_data.json"),),),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              useSafeArea: true,
              context: context,
              builder: (conext) {
                taskController.clear();
                descController.clear();
                return Container(
                  child: Column(
                    children: [
                      /// bottomsheet title
                      const Center(
                          child: Text(
                        "Add Task",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        height: 10,
                      ),

                      ///add task texfeild
                      Container(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                              controller: taskController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400)),
                                  hintText: "Task",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 20))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      /// add task desc
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                            controller: descController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                hintText: "Task Description",
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 20))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      /// add and cancle button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                /*listTodo.add({
                                  "task": taskController.text,
                                  "desc": descController.text,
                                  "isCompleted": false

                                }
                                TodoModel(task: taskController.text, desc: descController.text, createdAt: DateTime.now().millisecondsSinceEpoch));
                                setState(() {});*/
                                ///adding data to database
                                db!.addTodo(task: taskController.text, desc: descController.text, createdAt: DateTime.now().millisecondsSinceEpoch);
                                getTodo();
                                Navigator.pop(context);
                              },
                              child: const Text("Add")),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancle")),
                        ],
                      ),
                      const SizedBox(height: 150,)
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
