import 'dart:async';

import 'package:flutter/foundation.dart';

/// Abstraction with common database functionality
/// [T] is a type of data-holder structure (e.g. table in SQL-like databases)
abstract class Database<T> {
  Database({this.onInitializeCompleted});

  /// Коллбэк, который должен выполниться после первой инициализации
  final VoidCallback? onInitializeCompleted;

  @protected
  final Completer<void> _initializationCompleter = Completer<void>();

  /// Устанавливает, что инициализация завершена.
  /// Будет вызвано лишь единственный раз.
  set initialized(bool value) {
    if (value && !_initializationCompleter.isCompleted) {
      _initializationCompleter.complete();
      onInitializeCompleted?.call();
    }
  }

  /// Признак того, что инициализация уже прошла
  bool get initialized => _initializationCompleter.isCompleted;

  /// Должен вызываться в конце переопределённого [init] в подклассе.
  @mustCallSuper
  Future<void> init() {
    initialized = true;
    return Future.value();
  }

  /// Дождаться завершения инициализации.
  Future<void> get onInitialized => _initializationCompleter.future;

  /// Получить хранилище для типа [U] по идентификатору [holderId]
  Future<T> getTypeStore<U>(String holderId);

  /// Закрыть базу
  Future<void> close();
}