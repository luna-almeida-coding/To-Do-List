import 'package:dartz/dartz.dart';
import 'package:to_do_list/core/errors/failures/failure.dart';
import 'package:to_do_list/features/to_do_list/domain/entities/to_do_entity.dart';

abstract class IToDoRepository {
  Future<Either<Failure, List<ToDoEntity>>> getToDoList();

  Future<Either<Failure, bool>> updateToDoList(List<ToDoEntity> list);
}
