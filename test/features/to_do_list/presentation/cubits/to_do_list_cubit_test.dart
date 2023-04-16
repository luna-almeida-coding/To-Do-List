import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_squad_premiun/core/errors/failures/failure.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/use_cases/get_to_do_list_use_case.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/use_cases/update_to_do_list_use_case_use_case.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/presentation/cubits/to_do_list_cubit.dart';

import '../../../../mocks/to_do_mocks.dart';

class MockToDoListUseCase extends Mock implements GetToDoListUseCase {}

class MockUpdateToDoListUsecase extends Mock implements UpdateToDoListUsecase {}

void main() {
  late ToDoListCubit cubit;
  late GetToDoListUseCase useCase;
  late UpdateToDoListUsecase updateToDoListUsecase;

  Future<void> successfulCallArrange() async {
    when(() => useCase()).thenAnswer(
      (_) async => Right(mockToDoEntityList),
    );
  }

  Future<void> unSuccessfulCallArrange() async {
    when(() => useCase()).thenAnswer(
      (_) async => Left(GenericFailure()),
    );
  }

  setUp(
    () {
      useCase = MockToDoListUseCase();
      updateToDoListUsecase = MockUpdateToDoListUsecase();
      cubit = ToDoListCubit(
        toDoListUseCase: useCase,
        updateToDoListUseCase: updateToDoListUsecase,
      );
    },
  );

  group(
    'ToDoList Cubit',
    () {
      test(
        'ToDoListState should have a list of ToDo\'s when call to usecase succeed',
        () async {
          await successfulCallArrange();
          await cubit.getToDoList();
          expect(cubit.state.toDoList, mockToDoEntityList);
          expect(cubit.state.isLoading, false);
        },
      );

      test(
        'Loading should ended after calls get ToDo list is completed',
        () async {
          await unSuccessfulCallArrange();
          await cubit.getToDoList();
          expect(cubit.state.isLoading, false);
        },
      );

      test(
        'Should correctly add a new To Do item in todoList state',
        () async {
          expect(cubit.state.toDoList, []);

          List<ToDoEntity> newList = [];
          ToDoEntity newItem = const ToDoEntity(description: 'Eat', isCompleted: false);

          newList.add(newItem);

          when(() => updateToDoListUsecase(newList)).thenAnswer(
            (_) async => const Right(true),
          );

          await cubit.updateToDoList(newItem);

          expect(cubit.state.toDoList.length, 1);
          expect(cubit.state.isLoading, false);

          verify(() => updateToDoListUsecase(newList)).called(1);
        },
      );
    },
  );
}
