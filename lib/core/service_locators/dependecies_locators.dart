import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_squad_premiun/core/service_locators/service_locator.dart';

Future<void> setupDependenciesLocator() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
