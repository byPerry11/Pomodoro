import 'package:injectable/injectable.dart';
import '../repositories/settings_repository.dart';

@injectable
class GetUserName {
  final SettingsRepository repository;
  GetUserName(this.repository);
  Future<String?> call() => repository.getUserName();
}

@injectable
class SetUserName {
  final SettingsRepository repository;
  SetUserName(this.repository);
  Future<void> call(String? name) => repository.setUserName(name);
}
