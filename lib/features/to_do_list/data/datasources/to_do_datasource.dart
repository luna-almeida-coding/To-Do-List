import 'package:to_do_list_squad_premiun/core/constants/constants.dart';
import 'package:to_do_list_squad_premiun/core/local_storage/local_storage.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/data/models/to_do_model.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';

abstract class IToDoDatasource {
  Future<List<ToDoModel>> getToDoList();

  Future<bool> updateToDoList(List<ToDoEntity> list);
}

class ToDoDatasource implements IToDoDatasource {
  final LocalStorage localStorage;

  ToDoDatasource(this.localStorage);

  @override
  Future<List<ToDoModel>> getToDoList() async {
    final result = await localStorage.read(key: defaultToDoListKey);
    List<ToDoModel> toDoModelList = [];

    toDoModelList.addAll(result);

    return toDoModelList;
  }

  @override
  Future<bool> updateToDoList(List<ToDoEntity> list) async {
    List<ToDoModel> modelList = [];

    for (var i in list) {
      modelList.add(ToDoModel.fromEntity(i));
    }

    return await localStorage.write(
      key: defaultToDoListKey,
      data: modelList,
    );
  }
}
