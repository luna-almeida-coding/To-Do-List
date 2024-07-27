import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list/core/errors/failures/failure.dart';
import 'package:to_do_list/features/to_do_list/domain/repositories/i_to_do_repository.dart';
import 'package:to_do_list/features/to_do_list/domain/use_cases/update_to_do_list_use_case.dart';

import '../../../../mocks/to_do_mocks.dart';

class MockTodoRepository extends Mock implements IToDoRepository {}

void main() {
  late UpdateToDoListUsecase usecase;
  late IToDoRepository repository;

  setUp(
    () {
      repository = MockTodoRepository();
      usecase = UpdateToDoListUsecase(repository);
    },
  );

  test(
    'Should return true from the repository if ToDo List was successful updated',
    () async {
      when(() => repository.updateToDoList(mockToDoEntityList)).thenAnswer(
        (_) async => const Right(true),
      );

      final result = await usecase.call(mockToDoEntityList);

      expect(result, const Right(true));

      verify(() => repository.updateToDoList(mockToDoEntityList)).called(1);
    },
  );

  test(
    'Should return a GenericFailure from the repository if ToDo List was unsuccessful updated',
    () async {
      when(() => repository.updateToDoList(mockToDoEntityList)).thenAnswer(
        (_) async => const Left(GenericFailure()),
      );

      final result = await usecase.call(mockToDoEntityList);

      expect(result, const Left(GenericFailure()));

      verify(() => repository.updateToDoList(mockToDoEntityList)).called(1);
    },
  );
}
