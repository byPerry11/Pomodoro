// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i5;

import '../../data/repositories/pomodoro_repository_impl.dart' as _i8;
import '../../data/repositories/settings_repository_impl.dart' as _i11;
import '../../data/repositories/statistics_repository_impl.dart' as _i13;
import '../../data/repositories/task_repository_impl.dart' as _i15;
import '../../domain/repositories/pomodoro_repository.dart' as _i7;
import '../../domain/repositories/settings_repository.dart' as _i10;
import '../../domain/repositories/statistics_repository.dart' as _i12;
import '../../domain/repositories/task_repository.dart' as _i14;
import '../../domain/usecases/pomodoro_usecases.dart' as _i9;
import '../../domain/usecases/settings_usecases.dart' as _i17;
import '../../domain/usecases/statistics_usecases.dart' as _i19;
import '../../domain/usecases/task_usecases.dart' as _i16;
import '../../domain/usecases/user_usecases.dart' as _i18;
import '../../presentation/providers/auth_service.dart' as _i4;
import '../../presentation/providers/music_service.dart' as _i6;
import '../../presentation/providers/pomodoro_service.dart' as _i23;
import '../../presentation/providers/settings_service.dart' as _i20;
import '../../presentation/providers/statistics_service.dart' as _i21;
import '../../presentation/providers/task_service.dart' as _i22;
import '../router/app_router.dart' as _i3;
import 'register_module.dart' as _i24;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.AppRouter>(() => _i3.AppRouter());
    gh.lazySingleton<_i4.AuthService>(() => _i4.AuthService());
    await gh.factoryAsync<_i5.Isar>(
      () => registerModule.isar,
      preResolve: true,
    );
    gh.lazySingleton<_i6.MusicService>(() => _i6.MusicService());
    gh.lazySingleton<_i7.PomodoroRepository>(
        () => _i8.PomodoroRepositoryImpl(gh<_i5.Isar>()));
    gh.factory<_i9.SaveTimerConfig>(
        () => _i9.SaveTimerConfig(gh<_i7.PomodoroRepository>()));
    gh.lazySingleton<_i10.SettingsRepository>(
        () => _i11.SettingsRepositoryImpl(gh<_i5.Isar>()));
    gh.lazySingleton<_i12.StatisticsRepository>(
        () => _i13.StatisticsRepositoryImpl(gh<_i5.Isar>()));
    gh.lazySingleton<_i14.TaskRepository>(
        () => _i15.TaskRepositoryImpl(gh<_i5.Isar>()));
    gh.factory<_i16.UpdateTask>(
        () => _i16.UpdateTask(gh<_i14.TaskRepository>()));
    gh.factory<_i16.AddTask>(() => _i16.AddTask(gh<_i14.TaskRepository>()));
    gh.factory<_i16.DeleteTask>(
        () => _i16.DeleteTask(gh<_i14.TaskRepository>()));
    gh.factory<_i9.DeleteTimerConfig>(
        () => _i9.DeleteTimerConfig(gh<_i7.PomodoroRepository>()));
    gh.factory<_i9.GetCustomTimerConfigs>(
        () => _i9.GetCustomTimerConfigs(gh<_i7.PomodoroRepository>()));
    gh.factory<_i17.GetDarkMode>(
        () => _i17.GetDarkMode(gh<_i10.SettingsRepository>()));
    gh.factory<_i17.GetLocale>(
        () => _i17.GetLocale(gh<_i10.SettingsRepository>()));
    gh.factory<_i17.GetNotificationsEnabled>(
        () => _i17.GetNotificationsEnabled(gh<_i10.SettingsRepository>()));
    gh.factory<_i17.GetSoundEnabled>(
        () => _i17.GetSoundEnabled(gh<_i10.SettingsRepository>()));
    gh.factory<_i16.GetTasks>(() => _i16.GetTasks(gh<_i14.TaskRepository>()));
    gh.factory<_i18.GetUserName>(
        () => _i18.GetUserName(gh<_i10.SettingsRepository>()));
    gh.factory<_i19.GetWeeklyStats>(
        () => _i19.GetWeeklyStats(gh<_i12.StatisticsRepository>()));
    gh.factory<_i19.SaveSession>(
        () => _i19.SaveSession(gh<_i12.StatisticsRepository>()));
    gh.factory<_i17.SetDarkMode>(
        () => _i17.SetDarkMode(gh<_i10.SettingsRepository>()));
    gh.factory<_i17.SetLocale>(
        () => _i17.SetLocale(gh<_i10.SettingsRepository>()));
    gh.factory<_i17.SetNotificationsEnabled>(
        () => _i17.SetNotificationsEnabled(gh<_i10.SettingsRepository>()));
    gh.factory<_i17.SetSoundEnabled>(
        () => _i17.SetSoundEnabled(gh<_i10.SettingsRepository>()));
    gh.factory<_i18.SetUserName>(
        () => _i18.SetUserName(gh<_i10.SettingsRepository>()));
    gh.lazySingleton<_i20.SettingsService>(() => _i20.SettingsService(
          gh<_i17.GetNotificationsEnabled>(),
          gh<_i17.SetNotificationsEnabled>(),
          gh<_i17.GetSoundEnabled>(),
          gh<_i17.SetSoundEnabled>(),
          gh<_i17.GetDarkMode>(),
          gh<_i17.SetDarkMode>(),
          gh<_i17.GetLocale>(),
          gh<_i17.SetLocale>(),
          gh<_i18.GetUserName>(),
          gh<_i18.SetUserName>(),
        ));
    gh.factory<_i21.StatisticsService>(
        () => _i21.StatisticsService(gh<_i19.GetWeeklyStats>()));
    gh.lazySingleton<_i22.TaskService>(() => _i22.TaskService(
          gh<_i16.GetTasks>(),
          gh<_i16.AddTask>(),
          gh<_i16.UpdateTask>(),
          gh<_i16.DeleteTask>(),
        ));
    gh.lazySingleton<_i23.PomodoroService>(() => _i23.PomodoroService(
          gh<_i9.GetCustomTimerConfigs>(),
          gh<_i9.SaveTimerConfig>(),
          gh<_i9.DeleteTimerConfig>(),
          gh<_i19.SaveSession>(),
          gh<_i20.SettingsService>(),
          gh<_i6.MusicService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i24.RegisterModule {}
