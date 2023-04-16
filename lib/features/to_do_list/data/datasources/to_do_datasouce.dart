import 'package:to_do_list_squad_premiun/core/local_storage/local_storage.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/data/models/to_do_model.dart';

abstract class IToDoDatasource {
  Future<List<ToDoModel>> getToDoList();
  Future<bool> updateToDoList();
}

class ToDoDatasource implements IToDoDatasource {
  final LocalStorage localStorage;

  ToDoDatasource(this.localStorage);

  @override
  Future<List<ToDoModel>> getToDoList() async {
    final result = await localStorage.read(key: 'ToDoList');
    List<ToDoModel> toDoModelList = [];

    toDoModelList.addAll(result);

    return toDoModelList;
  }
}
