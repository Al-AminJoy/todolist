import 'package:todolist/models/category.dart';
import 'package:todolist/repositories/repository.dart';

class CategoryService{
  Repository _repository;
  CategoryService(){
    _repository=Repository();
  }
  saveCategory(Category category) async{
    return await _repository.insertData('categories', category.categoryMap());
  }
  readCategory() async{
    return await _repository.readData('categories');
  }
  readCategoryByID(categoryId)async{
    return await _repository.readDatById('categories', categoryId);
  }

  updateCategory(Category category)async {
    return await _repository.update('categories',category.categoryMap());
  }

  deleteCategory(categoryId) async{
    return  await _repository.deleteDatById('categories', categoryId);
  }
}