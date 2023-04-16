part of 'to_do_list_cubit.dart';

class ToDoListState extends Equatable {
  final List<ToDoEntity>? toDoList;
  final bool isLoading;

  const ToDoListState({
    this.toDoList,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [toDoList, isLoading];

  ToDoListState copyWith({
    List<ToDoEntity>? toDoList,
    bool? isLoading,
  }) {
    return ToDoListState(
      toDoList: toDoList ?? this.toDoList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
