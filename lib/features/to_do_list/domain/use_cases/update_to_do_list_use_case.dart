import 'package:dartz/dartz.dart';
import 'package:to_do_list/core/errors/failures/failure.dart';
import 'package:to_do_list/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:to_do_list/features/to_do_list/domain/repositories/i_to_do_repository.dart';

class UpdateToDoListUsecase {
  final IToDoRepository repository;

  UpdateToDoListUsecase(this.repository);

  Future<Either<Failure, bool>> call(List<ToDoEntity> list) async {
    return await repository.updateToDoList(list);
  }
}
