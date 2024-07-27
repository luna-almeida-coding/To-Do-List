import 'package:to_do_list/core/errors/failures/failure.dart';
import 'package:to_do_list/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:to_do_list/features/to_do_list/domain/repositories/i_to_do_repository.dart';

class GetToDoListUseCase {
  final IToDoRepository iToDoRepository;

  GetToDoListUseCase(this.iToDoRepository);

  Future<Either<Failure, List<ToDoEntity>>> call() async {
    return await iToDoRepository.getToDoList();
  }
}
