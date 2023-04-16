import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_squad_premiun/core/constants/constants.dart';
import 'package:to_do_list_squad_premiun/core/local_storage/local_storage.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/data/datasources/to_do_datasource.dart';

import '../../../../mocks/to_do_mocks.dart';

class MockLocalStore extends Mock implements LocalStorage {}

void main() {
  late ToDoDatasource datasource;
  late LocalStorage localStorage;

  setUp(
    () {
      localStorage = MockLocalStore();
      datasource = ToDoDatasource(localStorage);
    },
  );

  test(
    'Should return a List of ToDoModel from the Local Storage',
    () async {
      final Map<String, Object> values = <String, Object>{
        defaultToDoListKey: mockTodoListModel,
      };

      SharedPreferences.setMockInitialValues(values);
      when(() => localStorage.read(key: defaultToDoListKey)).thenAnswer(
        (_) async => mockTodoListModel,
      );

      final result = await datasource.getToDoList();

      expect(result, mockTodoListModel);
    },
  );
  test(
    'Should return true if ToDoList was successful updated from the Local Storage',
    () async {
      when(() => localStorage.write(key: defaultToDoListKey, data: mockTodoListModel)).thenAnswer(
        (_) async => true,
      );

      final result = await datasource.updateToDoList(mockToDoEntityList);

      expect(result, true);
    },
  );
}
