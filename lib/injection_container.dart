import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/app_customizer/data/datasources/app_local_data_source.dart';
import 'features/app_customizer/data/repositories/app_repository_impl.dart';
import 'features/app_customizer/domain/repositories/app_repository.dart';
import 'features/app_customizer/domain/usecases/create_shortcut.dart';
import 'features/app_customizer/domain/usecases/get_installed_apps.dart';
import 'features/app_customizer/presentation/bloc/apps/apps_bloc.dart';
import 'features/app_customizer/presentation/bloc/shortcut/shortcut_bloc.dart';

import 'features/settings/data/datasources/settings_local_data_source.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/domain/usecases/settings_usecases.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Settings
  // Bloc
  sl.registerFactory(() => SettingsBloc(
        getTheme: sl(),
        setTheme: sl(),
        getLanguage: sl(),
        setLanguage: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetTheme(sl()));
  sl.registerLazySingleton(() => SetTheme(sl()));
  sl.registerLazySingleton(() => GetLanguage(sl()));
  sl.registerLazySingleton(() => SetLanguage(sl()));

  // Repository
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(localDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(sharedPreferences: sl()));

  //! Features - App Customizer
  // Bloc
  sl.registerFactory(() => AppsBloc(getInstalledApps: sl()));
  sl.registerFactory(() => ShortcutBloc(createShortcut: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetInstalledApps(sl()));
  sl.registerLazySingleton(() => CreateShortcut(sl()));

  // Repository
  sl.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(localDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<AppLocalDataSource>(
      () => AppLocalDataSourceImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
