import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';

class ToDoModel extends ToDoEntity {
  const ToDoModel({
    required super.description,
    required super.isCompleted,
  });
}
