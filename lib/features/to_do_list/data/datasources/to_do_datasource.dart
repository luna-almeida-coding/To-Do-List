import 'package:to_do_list_squad_premiun/core/constants/constants.dart';
import 'package:to_do_list_squad_premiun/core/errors/exceptions/exceptions.dart';
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

    if (result == null) throw GenericException();

    List<ToDoModel> toDoModelList = [];
    List<String> toDoStringList = result.map<String>((e) => e.toString()).toList();

    toDoModelList = toDoStringList.map((e) => ToDoModel.fromJson(e)).toList();

    return toDoModelList;
  }

  @override
  Future<bool> updateToDoList(List<ToDoEntity> list) async {
    List<String> modelList = [];

    for (var i in list) {
      modelList.add(
        ToDoModel.fromEntity(i).toJson().toString(),
      );
    }

    final result = await localStorage.write(
      key: defaultToDoListKey,
      data: modelList,
    );

    if (!result) throw GenericException();

    return result;
  }
}
