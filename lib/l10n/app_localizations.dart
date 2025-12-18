import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Pomodoro App'**
  String get appName;

  /// No description provided for @navPomodoro.
  ///
  /// In en, this message translates to:
  /// **'Pomodoro'**
  String get navPomodoro;

  /// No description provided for @navGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get navGoals;

  /// No description provided for @navGym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get navGym;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @tasksTitle.
  ///
  /// In en, this message translates to:
  /// **'My Goals'**
  String get tasksTitle;

  /// No description provided for @addTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'New Goal'**
  String get addTaskTitle;

  /// No description provided for @addTaskHint.
  ///
  /// In en, this message translates to:
  /// **'Goal title'**
  String get addTaskHint;

  /// No description provided for @addTaskDescHint.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get addTaskDescHint;

  /// No description provided for @urgencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Urgency'**
  String get urgencyLabel;

  /// No description provided for @urgencyUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgencyUrgent;

  /// No description provided for @urgencyNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get urgencyNormal;

  /// No description provided for @urgencyCanWait.
  ///
  /// In en, this message translates to:
  /// **'Can wait'**
  String get urgencyCanWait;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @musicDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Background Music'**
  String get musicDialogTitle;

  /// No description provided for @musicNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get musicNone;

  /// No description provided for @musicWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get musicWork;

  /// No description provided for @musicBreak.
  ///
  /// In en, this message translates to:
  /// **'Break'**
  String get musicBreak;

  /// No description provided for @noTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks'**
  String get noTasks;

  /// No description provided for @tapPlusToAddTask.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add a task'**
  String get tapPlusToAddTask;

  /// No description provided for @deleteTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete task'**
  String get deleteTaskTitle;

  /// No description provided for @deleteTaskConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{taskTitle}\"?'**
  String deleteTaskConfirm(String taskTitle);

  /// No description provided for @clearCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear completed'**
  String get clearCompletedTitle;

  /// No description provided for @clearCompletedConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete all completed tasks?'**
  String get clearCompletedConfirm;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @clearButton.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearButton;

  /// No description provided for @errorEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get errorEmptyTitle;

  /// No description provided for @addTaskSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Define your next goal'**
  String get addTaskSubtitle;

  /// No description provided for @addTaskExample.
  ///
  /// In en, this message translates to:
  /// **'Ex: Complete project'**
  String get addTaskExample;

  /// No description provided for @addTaskDescPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Add extra details...'**
  String get addTaskDescPlaceholder;

  /// No description provided for @createButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createButton;

  /// No description provided for @musicNoneDesc.
  ///
  /// In en, this message translates to:
  /// **'Absolute silence for better focus.'**
  String get musicNoneDesc;

  /// No description provided for @musicNoSounds.
  ///
  /// In en, this message translates to:
  /// **'No sounds available in this category.'**
  String get musicNoSounds;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statsTitle;

  /// No description provided for @statsPomodoros.
  ///
  /// In en, this message translates to:
  /// **'Pomodoros completed today'**
  String get statsPomodoros;

  /// No description provided for @statsCompletedTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks completed'**
  String get statsCompletedTasks;

  /// No description provided for @statsPendingTasks.
  ///
  /// In en, this message translates to:
  /// **'Pending tasks'**
  String get statsPendingTasks;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications when pomodoro completes'**
  String get settingsNotificationsDesc;

  /// No description provided for @settingsSound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get settingsSound;

  /// No description provided for @settingsSoundDesc.
  ///
  /// In en, this message translates to:
  /// **'Play sound when timer finishes'**
  String get settingsSoundDesc;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Visual Theme'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system settings'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Always light mode'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Always dark mode'**
  String get themeDark;

  /// No description provided for @themeSystemShort.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystemShort;

  /// No description provided for @themeLightShort.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLightShort;

  /// No description provided for @themeDarkShort.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDarkShort;

  /// No description provided for @cyclesToday.
  ///
  /// In en, this message translates to:
  /// **'{count} cycles completed today'**
  String cyclesToday(int count);

  /// No description provided for @timerConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Configure Timer'**
  String get timerConfigTitle;

  /// No description provided for @timerCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom Timer'**
  String get timerCustom;

  /// No description provided for @timerCustomDesc.
  ///
  /// In en, this message translates to:
  /// **'Create custom intervals'**
  String get timerCustomDesc;

  /// No description provided for @focusDisplay.
  ///
  /// In en, this message translates to:
  /// **'focus'**
  String get focusDisplay;

  /// No description provided for @breakDisplay.
  ///
  /// In en, this message translates to:
  /// **'break'**
  String get breakDisplay;

  /// No description provided for @gymTitle.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get gymTitle;

  /// No description provided for @gymMode.
  ///
  /// In en, this message translates to:
  /// **'Gym Mode'**
  String get gymMode;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon...'**
  String get comingSoon;

  /// No description provided for @timerDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'New Timer'**
  String get timerDialogTitle;

  /// No description provided for @timerDialogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize your focus intervals'**
  String get timerDialogSubtitle;

  /// No description provided for @timerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Timer name'**
  String get timerNameLabel;

  /// No description provided for @timerNameHint.
  ///
  /// In en, this message translates to:
  /// **'Ex: Deep work'**
  String get timerNameHint;

  /// No description provided for @timerFocusLabel.
  ///
  /// In en, this message translates to:
  /// **'Focus (min)'**
  String get timerFocusLabel;

  /// No description provided for @timerBreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Break (min)'**
  String get timerBreakLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
