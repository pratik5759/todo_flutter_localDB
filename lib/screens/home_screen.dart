import 'package:flutter/material.dart';

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
        title: Text("TODO"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: listTodo.length,
        itemBuilder: (context, index) {

          return Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),

            ///list tile with container for decor
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black54),
                  color: listTodo[index]["isCompleted"] ? Colors.green : Colors.grey,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),

              child: ListTile(
                leading: Checkbox(
                  value: listTodo[index]["isCompleted"],
                  onChanged: (bool? value) {
                    listTodo[index]["isCompleted"] = !listTodo[index]["isCompleted"];
                    setState(() {});
                  },
                ),
                title: Text(listTodo[index]["task"]),
                subtitle: Text(listTodo[index]["desc"]),
                trailing: InkWell(onTap: (){listTodo.removeAt(index);setState(() {
                  
                });},child: Icon(Icons.delete_forever))

              ),
            ),
          );
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(useSafeArea: true,context: context, builder: (conext){

           return Container(
             child: Column(
               children: [

                 /// bottomsheet title
                 Center(child: Text("Add Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                 SizedBox(height: 10,),

                 ///add task texfeild
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: TextField(
                     controller: taskController,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(15),
                         borderSide: BorderSide(color: Colors.grey.shade400)
                       ),
                       hintText: "Task",
                       hintStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 20
                       )
                     )
                   ),
                 ),
                 SizedBox(height: 10,),

                 /// add task desc
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: TextField(
                       controller: descController,
                       decoration: InputDecoration(
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(15),
                               borderSide: BorderSide(color: Colors.grey.shade400)
                           ),
                           hintText: "Task Description",
                           hintStyle: TextStyle(
                               color: Colors.grey,
                               fontSize: 20
                           )
                       )
                   ),
                 ),
                 SizedBox(height: 10,),

                 /// add and cancle button
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     OutlinedButton(onPressed: (){
                       listTodo.add({"task":taskController.text,"desc":descController.text,"isCompleted":false});
                       setState(() {

                       });
                       Navigator.pop(context);
                     }, child: Text("Add")),
                     OutlinedButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancle")),

                   ],
                 )
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
