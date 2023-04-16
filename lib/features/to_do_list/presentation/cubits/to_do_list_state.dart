part of 'to_do_list_cubit.dart';

class ToDoListState extends Equatable {
  final List<ToDoEntity> toDoList;
  final bool isLoading;
  final String errorMessage;

  const ToDoListState({
    this.toDoList = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [toDoList, isLoading, errorMessage];

  ToDoListState copyWith({
    List<ToDoEntity>? toDoList,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ToDoListState(
      toDoList: toDoList ?? this.toDoList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
