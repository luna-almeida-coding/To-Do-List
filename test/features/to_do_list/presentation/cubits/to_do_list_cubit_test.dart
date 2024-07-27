import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list/core/errors/failures/failure.dart';
import 'package:to_do_list/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:to_do_list/features/to_do_list/domain/use_cases/get_to_do_list_use_case.dart';
import 'package:to_do_list/features/to_do_list/domain/use_cases/update_to_do_list_use_case.dart';
import 'package:to_do_list/features/to_do_list/presentation/cubits/to_do_list_cubit.dart';

import '../../../../mocks/to_do_mocks.dart';

class MockToDoListUseCase extends Mock implements GetToDoListUseCase {}

class MockUpdateToDoListUsecase extends Mock implements UpdateToDoListUsecase {}

void main() {
  late ToDoListCubit cubit;
  late GetToDoListUseCase getToDoListUseCase;
  late UpdateToDoListUsecase updateToDoListUsecase;

  Future<void> successfulGetToDoListArrange() async {
    when(() => getToDoListUseCase()).thenAnswer(
      (_) async => Right(mockToDoEntityList),
    );
  }

  Future<void> unSuccessfulGetToDoListCallArrange() async {
    when(() => getToDoListUseCase()).thenAnswer(
      (_) async {
        return const Left(
          GenericFailure(errorMessage: 'Generic Error'),
        );
      },
    );
  }

  Future<void> setToDoListInCubitState() async {
    await successfulGetToDoListArrange();
    await cubit.getToDoList();
  }

  setUp(
    () {
      getToDoListUseCase = MockToDoListUseCase();
      updateToDoListUsecase = MockUpdateToDoListUsecase();
      cubit = ToDoListCubit(
        toDoListUseCase: getToDoListUseCase,
        updateToDoListUseCase: updateToDoListUsecase,
      );
    },
  );

  group(
    'ToDoList Cubit',
    () {
      group(
        'Get ToDo List',
        () {
          test(
            'ToDoListState should have a list of ToDo\'s when call to usecase succeed',
            () async {
              await successfulGetToDoListArrange();

              await cubit.getToDoList();

              expect(cubit.state.toDoList, mockToDoEntityList);
              expect(cubit.state.isLoading, false);

              verify(() => getToDoListUseCase()).called(1);
            },
          );

          test(
            'Should have a errorMessage state when calls to getToDoList function goes wrong',
            () async {
              await unSuccessfulGetToDoListCallArrange();

              when(() => getToDoListUseCase()).thenAnswer(
                (_) async {
                  return const Left(
                    GenericFailure(
                      errorMessage: 'Generic error message',
                    ),
                  );
                },
              );

              await cubit.getToDoList();

              expect(cubit.state.errorMessage, isNotEmpty);
              expect(cubit.state.isLoading, false);
            },
          );
        },
      );

      group(
        'Update ToDo List',
        () {
          test(
            'Should correctly add a new To Do item in todoList state',
            () async {
              expect(cubit.state.toDoList, []);

              List<ToDoEntity> newList = [];

              newList.add(mockNewToDoItem);

              when(() => updateToDoListUsecase(newList)).thenAnswer(
                (_) async => const Right(true),
              );

              await cubit.addToDoItemToList(mockNewToDoItem);

              expect(cubit.state.toDoList.length, 1);
              expect(cubit.state.isLoading, false);

              verify(() => updateToDoListUsecase(newList)).called(1);
            },
          );

          test(
            'Should have a errorMessage state when calls to updateList function goes wrong',
            () async {
              List<ToDoEntity> newList = [];

              newList.add(mockNewToDoItem);

              when(() => updateToDoListUsecase(newList)).thenAnswer(
                (_) async {
                  return const Left(
                    GenericFailure(
                      errorMessage: 'Generic error message',
                    ),
                  );
                },
              );

              await cubit.addToDoItemToList(mockNewToDoItem);

              expect(cubit.state.errorMessage, isNotEmpty);
              expect(cubit.state.isLoading, false);
              verify(() => updateToDoListUsecase(newList)).called(1);
            },
          );

          test(
            'Should correctly remove a item from todoList state for a given index',
            () async {
              await setToDoListInCubitState();

              expect(cubit.state.toDoList.length, mockToDoEntityList.length);

              List<ToDoEntity> newList = [];

              newList.addAll(mockToDoEntityList);
              newList.removeAt(0);

              when(() => updateToDoListUsecase(newList)).thenAnswer(
                (_) async => const Right(true),
              );

              await cubit.removeToDoItem(0);

              expect(cubit.state.toDoList.length, newList.length);
              expect(cubit.state.isLoading, false);
              verify(() => updateToDoListUsecase(newList)).called(1);
            },
          );

          test(
            'Should have a errorMessage state when calls to remove function goes wrong',
            () async {
              await setToDoListInCubitState();
              List<ToDoEntity> newList = [];

              newList.addAll(mockToDoEntityList);
              newList.removeAt(0);

              when(() => updateToDoListUsecase(newList)).thenAnswer(
                (_) async {
                  return const Left(
                    GenericFailure(
                      errorMessage: 'Generic error message',
                    ),
                  );
                },
              );

              await cubit.removeToDoItem(0);

              expect(cubit.state.errorMessage, isNotEmpty);
              expect(cubit.state.isLoading, false);
              verify(() => updateToDoListUsecase(newList)).called(1);
            },
          );
        },
      );
    },
  );
}
