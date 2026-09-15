import 'package:get_it/get_it.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/core/service/location_service.dart';
import 'package:hrms_app/core/service/shared_pref_service.dart';
import 'package:hrms_app/feature/provider/login_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<LocationService>(() => LocationService());
  sl.registerLazySingleton<SharedPrefService>(() => SharedPrefService());

  // Providers
  sl.registerFactory(() => LoginProvider(apiService: sl(), prefService: sl()));
}
