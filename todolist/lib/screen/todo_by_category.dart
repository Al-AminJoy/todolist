import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/service/todoService.dart';
class TodoByCategory extends StatefulWidget {
  final String category;

  TodoByCategory({this.category});

  @override
  _TodoByCategoryState createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  var _todoService=new TodoService();
   List<Todo> _todoList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTodoByService();
  }
  _getTodoByService()async{
    var todos=await _todoService.readTodoByCategory(this.widget.category);
    todos.forEach((todo){
      var model=new Todo();
      setState(() {
        model.title=todo['title'];
        model.description=todo['description'];
        model.category=todo['category'];
        model.todoDate=todo['todoDate'];
        model.isFinished=todo['isFinished'];
        _todoList.add(model);
      });

    });
    print(_todoList.length);
  }
  setColor(index){
    DateTime dob = DateTime.parse(_todoList[index].todoDate);
    Duration dur =  DateTime.now().difference(dob);
    if(dur.inDays>0){
      return Card(
        color: Colors.grey,
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3)
        ),
        child: new ListTile(
          title: new Text(_todoList[index].title),
          subtitle: new Text(_todoList[index].description,maxLines: 8),
          trailing: new Text(_todoList[index].todoDate),
        ),
      );
    }
    else{
      return Card(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3)
        ),
        child: new ListTile(
          title: new Text(_todoList[index].title),
          subtitle: new Text(_todoList[index].description,maxLines: 8),
          trailing: new Text(_todoList[index].todoDate),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(this.widget.category),
      ) ,
      body: new Column(
        children: [
          new Expanded(
              child:
              new ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder:(context,index){
                    return setColor(index);
                  }),)
        ],
      )
    );
  }
}
