import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();

  List<Map<String, dynamic>> listTodo = [
    {"task": "flutter app", "desc": "flutter app", "isCompleted": false},
    {"task": "flutter task", "desc": "flutter app", "isCompleted": false}
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(" TASKS ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  //border: Border.all(color: Colors.black54),
                  color: listTodo[index]["isCompleted"]
                      ? Colors.green
                      : Colors.grey.shade300,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
              child: InkWell(
                child: ListTile(
                    leading: Checkbox(
                      value: listTodo[index]["isCompleted"],
                      onChanged: (bool? value) {
                        listTodo[index]["isCompleted"] =
                            !listTodo[index]["isCompleted"];
                        setState(() {});
                      }
                    ),
                    title: Text(listTodo[index]["task"]),
                    subtitle: Text(listTodo[index]["desc"]),
                    trailing: InkWell(
                        onTap: () {
                          listTodo.removeAt(index);
                          setState(() {});
                        },
                        child: Icon(Icons.delete,color: Colors.red,))),
                onTap: (){
                  showModalBottomSheet(context: context, builder: (context){

                    taskController.text = listTodo[index]['task'];
                    descController.text = listTodo[index]['desc'];


                    return Container(
                      child: Column(
                        children: [
                          /// bottomsheet title
                          Center(
                              child: Text(
                                "Update Task",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
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
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 20))),
                            ),
                          ),
                          SizedBox(
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
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 20))),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          /// add and cancle button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                  onPressed: () {

                                    listTodo[index]["task"] = taskController.text;
                                    listTodo[index]["desc"] = descController.text;

                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Text("Update")),
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancle")),
                            ],
                          ),
                          SizedBox(height: 150,)
                        ],
                      ),
                    );
                  });
                },
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
                      Center(
                          child: Text(
                        "Add Task",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
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
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 20))),
                        ),
                      ),
                      SizedBox(
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
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 20))),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      /// add and cancle button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                listTodo.add({
                                  "task": taskController.text,
                                  "desc": descController.text,
                                  "isCompleted": false
                                });
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text("Add")),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancle")),
                        ],
                      ),
                      SizedBox(height: 150,)
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
