import 'package:to_do_list/core/local_storage/local_storage.dart';
import 'package:to_do_list/core/local_storage/shared_preferences_implementation.dart';
import 'package:to_do_list/core/service_locators/service_locator.dart';
import 'package:to_do_list/features/to_do_list/data/datasources/to_do_datasource.dart';
import 'package:to_do_list/features/to_do_list/data/repositories/to_do_repository_implementation.dart';
import 'package:to_do_list/features/to_do_list/domain/repositories/i_to_do_repository.dart';
import 'package:to_do_list/features/to_do_list/domain/use_cases/get_to_do_list_use_case.dart';
import 'package:to_do_list/features/to_do_list/domain/use_cases/update_to_do_list_use_case.dart';
import 'package:to_do_list/features/to_do_list/presentation/cubits/to_do_list_cubit.dart';

Future<void> setUpToDoListLocators() async {
  getIt.registerFactory<LocalStorage>(
    () => SharedPreferencesImplementation(),
  );

  getIt.registerFactory<IToDoDatasource>(
    () => ToDoDatasource(
      getIt<LocalStorage>(),
    ),
  );

  getIt.registerFactory<IToDoRepository>(
    () => ToDoRepositoryImplementation(
      getIt<IToDoDatasource>(),
    ),
  );

  getIt.registerFactory<GetToDoListUseCase>(
    () => GetToDoListUseCase(
      getIt<IToDoRepository>(),
    ),
  );

  getIt.registerFactory<UpdateToDoListUsecase>(
    () => UpdateToDoListUsecase(
      getIt<IToDoRepository>(),
    ),
  );

  getIt.registerFactory<ToDoListCubit>(
    () => ToDoListCubit(
      toDoListUseCase: getIt<GetToDoListUseCase>(),
      updateToDoListUseCase: getIt<UpdateToDoListUsecase>(),
    ),
  );
}
