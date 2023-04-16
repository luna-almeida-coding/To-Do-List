import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list_squad_premiun/core/errors/failures/failure.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/repositories/i_to_do_repository.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/use_cases/get_to_do_list_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/to_do_mocks.dart';

class MockToDoRepository extends Mock implements IToDoRepository {}

void main() {
  late GetToDoListUseCase usecase;
  late IToDoRepository repository;

  setUp(() {
    repository = MockToDoRepository();
    usecase = GetToDoListUseCase(repository);
  });

  test(
    'Should get a list of To Do\'s from the repository',
    () async {
      when(() => repository.getToDoList()).thenAnswer(
        (_) async => Right(mockToDoEntityList),
      );

      final result = await usecase();

      expect(result, Right(mockToDoEntityList));

      verify(() => repository.getToDoList()).called(1);
    },
  );

  test(
    'Should return a Generic Failure from the repository when calls goes wrong',
    () async {
      when(() => repository.getToDoList()).thenAnswer(
        (_) async => Left(GenericFailure()),
      );

      final result = await usecase();

      expect(result, Left(GenericFailure()));

      verify(() => repository.getToDoList()).called(1);
    },
  );
}
