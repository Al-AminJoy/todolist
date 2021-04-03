import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/screen/home_screen.dart';
import 'package:todolist/service/category_service.dart';
import 'package:intl/intl.dart';
import 'package:todolist/service/todoService.dart';
class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _titleController=new TextEditingController();
  var _descriptionController=new TextEditingController();
  var _dateController=new TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
  var _selectedValue;
  var _todo=new Todo();
  var _todoService=new TodoService();

  var _categories=List<DropdownMenuItem>();
  DateTime _dateTime=DateTime.now();
  _selectDate(BuildContext context) async{
    var pickDate=await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if(pickDate!=null){
        setState(() {
          _dateTime=pickDate;
          _dateController.text=DateFormat('yyyy-MM-dd').format(pickDate);

        });
    }
  }
  Future<bool> _onBackPressed() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
  _showSnackBar(message){
    var snackBar=new SnackBar(content: message);
    _globalKey.currentState.showSnackBar(snackBar);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCategories();
  }
  void _loadCategories()async {
    var _categoryService=CategoryService();
    var categories=await _categoryService.readCategory();
    categories.forEach((category){
      setState(() {
        _categories.add(DropdownMenuItem(
            child: new Text(category['name']),
          value: category['name'],
        )
        );
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
            key: _globalKey,
            appBar: new AppBar(
              title: new Text('Create Todo'),
            ),
            body: new Container(
              padding: EdgeInsets.all(32.0),
              child: new Column(
                children: [
                  new TextField(
                    controller: _titleController,
                    decoration: new InputDecoration(
                      labelText: 'Title',
                      hintText: 'Write Title',
                    ),
                    maxLines: 1,
                    minLines: 1,
                  ),
                  new TextField(
                    controller: _descriptionController,
                    decoration: new InputDecoration(
                      labelText: 'Description',
                      hintText: 'Write Note',
                    ),
                    maxLines: 20,
                    minLines: 4,
                  ),
                  new TextField(
                    controller: _dateController,
                    decoration: new InputDecoration(
                        labelText: 'Date',
                        hintText: 'Pick a Date',
                        prefixIcon: InkWell(
                          onTap: (){
                            _selectDate(context);
                          },
                          child: new Icon(Icons.calendar_today),
                        )
                    ),
                  ),

                  DropdownButtonFormField(
                    value:_selectedValue ,
                    items: _categories,
                    hint: new Text('Category'),
                    onChanged: (value){
                      setState(() {
                        _selectedValue=value;
                      });
                    },
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                  new ElevatedButton(
                    onPressed: ()async{
                      _todo.title=_titleController.text;
                      _todo.description=_descriptionController.text;
                      _todo.category=_selectedValue.toString();
                      _todo.todoDate=_dateController.text;
                      _todo.isFinished=0;
                      var result=_todoService.saveTodo(_todo);
                      print(result);
                      _showSnackBar(new Text('Added'));
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context)=>HomeScreen()))
                          .then((value) => setState(() => {}));
                    },
                    child: new Text('Save'),)
                ],
              ),
            )
        ),
        onWillPop: _onBackPressed);
  }


}
