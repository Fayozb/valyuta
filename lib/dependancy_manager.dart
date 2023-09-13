import 'package:currency_converter/http_service.dart';

import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUpDependencies() async{
  getIt.registerLazySingleton<HttpService>(() => HttpService());
}

