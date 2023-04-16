import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_squad_premiun/core/errors/failures/failure.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/use_cases/get_to_do_list_use_case.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/presentation/cubits/to_do_list_cubit.dart';

import '../../../../mocks/to_do_mocks.dart';

class MockToDoListUseCase extends Mock implements GetToDoListUseCase {}

void main() {
  late ToDoListCubit cubit;
  late GetToDoListUseCase useCase;

  Future<void> successfulCallArrange() async {
    when(() => useCase()).thenAnswer(
      (_) async => Right(mockToDoEntityList),
    );
    await cubit.getToDoList();
  }

  Future<void> unSuccessfulCallArrange() async {
    when(() => useCase()).thenAnswer(
      (_) async => Left(GenericFailure()),
    );

    await cubit.getToDoList();
  }

  setUp(
    () {
      useCase = MockToDoListUseCase();
      cubit = ToDoListCubit(
        toDoListUseCase: useCase,
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
          expect(cubit.state.toDoList, mockToDoEntityList);
        },
      );

      test(
        'Loading should ended after calls get ToDo list is completed',
        () async {
          await successfulCallArrange();
          expect(cubit.state.isLoading, false);

          await unSuccessfulCallArrange();
          expect(cubit.state.isLoading, false);
        },
      );
    },
  );
}
