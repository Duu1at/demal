# Предложение по архитектуре разделения фич Partner и Client

## 🎯 Принципы разделения

### 1. **Feature-First подход**
Каждая фича (feature) должна быть самодостаточной и изолированной. Это позволяет:
- Легко находить код, связанный с конкретной функциональностью
- Упростить тестирование
- Упростить поддержку и развитие

### 2. **Разделение по ролям (Role-Based Features)**
Фичи должны быть четко разделены по ролям пользователя:
- `features/client/` - все фичи для клиентов
- `features/partner/` - все фичи для партнеров
- `shared/` - общие фичи (auth, onboarding)

### 3. **Структура модуля фичи**
Каждая фича должна иметь следующую структуру:
```
feature_name/
  ├── data/          # Локальные модели, если нужны
  ├── domain/        # Бизнес-логика (BLoC/Cubit)
  ├── presentation/  # UI (views, widgets)
  │   ├── views/
  │   └── widgets/
  └── feature_name.dart  # Barrel файл для экспорта
```

## 📁 Предлагаемая структура

```
lib/
├── features/
│   ├── client/              # Фичи для клиентов
│   │   ├── home/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   │   └── blocs/
│   │   │   │       ├── tours/
│   │   │   │       └── tours_detail/
│   │   │   ├── presentation/
│   │   │   │   ├── views/
│   │   │   │   │   └── client_home_view.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── tours_list/
│   │   │   │       └── tours_search/
│   │   │   └── client_home.dart
│   │   ├── tours/
│   │   │   ├── detail/
│   │   │   ├── filters/
│   │   │   └── tours.dart
│   │   ├── bookings/
│   │   │   ├── details/
│   │   │   ├── status/
│   │   │   └── bookings.dart
│   │   ├── tickets/
│   │   │   └── tickets.dart
│   │   └── settings/        # Настройки специфичные для клиента
│   │       └── settings.dart
│   │
│   ├── partner/             # Фичи для партнеров
│   │   ├── home/
│   │   │   ├── domain/
│   │   │   │   └── blocs/
│   │   │   │       └── partner_tours/
│   │   │   ├── presentation/
│   │   │   │   ├── views/
│   │   │   │   │   └── partner_home_view.dart
│   │   │   │   └── widgets/
│   │   │   │       └── partner_tours_list/
│   │   │   └── partner_home.dart
│   │   ├── tours/
│   │   │   ├── create/
│   │   │   ├── edit/
│   │   │   └── tours.dart
│   │   └── settings/        # Настройки специфичные для партнера
│   │       └── settings.dart
│   │
│   └── shared/              # Общие фичи
│       ├── auth/
│       │   ├── login/
│       │   ├── otp/
│       │   └── auth.dart
│       ├── onboarding/
│       │   └── onboarding.dart
│       └── settings/        # Общие настройки (если есть)
│           └── settings.dart
│
├── app/                     # Ядро приложения
│   ├── router/
│   │   └── app_router.dart
│   ├── cubits/
│   │   ├── auth_cubit/
│   │   ├── app_locale_cubit/
│   │   └── app_theme_cubit/
│   ├── mixin/
│   ├── view/
│   │   ├── app_view.dart
│   │   └── splash_view.dart
│   └── app.dart
│
├── widgets/                 # Переиспользуемые виджеты (не привязанные к фичам)
│   ├── avatar_widget.dart
│   ├── locale_settings_sheet.dart
│   └── theme_settings_sheet.dart
│
├── utils/                   # Утилиты
│   ├── extensions/
│   ├── formatter/
│   ├── validators/
│   └── utils.dart
│
└── main.dart
```

## 🔄 План миграции

### Этап 1: Создание новой структуры
1. Создать директории `features/client/`, `features/partner/`, `features/shared/`
2. Переместить существующие фичи в новые директории

### Этап 2: Рефакторинг Settings
- Разделить общие настройки и специфичные для роли
- Общие: тема, язык, о приложении, выход
- Специфичные для клиента: билеты
- Специфичные для партнера: профиль партнера

### Этап 3: Обновление роутинга
- Организовать роуты по фичам
- Использовать feature-based routing

## ✅ Преимущества предлагаемой архитектуры

1. **Четкое разделение ответственности** - каждая фича изолирована
2. **Легкая навигация** - быстро находишь нужный код
3. **Масштабируемость** - легко добавлять новые фичи
4. **Тестируемость** - фичи можно тестировать независимо
5. **Поддержка** - изменения в одной фиче не влияют на другие
6. **Командная работа** - разные разработчики могут работать над разными фичами

## 📝 Пример организации фичи

```dart
// features/client/tours/tours.dart (barrel файл)
export 'detail/client_tour_details_view.dart';
export 'filters/client_tour_filters_view.dart';

// features/client/tours/detail/
export 'client_tour_details_view.dart';
export 'widgets/tour_description_section.dart';
export 'widgets/tour_header_section.dart';
// ... и т.д.
```

## 🚨 Важные замечания

1. **Общие виджеты** - если виджет используется в разных фичах, он должен быть в `widgets/` или в shared пакете
2. **BLoC/Cubit** - должен быть в `domain/blocs/` или `domain/cubits/`
3. **Роутинг** - все роуты фичи должны быть определены в одном месте
4. **Barrel файлы** - использовать для удобного импорта из фичи

