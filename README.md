# Pomodoro Timer App

Una aplicación de temporizador Pomodoro con estilo retro-tech, desarrollada en Flutter.

## Características

- ⏱️ **Temporizador Pomodoro** con ciclos de enfoque y descanso
- 🎯 **Configuraciones preestablecidas**: 25/5 (Clásico) y 50/10 (Extendido)
- ⚙️ **Configuración personalizada** para crear tus propios intervalos
- 🎨 **Diseño retro-tech** Tonos simples y minimalistas para enfocarce en la sobriedad y evitar estimulos
- 🔊 **Notificaciones sonoras** y hápticas
- 📊 **Seguimiento de progreso** con contador de pomodoros completados
- 🔄 **Ciclos automáticos** con descansos largos cada 4 pomodoros

## Instalación

1. Asegúrate de tener Flutter instalado en tu sistema
2. Clona este repositorio
3. Ejecuta `flutter pub get` para instalar las dependencias
4. Ejecuta `flutter run` para iniciar la aplicación

## Uso

### Configuraciones Preestablecidas
- **Pomodoro Clásico**: 25 minutos de enfoque / 5 minutos de descanso
- **Enfoque Extendido**: 50 minutos de enfoque / 10 minutos de descanso

### Configuración Personalizada
1. Toca el botón de configuración (⚙️) en la esquina superior derecha
2. Selecciona "CUSTOM TIMER"
3. Configura el nombre, tiempo de enfoque y tiempo de descanso
4. Guarda tu configuración personalizada

### Controles del Temporizador
- **▶️ Play**: Inicia el temporizador
- **⏸️ Pause**: Pausa el temporizador
- **🔄 Reset**: Reinicia el temporizador actual

## Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo móvil
- **Provider**: Gestión de estado
- **AudioPlayers**: Reproducción de sonidos
- **SharedPreferences**: Persistencia de datos

## Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── models/                   # Modelos de datos
│   ├── pomodoro_state.dart   # Estado del temporizador
│   └── timer_config.dart     # Configuración de temporizadores
├── services/                 # Servicios de la aplicación
│   ├── pomodoro_service.dart # Lógica del temporizador
│   └── notification_service.dart # Notificaciones
├── screens/                  # Pantallas de la aplicación
│   └── pomodoro_screen.dart  # Pantalla principal
└── widgets/                  # Widgets reutilizables
    ├── timer_display.dart    # Display del temporizador
    └── custom_timer_dialog.dart # Diálogo de configuración
```

## Características del Diseño



## Contribuir

Las contribuciones son bienvenidas. Por favor, abre un issue o pull request para sugerir mejoras.

## Licencia

Este proyecto está bajo la Licencia MIT.
