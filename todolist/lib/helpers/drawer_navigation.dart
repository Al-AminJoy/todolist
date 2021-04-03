import 'package:flutter/material.dart';
import 'package:todolist/screen/categories_screen.dart';
import 'package:todolist/screen/home_screen.dart';
import 'package:todolist/screen/todo_by_category.dart';
import 'package:todolist/service/category_service.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
 CategoryService categoryService=CategoryService();
 List<Widget> _categoryList=List<Widget>();

 @override
  void initState() {
   super.initState();
 getAllCategories();
  }

  getAllCategories() async {
    var categories = await categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        _categoryList.add(ListTile(
          onTap:(){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>TodoByCategory(category:category['name'])
                ));
          },
          title: Text(category['name']),
        ));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Drawer(
        child: new ListView(
          children: [
            new UserAccountsDrawerHeader(
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg'),
              ),
              accountName: new Text('Al-Amin Islam'),
              accountEmail: new Text('alaminislam3555@gmail.com'),
              decoration: new BoxDecoration(color: Colors.blue),
            ),
            new ListTile(
              leading: Icon(Icons.home),
              title: new Text('Home'),
              onTap: ()=>Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>new HomeScreen())),
            ),
            new ListTile(
              leading: Icon(Icons.view_list),
              title: new Text('Categories'),
              onTap: ()=>Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>new CategoriesScreen())),
            ),
            new Column(
              children: _categoryList,
            )
          ],
        ),
      ),
    );
  }
}
