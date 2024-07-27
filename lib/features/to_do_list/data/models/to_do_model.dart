import 'dart:convert';

import 'package:to_do_list/features/to_do_list/domain/entities/to_do_entity.dart';

class ToDoModel extends ToDoEntity {
  const ToDoModel({
    required super.description,
    required super.isCompleted,
  });

  factory ToDoModel.fromEntity(ToDoEntity entity) {
    return ToDoModel(
      description: entity.description,
      isCompleted: entity.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      description: map['description'],
      isCompleted: map['isCompleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoModel.fromJson(String data) => ToDoModel.fromMap(json.decode(data));
}
