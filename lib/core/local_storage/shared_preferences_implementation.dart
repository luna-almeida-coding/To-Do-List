import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_squad_premiun/core/local_storage/local_storage.dart';
import 'package:to_do_list_squad_premiun/core/service_locators/service_locator.dart';

class SharedPreferencesImplementation implements LocalStorage {
  final SharedPreferences _sharedPreferences = getIt<SharedPreferences>();

  @override
  read({required String key}) async {
    return _sharedPreferences.get(key);
  }

  @override
  Future<bool> write({required String key, data}) async {
    switch (data.runtimeType) {
      case int:
        return await _sharedPreferences.setInt(key, data);
      case bool:
        return await _sharedPreferences.setBool(key, data);
      case double:
        return await _sharedPreferences.setDouble(key, data);
      case String:
        return await _sharedPreferences.setString(key, data);
      case List<String>:
        return await _sharedPreferences.setStringList(key, data);
      default:
        return false;
    }
  }

  @override
  Future<bool> remove({required String key}) async {
    return await _sharedPreferences.remove(key);
  }
}
