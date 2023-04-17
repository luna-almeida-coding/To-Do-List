import 'package:to_do_list_squad_premiun/features/to_do_list/data/models/to_do_model.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';

const List<ToDoEntity> mockToDoEntityList = [
  ToDoEntity(description: 'Clean the house', isCompleted: true),
  ToDoEntity(description: 'Exercise', isCompleted: false),
  ToDoEntity(description: 'Sleep', isCompleted: false),
];

const List<ToDoModel> mockTodoListModel = [
  ToDoModel(description: 'Clean the house', isCompleted: true),
  ToDoModel(description: 'Exercise', isCompleted: false),
  ToDoModel(description: 'Sleep', isCompleted: false),
];

const ToDoEntity mockNewToDoItem = ToDoEntity(description: 'Eat', isCompleted: false);

const List<String> toDoListString = [
  "{\"description\":\"Clean the house\",\"isCompleted\":true}",
  "{\"description\":\"Exercise\",\"isCompleted\":false}",
  "{\"description\":\"Sleep\",\"isCompleted\":false}",
];
