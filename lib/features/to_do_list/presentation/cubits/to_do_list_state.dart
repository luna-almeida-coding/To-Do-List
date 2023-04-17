part of 'to_do_list_cubit.dart';

enum FilterTypes {
  all,
  pending,
  done,
}

class ToDoListState extends Equatable {
  final List<ToDoEntity> toDoList;
  final bool isLoading;
  final String errorMessage;
  final List<ToDoEntity> filteredList;
  final FilterTypes currentFilter;

  const ToDoListState({
    this.toDoList = const [],
    this.isLoading = true,
    this.errorMessage = '',
    this.filteredList = const [],
    this.currentFilter = FilterTypes.all,
  });

  @override
  List<Object?> get props => [toDoList, isLoading, errorMessage, filteredList, currentFilter];

  ToDoListState copyWith({
    List<ToDoEntity>? toDoList,
    bool? isLoading,
    String? errorMessage,
    List<ToDoEntity>? filteredList,
    FilterTypes? currentFilter,
  }) {
    return ToDoListState(
      toDoList: toDoList ?? this.toDoList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      filteredList: filteredList ?? this.filteredList,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}
