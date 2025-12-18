// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Pomodoro App';

  @override
  String get navPomodoro => 'Pomodoro';

  @override
  String get navGoals => 'Objetivos';

  @override
  String get navGym => 'Gym';

  @override
  String get navProfile => 'Perfil';

  @override
  String get tasksTitle => 'Mis Objetivos';

  @override
  String get addTaskTitle => 'Nuevo Objetivo';

  @override
  String get addTaskHint => 'Título del objetivo';

  @override
  String get addTaskDescHint => 'Descripción (opcional)';

  @override
  String get urgencyLabel => 'Urgencia';

  @override
  String get urgencyUrgent => 'Urgente';

  @override
  String get urgencyNormal => 'Normal';

  @override
  String get urgencyCanWait => 'Puede esperar';

  @override
  String get saveButton => 'Guardar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get musicDialogTitle => 'Música de Fondo';

  @override
  String get musicNone => 'Ninguno';

  @override
  String get musicWork => 'Trabajo';

  @override
  String get musicBreak => 'Descanso';

  @override
  String get noTasks => 'No hay tareas';

  @override
  String get tapPlusToAddTask => 'Toca el + para agregar una tarea';

  @override
  String get deleteTaskTitle => 'Eliminar tarea';

  @override
  String deleteTaskConfirm(String taskTitle) {
    return '¿Estás seguro de que quieres eliminar \"$taskTitle\"?';
  }

  @override
  String get clearCompletedTitle => 'Limpiar completadas';

  @override
  String get clearCompletedConfirm => '¿Eliminar todas las tareas completadas?';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get clearButton => 'Limpiar';

  @override
  String get errorEmptyTitle => 'Por favor ingresa un título';

  @override
  String get addTaskSubtitle => 'Define tu próxima meta';

  @override
  String get addTaskExample => 'Ej: Completar proyecto';

  @override
  String get addTaskDescPlaceholder => 'Agrega detalles adicionales...';

  @override
  String get createButton => 'Crear';

  @override
  String get musicNoneDesc => 'Silencio absoluto para mayor concentración.';

  @override
  String get musicNoSounds => 'No hay sonidos disponibles en esta categoría.';

  @override
  String get doneButton => 'Listo';

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get statsPomodoros => 'Pomodoros completados hoy';

  @override
  String get statsCompletedTasks => 'Tareas completadas';

  @override
  String get statsPendingTasks => 'Tareas pendientes';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsNotificationsDesc =>
      'Activar notificaciones al completar pomodoros';

  @override
  String get settingsSound => 'Sonido';

  @override
  String get settingsSoundDesc => 'Reproducir sonido al finalizar timer';

  @override
  String get settingsTheme => 'Tema visual';

  @override
  String get themeSystem => 'Seguir configuración del sistema';

  @override
  String get themeLight => 'Modo claro siempre';

  @override
  String get themeDark => 'Modo oscuro siempre';

  @override
  String get themeSystemShort => 'Sistema';

  @override
  String get themeLightShort => 'Claro';

  @override
  String get themeDarkShort => 'Oscuro';

  @override
  String cyclesToday(int count) {
    return '$count ciclos completados hoy';
  }

  @override
  String get timerConfigTitle => 'Configurar Timer';

  @override
  String get timerCustom => 'Timer Personalizado';

  @override
  String get timerCustomDesc => 'Crear intervalos personalizados';

  @override
  String get focusDisplay => 'focus';

  @override
  String get breakDisplay => 'descanso';

  @override
  String get gymTitle => 'Entrenamiento';

  @override
  String get gymMode => 'Modo Gimnasio';

  @override
  String get comingSoon => 'Próximamente...';

  @override
  String get timerDialogTitle => 'Nuevo Timer';

  @override
  String get timerDialogSubtitle => 'Personaliza tus intervalos de enfoque';

  @override
  String get timerNameLabel => 'Nombre del timer';

  @override
  String get timerNameHint => 'Ej: Trabajo profundo';

  @override
  String get timerFocusLabel => 'Enfoque (min)';

  @override
  String get timerBreakLabel => 'Descanso (min)';
}
