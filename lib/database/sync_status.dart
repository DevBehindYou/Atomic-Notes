import 'package:hive/hive.dart';

class SyncStatusHelper {
  static late Box<bool> syncBox;

  static Future<void> init() async {
    syncBox = await Hive.openBox<bool>('syncBox');
  }

  static bool get isSyncOn =>
      syncBox.get('isSyncOn', defaultValue: true) ?? true;

  static Future<void> setSyncStatus(bool isSyncOn) async {
    await syncBox.put('isSyncOn', isSyncOn);
  }
}
