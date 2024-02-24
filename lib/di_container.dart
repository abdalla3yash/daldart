import 'package:deldart/core/services/firebase/firebase_service.dart';
import 'package:deldart/features/home/cubit/home_cubit.dart';
import 'package:deldart/features/home/repositories/home_repositories.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/services/network/api_client.dart';
import 'core/services/network/network_info.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // external

  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());
  sl.registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo(sl<Connectivity>()));
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>(), sl<PrettyDioLogger>()));

  // Repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepository(sl<ApiClient>(), sl<NetworkInfo>()));

  // Cubits
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<HomeRepository>(),sl<FirebaseService>()));
}
