import 'package:to_do_list_squad_premiun/features/to_do_list/data/models/to_do_model.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';

List<ToDoEntity> mockToDoEntityList = [
  const ToDoEntity(description: 'Clean the house', isCompleted: true),
  const ToDoEntity(description: 'Exercise', isCompleted: false),
  const ToDoEntity(description: 'Sleep', isCompleted: false),
];

 List<ToDoModel> mockTodoListModel = [
  const ToDoModel(description: 'Clean the house', isCompleted: true),
  const ToDoModel(description: 'Exercise', isCompleted: false),
  const ToDoModel(description: 'Sleep', isCompleted: false),
];

const ToDoEntity mockNewToDoItem = ToDoEntity(description: 'Eat', isCompleted: false);

const List<String> toDoListString = [
  "{\"description\":\"Clean the house\",\"isCompleted\":true}",
  "{\"description\":\"Exercise\",\"isCompleted\":false}",
  "{\"description\":\"Sleep\",\"isCompleted\":false}",
];
