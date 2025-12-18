class TimerConfig {
  final int focusMinutes;
  final int breakMinutes;
  final String name;

  const TimerConfig({
    required this.focusMinutes,
    required this.breakMinutes,
    required this.name,
  });

  static const List<TimerConfig> presets = [
    TimerConfig(
      focusMinutes: 25,
      breakMinutes: 5,
      name: 'Classic Pomodoro',
    ),
    TimerConfig(
      focusMinutes: 50,
      breakMinutes: 10,
      name: 'Extended Focus',
    ),
  ];

  @override
  String toString() {
    return '$name ($focusMinutes/$breakMinutes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimerConfig &&
        other.focusMinutes == focusMinutes &&
        other.breakMinutes == breakMinutes &&
        other.name == name;
  }

  @override
  int get hashCode {
    return focusMinutes.hashCode ^ breakMinutes.hashCode ^ name.hashCode;
  }

  Map<String, dynamic> toJson() {
    return {
      'focusMinutes': focusMinutes,
      'breakMinutes': breakMinutes,
      'name': name,
    };
  }

  factory TimerConfig.fromJson(Map<String, dynamic> json) {
    return TimerConfig(
      focusMinutes: json['focusMinutes'],
      breakMinutes: json['breakMinutes'],
      name: json['name'],
    );
  }
}
