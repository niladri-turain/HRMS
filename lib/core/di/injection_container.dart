import 'package:get_it/get_it.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/core/service/location_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<LocationService>(() => LocationService());
}
