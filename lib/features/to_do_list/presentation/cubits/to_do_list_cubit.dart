import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/use_cases/get_to_do_list_use_case.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/use_cases/update_to_do_list_use_case_use_case.dart';

part 'to_do_list_state.dart';

class ToDoListCubit extends Cubit<ToDoListState> {
  final GetToDoListUseCase toDoListUseCase;
  final UpdateToDoListUsecase updateToDoListUseCase;

  ToDoListCubit({
    required this.toDoListUseCase,
    required this.updateToDoListUseCase,
  }) : super(const ToDoListState());

  Future<void> getToDoList() async {
    emit(
      state.copyWith(
        toDoList: [],
        isLoading: true,
        currentFilter: FilterTypes.all,
      ),
    );
    final result = await toDoListUseCase();

    result.fold(
      (l) => _errorHandler(l.errorMessage),
      (r) {
        emit(
          state.copyWith(
            toDoList: r,
            isLoading: false,
            filteredList: _sortToDoList(r),
          ),
        );
      },
    );
  }

  void filterToDoList(FilterTypes filterType) {
    switch (filterType) {
      case FilterTypes.done:
        emit(
          state.copyWith(
            currentFilter: filterType,
            filteredList: state.toDoList.where((element) => element.isCompleted).toList(),
          ),
        );
        break;
      case FilterTypes.all:
        emit(
          state.copyWith(
            currentFilter: filterType,
            filteredList: _sortToDoList(state.toDoList),
          ),
        );
        break;
      case FilterTypes.pending:
        emit(
          state.copyWith(
            currentFilter: filterType,
            filteredList: state.toDoList.where((element) => !element.isCompleted).toList(),
          ),
        );
        break;
    }
  }

  Future<void> addToDoItemToList(ToDoEntity newItem) async {
    List<ToDoEntity> newToDoList = [];

    newToDoList.addAll(state.toDoList);
    newToDoList.add(newItem);

    final result = await updateToDoListUseCase(newToDoList);

    result.fold(
      (l) => _errorHandler(l.errorMessage),
      (_) {
        emit(
          state.copyWith(
            toDoList: newToDoList,
            isLoading: false,
          ),
        );
        filterToDoList(state.currentFilter);
      },
    );
  }

  Future<void> removeToDoItem(int index) async {
    List<ToDoEntity> newList = [];

    newList.addAll(state.toDoList);

    newList.removeAt(index);

    final result = await updateToDoListUseCase(newList);

    result.fold(
      (l) => _errorHandler(l.errorMessage),
      (_) {
        emit(
          state.copyWith(
            toDoList: newList,
            isLoading: false,
            filteredList: _sortToDoList(newList),
          ),
        );
      },
    );
  }

  Future<void> updateToDoItemStatus({
    required int index,
    required bool isCompleted,
  }) async {
    List<ToDoEntity> newList = [];

    newList.addAll(state.filteredList);

    newList[index] = ToDoEntity(
      description: newList[index].description,
      isCompleted: isCompleted,
    );

    final result = await updateToDoListUseCase(newList);
    result.fold(
      (l) => _errorHandler(l.errorMessage),
      (r) {
        filterToDoList(state.currentFilter);

        emit(
          state.copyWith(
            toDoList: newList,
            filteredList: _sortToDoList(newList),
          ),
        );
      },
    );
  }

  void _errorHandler(String? errorMessage) {
    emit(
      state.copyWith(
        isLoading: false,
        errorMessage: errorMessage ?? '',
      ),
    );
  }

  List<ToDoEntity> _sortToDoList(List<ToDoEntity> list) {
    list.sort(
      (a, b) => a.isCompleted == b.isCompleted
          ? 0
          : a.isCompleted
              ? 1
              : -1,
    );
    return list;
  }
}
