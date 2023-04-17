import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_squad_premiun/core/errors/exceptions/exceptions.dart';
import 'package:to_do_list_squad_premiun/core/errors/failures/failure.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/data/datasources/to_do_datasource.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/data/repositories/to_do_repository_implementation.dart';

import '../../../../mocks/to_do_mocks.dart';

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

  group('Get ToDo List', () {
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

        expect(result, const Left(GenericFailure()));

        verify(() => datasource.getToDoList()).called(1);
      },
    );
  });

  group('Update ToDo List', () {
    test(
      'Should return true when successful update ToDoList from the datasource',
      () async {
        when(() => datasource.updateToDoList(mockToDoEntityList)).thenAnswer(
          (_) async => true,
        );

        final result = await repository.updateToDoList(mockToDoEntityList);

        expect(result, const Right(true));
        verify(() => datasource.updateToDoList(mockToDoEntityList)).called(1);
      },
    );

    test(
      'Should return a Generic Exception when unsuccessful update ToDoList from the datasource',
      () async {
        when(() => datasource.updateToDoList(mockToDoEntityList)).thenThrow(
          GenericException(),
        );

        final result = await repository.updateToDoList(mockToDoEntityList);

        expect(result, const Left(GenericFailure()));
        verify(() => datasource.updateToDoList(mockToDoEntityList)).called(1);
      },
    );
  });
}
