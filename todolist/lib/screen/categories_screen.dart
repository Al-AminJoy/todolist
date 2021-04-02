import 'package:flutter/material.dart';
import 'package:todolist/models/category.dart';
import 'package:todolist/screen/home_screen.dart';
import 'package:todolist/service/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _category = new Category();
  var _categoryController = new TextEditingController();
  var _descriptionController = new TextEditingController();
  var _updateCategoryController = new TextEditingController();
  var _updateDescriptionController = new TextEditingController();
  var categoryService = new CategoryService();
  List<Category> _categoryList = [];
  var category;
  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        var model = new Category();
        model.id = category['id'];
        model.name = category['name'];
        model.description = category['description'];
        _categoryList.add(model);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await categoryService.readCategoryByID(categoryId);
    setState(() {
      _updateCategoryController.text = category[0]['name'] ?? 'No Name';
      _updateDescriptionController.text =
          category[0]['description'] ?? 'No Description';
    });
    _editFromDialog(context);
  }

  _showFromDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: new Text('Categories Form'),
            actions: [
              new ElevatedButton(
                onPressed: () async {
                  _category.name = _categoryController.text;
                  _category.description = _descriptionController.text;
                  var result = await categoryService.saveCategory(_category);
                  print(result);
                  _categoryList.clear();
                  getAllCategories();
                  Navigator.pop(context);
                  _showSnackBar(new Text('Added'));
                  _categoryController.clear();
                  _descriptionController.clear();
                },
                child: new Text('Add'),
              ),
              new ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSnackBar(new Text('Canceled'));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white,
                ),
                child: new Text('Cancel'),
              ),
            ],
            content: new SingleChildScrollView(
              child: new Column(
                children: [
                  new TextField(
                    decoration: new InputDecoration(
                      hintText: 'Write A Category',
                      labelText: 'Category',
                    ),
                    minLines: 1,
                    maxLines: 1,
                    controller: _categoryController,
                  ),
                  new TextField(
                    decoration: new InputDecoration(
                      hintText: 'Write a Description',
                      labelText: 'Description',
                    ),
                    minLines: 2,
                    maxLines: 20,
                    controller: _descriptionController,
                  ),
                ],
              ),
            ),
          );
        });
  }


  _deleteFromDialog(BuildContext context,categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: new Text('Are You Sure ?'),
            actions: [
              new ElevatedButton(
                onPressed: () async {

                  var result = await categoryService.deleteCategory(categoryId);
                  print(result);
                  _categoryList.clear();
                  getAllCategories();
                  _showSnackBar(new Text('Deleted'));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white,
                ),
                child: new Text('Delete'),
              ),
              new ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSnackBar(new Text('Canceled'));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white,
                ),
                child: new Text('Cancel'),
              ),
            ],

          );
        });
  }

_showSnackBar(message){
    var snackBar=new SnackBar(content: message);
    _globalKey.currentState.showSnackBar(snackBar);
}
  _editFromDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: new Text('Update Categories Form'),
            actions: [
              new ElevatedButton(
                onPressed: () async {
                  _category.id=category[0]['id'];
                  _category.name = _updateCategoryController.text;
                  _category.description = _updateDescriptionController.text;
                  var result = await categoryService.updateCategory(_category);
                  _updateCategoryController.clear();
                  _updateDescriptionController.clear();
                  print('Update Result : $result');
                  Navigator.pop(context);
                  _categoryList.clear();
                  getAllCategories();
                  _showSnackBar(new Text('Updated'));
                },
                child: new Text('Update'),
              ),
              new ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSnackBar(new Text('Canceled'));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white,
                ),
                child: new Text('Cancel'),
              ),
            ],
            content: new SingleChildScrollView(
              child: new Column(
                children: [
                  new TextField(
                    decoration: new InputDecoration(
                      hintText: 'Write A Category',
                      labelText: 'Category',
                    ),
                    minLines: 1,
                    maxLines: 1,
                    controller: _updateCategoryController,
                  ),
                  new TextField(
                    decoration: new InputDecoration(
                      hintText: 'Write a Description',
                      labelText: 'Description',
                    ),
                    minLines: 2,
                    maxLines: 20,
                    controller: _updateDescriptionController,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _globalKey,
      appBar: new AppBar(
        title: new Text('Categories'),
        leading: new TextButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => new HomeScreen()));
          },
          child: new Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _showFromDialog(context),
        child: new Icon(Icons.add),
      ),
      body: new ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Card(
              child: new ListTile(
                leading: IconButton(
                  onPressed: () {
                    _editCategory(context, _categoryList[index].id);
                  },
                  icon: new Icon(Icons.edit),
                ),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text(_categoryList[index].name),
                  ],
                ),
                trailing: new IconButton(
                  icon: new Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleteFromDialog(context,_categoryList[index].id);
                  },
                ),
              ),
            );
          }),
    );
  }
}
