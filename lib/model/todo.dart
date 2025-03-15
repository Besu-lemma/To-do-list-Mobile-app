class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
 this. isDone=false,
  } 
  );
  static List<ToDo>todoList(){
    return[
      ToDo(id: "1", todoText: "Exercise", isDone: true),
      ToDo(id: "2", todoText: "check Email",isDone: true),
      ToDo(id: "3", todoText: "Praying for 30 minutes"),
      ToDo(id: "4", todoText: "Meeting"),
      ToDo(id: "5", todoText: "Cooding"),
      ToDo(id: "6", todoText: "Eating healthy food"),
    ];
  }

}