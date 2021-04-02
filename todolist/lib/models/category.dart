class Category{
  int id;
  String name;
  String description;
  categoryMap(){
  var mapping=new Map<String,dynamic>();
  mapping['id']=id;
  mapping['name']=name;
  mapping['description']=description;
  return mapping;
  }

}