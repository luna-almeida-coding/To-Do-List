import 'package:get_it/get_it.dart';
import 'package:to_do_list/core/service_locators/dependecies_locators.dart';
import 'package:to_do_list/core/service_locators/to_do_list_locator.dart';

GetIt getIt = GetIt.I;

Future<void> setupLocators() async {
  await setupDependenciesLocator();
  await setUpToDoListLocators();
}
