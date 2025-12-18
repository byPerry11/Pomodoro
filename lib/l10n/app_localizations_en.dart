// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Pomodoro App';

  @override
  String get navPomodoro => 'Pomodoro';

  @override
  String get navGoals => 'Goals';

  @override
  String get navGym => 'Gym';

  @override
  String get navProfile => 'Profile';

  @override
  String get tasksTitle => 'My Goals';

  @override
  String get addTaskTitle => 'New Goal';

  @override
  String get addTaskHint => 'Goal title';

  @override
  String get addTaskDescHint => 'Description (optional)';

  @override
  String get urgencyLabel => 'Urgency';

  @override
  String get urgencyUrgent => 'Urgent';

  @override
  String get urgencyNormal => 'Normal';

  @override
  String get urgencyCanWait => 'Can wait';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get musicDialogTitle => 'Background Music';

  @override
  String get musicNone => 'None';

  @override
  String get musicWork => 'Work';

  @override
  String get musicBreak => 'Break';

  @override
  String get noTasks => 'No tasks';

  @override
  String get tapPlusToAddTask => 'Tap + to add a task';

  @override
  String get deleteTaskTitle => 'Delete task';

  @override
  String deleteTaskConfirm(String taskTitle) {
    return 'Are you sure you want to delete \"$taskTitle\"?';
  }

  @override
  String get clearCompletedTitle => 'Clear completed';

  @override
  String get clearCompletedConfirm => 'Delete all completed tasks?';

  @override
  String get deleteButton => 'Delete';

  @override
  String get clearButton => 'Clear';

  @override
  String get errorEmptyTitle => 'Please enter a title';

  @override
  String get addTaskSubtitle => 'Define your next goal';

  @override
  String get addTaskExample => 'Ex: Complete project';

  @override
  String get addTaskDescPlaceholder => 'Add extra details...';

  @override
  String get createButton => 'Create';

  @override
  String get musicNoneDesc => 'Absolute silence for better focus.';

  @override
  String get musicNoSounds => 'No sounds available in this category.';

  @override
  String get doneButton => 'Done';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get statsPomodoros => 'Pomodoros completed today';

  @override
  String get statsCompletedTasks => 'Tasks completed';

  @override
  String get statsPendingTasks => 'Pending tasks';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsDesc =>
      'Enable notifications when pomodoro completes';

  @override
  String get settingsSound => 'Sound';

  @override
  String get settingsSoundDesc => 'Play sound when timer finishes';

  @override
  String get settingsTheme => 'Visual Theme';

  @override
  String get themeSystem => 'Follow system settings';

  @override
  String get themeLight => 'Always light mode';

  @override
  String get themeDark => 'Always dark mode';

  @override
  String get themeSystemShort => 'System';

  @override
  String get themeLightShort => 'Light';

  @override
  String get themeDarkShort => 'Dark';

  @override
  String cyclesToday(int count) {
    return '$count cycles completed today';
  }

  @override
  String get timerConfigTitle => 'Configure Timer';

  @override
  String get timerCustom => 'Custom Timer';

  @override
  String get timerCustomDesc => 'Create custom intervals';

  @override
  String get focusDisplay => 'focus';

  @override
  String get breakDisplay => 'break';

  @override
  String get gymTitle => 'Training';

  @override
  String get gymMode => 'Gym Mode';

  @override
  String get comingSoon => 'Coming Soon...';

  @override
  String get timerDialogTitle => 'New Timer';

  @override
  String get timerDialogSubtitle => 'Customize your focus intervals';

  @override
  String get timerNameLabel => 'Timer name';

  @override
  String get timerNameHint => 'Ex: Deep work';

  @override
  String get timerFocusLabel => 'Focus (min)';

  @override
  String get timerBreakLabel => 'Break (min)';
}
