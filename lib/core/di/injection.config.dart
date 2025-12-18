// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i4;

import '../../data/repositories/pomodoro_repository_impl.dart' as _i7;
import '../../data/repositories/settings_repository_impl.dart' as _i10;
import '../../data/repositories/task_repository_impl.dart' as _i12;
import '../../domain/repositories/pomodoro_repository.dart' as _i6;
import '../../domain/repositories/settings_repository.dart' as _i9;
import '../../domain/repositories/task_repository.dart' as _i11;
import '../../domain/usecases/pomodoro_usecases.dart' as _i8;
import '../../domain/usecases/settings_usecases.dart' as _i14;
import '../../domain/usecases/task_usecases.dart' as _i13;
import '../../presentation/providers/music_service.dart' as _i5;
import '../../presentation/providers/pomodoro_service.dart' as _i17;
import '../../presentation/providers/settings_service.dart' as _i15;
import '../../presentation/providers/task_service.dart' as _i16;
import '../router/app_router.dart' as _i3;
import 'register_module.dart' as _i18;

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
    await gh.factoryAsync<_i4.Isar>(
      () => registerModule.isar,
      preResolve: true,
    );
    gh.lazySingleton<_i5.MusicService>(() => _i5.MusicService());
    gh.lazySingleton<_i6.PomodoroRepository>(
        () => _i7.PomodoroRepositoryImpl(gh<_i4.Isar>()));
    gh.factory<_i8.SaveTimerConfig>(
        () => _i8.SaveTimerConfig(gh<_i6.PomodoroRepository>()));
    gh.lazySingleton<_i9.SettingsRepository>(
        () => _i10.SettingsRepositoryImpl(gh<_i4.Isar>()));
    gh.lazySingleton<_i11.TaskRepository>(
        () => _i12.TaskRepositoryImpl(gh<_i4.Isar>()));
    gh.factory<_i13.UpdateTask>(
        () => _i13.UpdateTask(gh<_i11.TaskRepository>()));
    gh.factory<_i13.AddTask>(() => _i13.AddTask(gh<_i11.TaskRepository>()));
    gh.factory<_i13.DeleteTask>(
        () => _i13.DeleteTask(gh<_i11.TaskRepository>()));
    gh.factory<_i8.DeleteTimerConfig>(
        () => _i8.DeleteTimerConfig(gh<_i6.PomodoroRepository>()));
    gh.factory<_i8.GetCustomTimerConfigs>(
        () => _i8.GetCustomTimerConfigs(gh<_i6.PomodoroRepository>()));
    gh.factory<_i14.GetDarkMode>(
        () => _i14.GetDarkMode(gh<_i9.SettingsRepository>()));
    gh.factory<_i14.GetNotificationsEnabled>(
        () => _i14.GetNotificationsEnabled(gh<_i9.SettingsRepository>()));
    gh.factory<_i14.GetSoundEnabled>(
        () => _i14.GetSoundEnabled(gh<_i9.SettingsRepository>()));
    gh.factory<_i13.GetTasks>(() => _i13.GetTasks(gh<_i11.TaskRepository>()));
    gh.factory<_i14.SetDarkMode>(
        () => _i14.SetDarkMode(gh<_i9.SettingsRepository>()));
    gh.factory<_i14.SetNotificationsEnabled>(
        () => _i14.SetNotificationsEnabled(gh<_i9.SettingsRepository>()));
    gh.factory<_i14.SetSoundEnabled>(
        () => _i14.SetSoundEnabled(gh<_i9.SettingsRepository>()));
    gh.lazySingleton<_i15.SettingsService>(() => _i15.SettingsService(
          gh<_i14.GetNotificationsEnabled>(),
          gh<_i14.SetNotificationsEnabled>(),
          gh<_i14.GetSoundEnabled>(),
          gh<_i14.SetSoundEnabled>(),
          gh<_i14.GetDarkMode>(),
          gh<_i14.SetDarkMode>(),
        ));
    gh.lazySingleton<_i16.TaskService>(() => _i16.TaskService(
          gh<_i13.GetTasks>(),
          gh<_i13.AddTask>(),
          gh<_i13.UpdateTask>(),
          gh<_i13.DeleteTask>(),
        ));
    gh.lazySingleton<_i17.PomodoroService>(() => _i17.PomodoroService(
          gh<_i8.GetCustomTimerConfigs>(),
          gh<_i8.SaveTimerConfig>(),
          gh<_i8.DeleteTimerConfig>(),
          gh<_i15.SettingsService>(),
          gh<_i5.MusicService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i18.RegisterModule {}
