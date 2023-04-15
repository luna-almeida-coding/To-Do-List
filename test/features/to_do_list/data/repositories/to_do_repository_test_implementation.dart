import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_squad_premiun/core/errors/exceptions/exceptions.dart';
import 'package:to_do_list_squad_premiun/core/errors/failures/failure.dart';
import 'package:to_do_list_squad_premiun/features/mocks/to_do_mocks.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/data/datasources/to_do_datasouce.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/data/repositories/to_do_repository_implementation.dart';

class MockIToDoDatasource extends Mock implements IToDoDatasource {}

void main() {
  late ToDoRepositoryImplementation repository;
  late IToDoDatasource datasource;

  setUp(
    () {
      datasource = MockIToDoDatasource();
      repository = ToDoRepositoryImplementation(datasource);
    },
  );

  test(
    'Should return a  List of To Do/s model  from the datasource',
    () async {
      when(() => datasource.getToDoList()).thenAnswer(
        (_) async => mockTodoListModel,
      );

      final result = await repository.getToDoList();

      expect(result, Right(mockTodoListModel));

      verify(() => datasource.getToDoList()).called(1);
    },
  );

  test(
    'Should return a Generic Failure when calls to datasource goes wrong',
    () async {
      when(() => datasource.getToDoList()).thenThrow(
        GenericException(),
      );

      final result = await repository.getToDoList();

      expect(result, Left(GenericFailure()));

      verify(() => datasource.getToDoList()).called(1);
    },
  );
}
