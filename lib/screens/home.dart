import 'dart:ffi' as ffi;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mini_project/constraints/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
 Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
final todosList=ToDo.todoList();
final _todoController=TextEditingController();
 List<ToDo>_FoundToDo=[];

@override
  void initState() {
    // TODO: implement initState
    _FoundToDo=todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(child: 
                ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 20
                      ),
                      child: Text("All Todos",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      
                      ),
                      ),
                    ),
                    
                    for(ToDo todoo in _FoundToDo.reversed)
                    TodoItem(todo: todoo,
                    onToDoChange: _handleToDoChange,
                    onDeleteItems: _deleteToDoItems,
                    ),
                  ],
                )
                ),
               
              ],
              )
          ),
          Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                         children: [
                          Expanded(child: 
                          Container(
                        margin: EdgeInsets.only(
                          bottom: 20,
                          left: 20,
                          right: 20,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20,
                        vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                        ),],
                        borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                            hintText: "add a new to-do item",
                            border: InputBorder.none
                          ),
                        ),
                      ),
                          ),
                           Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton( 
                  child: Text("+",
                  style: TextStyle(fontSize: 40,color: Colors.amberAccent),),
                  onPressed: (){
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                     minimumSize:Size(20, 20),
                    elevation: 0,
                  ),
                  ),
                )
                         ]
                        ),
                    ),

        ],
      )
      );
  }
 void _handleToDoChange(ToDo todo){
    setState((){
      todo.isDone=!todo.isDone;
    });
  }

void _deleteToDoItems(String id){
  setState(() {
    todosList.removeWhere((item)=>item.id==id);
  });
}

void _addToDoItem(String toDo){
  setState(() {
    todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo,));
  });
  _todoController.clear();
}

void _runFilter(String enteredKeyword){
  List<ToDo>results=[];
  if(enteredKeyword.isEmpty){results=todosList;
  }
  else{
    results=todosList.where((item)=>item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
  }
  setState(() {
    _FoundToDo=results;
  });
}
Widget searchBox(){
  return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)

              ),
              child: TextField(
                onChanged: (value) =>_runFilter(value) ,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                  color: tdBlack,
                  size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 20,
                    minWidth: 25
                  ),
                  border: InputBorder.none,
                  hintText: "Search here"
                ),
              ),
  );
           
}

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        SizedBox(
         height: 40,
         width: 40,
         child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/images/avatar.jpg'),
         ),
        )
      ],
      ),
    );
  }
}