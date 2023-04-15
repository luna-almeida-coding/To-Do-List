import 'package:dartz/dartz.dart';
import 'package:to_do_list_squad_premiun/core/errors/failures/failure.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/repositories/i_to_do_repository.dart';

class UpdateToDoListUsecase {
  final IToDoRepository repository;

  UpdateToDoListUsecase(this.repository);

  Future<Either<Failure, bool>> updateToDoList() async {
    return await repository.updateToDoList();
  }
}
