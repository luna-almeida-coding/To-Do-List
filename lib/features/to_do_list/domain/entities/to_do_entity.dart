import 'package:equatable/equatable.dart';

class ToDoEntity extends Equatable {
  final String description;
  final bool isCompleted;

  const ToDoEntity({
    required this.description,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [description, isCompleted];
}
