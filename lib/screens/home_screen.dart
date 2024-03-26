import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

import '../data_models/todo_data_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();

  List<TodoModel> listTodo = [];

  final dateFormat = DateFormat.MMMMEEEEd();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(" TASKS ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: listTodo.isNotEmpty ? ListView.builder(
        itemCount: listTodo.length,
        itemBuilder: (context, index) {

          ///list item content (LIST_TILE)
          return Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),

            ///list tile with container for decor
            child: InkWell(
              onTap: !listTodo[index].isCompleted ? (){
                taskController.text = listTodo[index].task;
                descController.text = listTodo[index].desc;
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

                        /// add and cancle button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    listTodo[index].task = taskController.text;
                                    listTodo[index].desc = descController.text;
                                    listTodo[index].createdAt = DateTime.now().millisecondsSinceEpoch;
                                  });
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
                    //border: Border.all(color: Colors.black54),
                    color: listTodo[index].isCompleted
                        ? Colors.green
                        : Colors.grey.shade300,
                    boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 5)]),
                child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Checkbox(
                              value: listTodo[index].isCompleted,
                              onChanged: (bool? value) {
                                listTodo[index].isCompleted=
                                    !listTodo[index].isCompleted;
                                listTodo[index].completedAt = DateTime.now().millisecondsSinceEpoch;
                                setState(() {});
                              }
                            ),
                          ),
                          //compleated at timer
                          Expanded(flex: 1,child: listTodo[index].isCompleted ? Text(dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(listTodo[index].completedAt)),overflow: TextOverflow.clip,style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),): Text(""))
                        ],
                      ),
                    ),
                    title: Text(listTodo[index].task,style: TextStyle(fontWeight: FontWeight.bold,decoration: listTodo[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none),),
                    subtitle: Text(listTodo[index].desc,style: TextStyle(fontWeight: FontWeight.w300),),
                    trailing: SizedBox(width:70,child: Text(dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(listTodo[index].createdAt)),overflow: TextOverflow.clip,)),),
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
                                listTodo.add(/*{
                                  "task": taskController.text,
                                  "desc": descController.text,
                                  "isCompleted": false

                                }*/
                                TodoModel(task: taskController.text, desc: descController.text, createdAt: DateTime.now().millisecondsSinceEpoch));
                                setState(() {});
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
