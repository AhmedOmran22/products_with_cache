import 'package:hive/hive.dart';

class LocalDataBaseService {
  /// Save data in box by name
  Future<void> saveData<T>(String boxName, List<T> data) async {
    final box = await Hive.openBox<T>(boxName);
    await box.clear(); // Clear old data
    await box.addAll(data);
  }

  /// Get data from box by name
  Future<List<T>> getData<T>(String boxName) async {
    final box = await Hive.openBox<T>(boxName);
    final data = box.values.toList();
    return data;
  }

  /// Clear All data from the Box
  Future<void> clearBox(String boxName) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }
}
