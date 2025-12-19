import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/pomodoro_service.dart';
import 'presentation/providers/task_service.dart';
import 'presentation/providers/settings_service.dart';
import 'presentation/providers/music_service.dart';
import 'presentation/providers/notification_service.dart';
import 'presentation/providers/statistics_service.dart';
import 'presentation/providers/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize notifications
  await NotificationService.initialize();

  // Dependency Injection Initialization (includes Database)
  await configureDependencies();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the router instance
    final appRouter = getIt<AppRouter>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<SettingsService>()),
        ChangeNotifierProvider.value(value: getIt<MusicService>()),
        ChangeNotifierProvider.value(value: getIt<TaskService>()),
        ChangeNotifierProvider.value(value: getIt<PomodoroService>()),
        ChangeNotifierProvider.value(value: getIt<StatisticsService>()),
        ChangeNotifierProvider.value(value: getIt<AuthService>()),
      ],
      child: Consumer<SettingsService>(
        builder: (context, settings, child) {
          return MaterialApp.router(
            title: 'Pomodoro App',
            debugShowCheckedModeBanner: false,
            // Use Custom AppTheme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settings.themeMode,

            // Localization
            locale: settings.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

            // GoRouter config
            routerConfig: appRouter.router,
          );
        },
      ),
    );
  }
}
