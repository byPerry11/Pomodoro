import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import '../../data/datasources/isar_database.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<Isar> get isar async {
    // Ensure initialized or just return the instance if already initialized in main
    // Ideally, we move initialization here or ensuring it's efficient.
    // Given existing code uses IsarDatabase.initialize(), let's reuse it or mimic it.
    // But Isar.open returns the instance.

    // BETTER APPROACH: Let's assume IsarDatabase.initialize() is still called in main for now to keep it simple,
    // OR we move the logic here. Moving logic here is "cleaner" for DI.
    // Let's modify IsarDatabase to just return the instance or use the static one.

    if (!Isar.instanceNames.isNotEmpty) {
      // Simple check or better, just rely on open
      await IsarDatabase.initialize();
    }
    return IsarDatabase.isar;
  }
}
