import 'package:get_it/get_it.dart';
import 'package:to_do_list_squad_premiun/core/service_locators/dependecies_locators.dart';

GetIt getIt = GetIt.I;

Future<void> setupLocators() async {
  await setupDependenciesLocator();
}
