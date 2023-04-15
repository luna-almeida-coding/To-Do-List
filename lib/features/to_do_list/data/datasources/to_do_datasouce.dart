import 'package:to_do_list_squad_premiun/features/to_do_list/data/models/to_do_model.dart';

abstract class IToDoDatasource {
  Future<List<ToDoModel>> getToDoList();
}
