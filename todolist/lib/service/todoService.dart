import 'package:todolist/models/todo.dart';
import 'package:todolist/repositories/repository.dart';

class TodoService{
  Repository _repository;
  TodoService(){
    _repository=Repository();
  }
  saveTodo(Todo todo)async{
    return await _repository.insertData('todos', todo.todoMap());
  }
  readTodo()async{
    return await _repository.readData('todos');
  }
}