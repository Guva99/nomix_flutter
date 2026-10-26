# Nomix — Flutter-клиент

Клиент сервиса учёта личных расходов по фото чеков. Работает как **Telegram Mini App** (Flutter Web) и собирается как мобильное приложение под iOS и Android.

Пользователь фотографирует чек, сервер распознаёт позиции и цены через LLM (Google Gemini), а приложение показывает результат на проверку, сохраняет чек и строит статистику расходов.

Бэкенд: [nomix-backend](https://github.com/Guva99/nomix-backend) (FastAPI, PostgreSQL, Telegram-бот, Gemini).

## Возможности

- Вход через Telegram: данные пользователя берутся из `initData` Mini App и обмениваются на токен сервера.
- Проверка распознанного чека: список позиций, правка названия, количества и цены перед сохранением.
- Главный экран: последние чеки и график расходов.
- Детальная статистика: расходы по категориям и товарам за месяц.
- Нативные ощущения внутри Telegram: haptic feedback через Telegram Web App API.
- Отладочное меню: логи приложения и сетевых запросов (Talker).

## Стек

| Задача | Решение |
|---|---|
| Состояние | flutter_bloc, equatable |
| Навигация | go_router |
| DI | get_it + injectable |
| Сеть | dio, интерсепторы для заголовков и логирования |
| Локальное хранилище | Hive, shared_preferences |
| Кодогенерация | build_runner, injectable_generator |
| Графики и UI | fl_chart, lottie, shimmer, flutter_staggered_animations |
| Логирование | talker, talker_dio_logger |
| Telegram | telegram_web_app, `telegram-web-app.js` в `web/index.html` |

## Архитектура

Feature-first Clean Architecture: каждая фича разделена на слои, зависимости направлены внутрь.

```
lib/
├── core/        # тема, DI, сеть и интерсепторы, Hive, сервис Telegram, общие виджеты
├── features/
│   ├── app/                    # запуск, роутинг, авторизация
│   ├── home_page/              # главный экран и график расходов
│   ├── approve_receipts_page/  # проверка и правка распознанного чека
│   ├── detail_statistic_page/  # статистика по категориям
│   └── debug_menu/             # логи и сетевые запросы
└── main.dart
```

Внутри фичи:

```
feature/
├── data/     # API, сервисы, модели, реализация репозитория
├── domain/   # сущности, интерфейс репозитория, use cases
└── ui/       # страницы, BLoC-состояние, виджеты
```

## Запуск

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
```

## Сборка

```bash
# Telegram Mini App (web)
flutter build web --release
firebase deploy --only hosting

# Android
flutter build apk --release        # тестовая сборка
flutter build appbundle            # для Google Play

# iOS
flutter build ipa
```

Локализация: `flutter pub run intl_utils:generate`.
