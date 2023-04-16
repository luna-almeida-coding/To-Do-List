import 'package:dartz/dartz.dart';
import 'package:to_do_list_squad_premiun/core/errors/exceptions/exceptions.dart';
import 'package:to_do_list_squad_premiun/core/errors/failures/failure.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/data/datasources/to_do_datasource.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/repositories/i_to_do_repository.dart';

class ToDoRepositoryImplementation implements IToDoRepository {
  final IToDoDatasource datasource;

  ToDoRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, List<ToDoEntity>>> getToDoList() async {
    try {
      return Right(await datasource.getToDoList());
    } on GenericException {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateToDoList(List<ToDoEntity> list) async {
    try {
      return Right(await datasource.updateToDoList(list));
    } on GenericException {
      return Left(GenericFailure());
    }
  }
}
