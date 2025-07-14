import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:nomix/core/database/repositories/database.dart';

import '../../constants_hive_box.dart';
import 'hive_adapters.dart';

class HiveApp extends Database {
  HiveApp({super.onInitializeCompleted});

  Future<void>? _initializationPending;

  @override
  Future<void> init() async {
    // 1) Если уже инициализируемся — ждём и сразу возвращаемся
    if (_initializationPending != null) {
      return _initializationPending!;
    }

    // 2) Начинаем инициализацию Hive
    _initializationPending = Hive.initFlutter();

    await _initializationPending;

    // 3) Инициализируем базу (базовый Database.init())
    //    Здесь вызывается Session.initialized = true (но завершит completer лишь раз)
    await super.init();

    registerHiveAdapters();

    // 4) Сбрасываем pending, чтобы в будущем можно было снова инициализироваться (если нужно)
    _initializationPending = null;
  }

  void registerHiveAdapters() {
    const adapterTypeId = 1;
    if (!Hive.isAdapterRegistered(adapterTypeId)) {
      print('Регистрирую адаптер MapIntIntAdapter...');
      Hive.registerAdapter<Map<int, int>>(MapIntIntAdapter());
      print('Адаптер MapIntIntAdapter успешно зарегистрирован.');
    }
  }

  void registerAdapter<T>(TypeAdapter<T> adapter) =>
      Hive.registerAdapter<T>(adapter);

  Future<Box<T>> getBox<T>(String name) async {
    await init();
    return Hive.isBoxOpen(name)
        ? Hive.box<T>(name)
        : await Hive.openBox<T>(name);
  }

  Future<LazyBox<T>> getLazyBox<T>(String name) async {
    await init();
    return Hive.isBoxOpen(name)
        ? Hive.lazyBox<T>(name)
        : await Hive.openLazyBox<T>(name);
  }

  @override
  Future<void> close() {
    return Hive.close();
  }

  Future<void> delete() {
    return Hive.deleteFromDisk();
  }

  Future<void> deleteByKey<T>({
    required String boxName,
    required String key,
  }) async {
    final box = await getBox<T>(boxName);
    await box.delete(key);
  }

  ///SAVE_DATA
  Future<void> saveInt({required String key, required int value}) async {
    var box = await getBox<int>(HiveBoxConstants.intBox);
    await box.put(key, value);
  }


  Future<void> saveBool({required String key, required bool value}) async {
    var box = await getBox<bool>(HiveBoxConstants.booleanBox);
    await box.put(key, value);
  }

  Future<void> saveString({required String key, required String value}) async {
    var box = await getBox<String>(HiveBoxConstants.stringBox);
    await box.put(key, value);
  }

  Future<void> saveMapIntInt({
    required String key,
    required Map<int, int> value,
  }) async {
    print('1234234243 $value');
    var box = await getBox<Map<int, int>>(HiveBoxConstants.mapIntIntBox);
    await box.put(key, value);
  }

  Future<void> saveListString(
      {required String key, required List<String> value}) async {
    final listStringBox =
        await Hive.openBox<List<String>>(HiveBoxConstants.listStringBox);
    await listStringBox.put(key, value);
  }

  Future<void> saveListInt(
      {required String key, required List<int> value}) async {
    var box = await getBox<List<int>>(HiveBoxConstants.listIntBox);
    await box.put(key, value);
  }

  ///GET_DATA

  Future<int?> getInt({required String key}) async {
    var box = await getBox<int>(HiveBoxConstants.intBox);
    return box.get(key);
  }

  Future<String?> getString({required String key}) async {
    var box = await getBox<String>(HiveBoxConstants.stringBox);
    return box.get(key);
  }

  Future<bool?> getBool({required String key}) async {
    var box = await getBox<bool>(HiveBoxConstants.booleanBox);
    return box.get(key);
  }

  Future<List<String>?> getListString({required String key}) async {
    var box = await getBox<List<String>>(HiveBoxConstants.listStringBox);
    return box.get(key);
  }

  Future<List<int>?> getListInt({required String key}) async {
    var box = await getBox<List<int>>(HiveBoxConstants.listIntBox);
    return box.get(key);
  }

  Future<Map<int, int>?> getMapIntInt({required String key}) async {
    var box = await getBox(HiveBoxConstants.mapIntIntBox);
    try {
      final rawData = box.get(key);
      box.close();
      return Map<int, int>.from(rawData as Map<dynamic, dynamic>);
    } catch (e) {
      print('Ошибка при чтении данных: $e');
      return null;
    }
  }

  @override
  Future getTypeStore<U>(String holderId) {
    throw UnimplementedError();
  }
}
