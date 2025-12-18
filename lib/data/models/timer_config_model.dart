import 'package:isar/isar.dart';

part 'timer_config_model.g.dart';

@collection
class TimerConfigModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String name;

  int focusMinutes = 25;

  int breakMinutes = 5;

  bool isCustom = false;
}
