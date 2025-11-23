# Отладка: Почему не попадаю на страницу верификации?

## Проверка 1: Используете ли вы моки?

### Вариант А: Через main_mock.dart
1. Убедитесь, что запускаете приложение через `main_mock.dart`
2. В файле `main_mock.dart` должно быть:
```dart
child: const AppMock(
  // mockVerificationStatus не указан - это правильно для первого входа
),
```

### Вариант Б: Через main.dart с моками
1. Откройте `app/lib/main.dart`
2. Измените импорт:
```dart
// Было:
import 'package:app/app/view/app_view.dart';

// Стало:
import 'package:app/app/view/app_view_mock.dart';
```

3. Измените `App()` на `AppMock()`:
```dart
// Было:
child: const App(),

// Стало:
child: const AppMock(
  // mockVerificationStatus не указывайте для первого входа
),
```

## Проверка 2: Роль пользователя

Убедитесь, что вы авторизованы как **PARTNER**, а не CLIENT.

В логах должно быть видно, какая роль у пользователя.

## Проверка 3: Логи в консоли

При запуске приложения с моками вы должны увидеть в консоли:
- `🔍 Partner verification status: ...`
- `➡️ Redirecting to verification page` или
- `❌ Error checking verification status: ...`

Если этих логов нет - возможно, страница PartnerHomeView не загружается.

## Проверка 4: Прямой переход на страницу верификации

Попробуйте открыть URL напрямую в браузере (если веб) или добавить кнопку для перехода:
```dart
context.go('/partner/partner-verification');
```

## Быстрое решение

Если ничего не помогает, добавьте в `main.dart` временно прямой переход:

```dart
// В main.dart замените App() на:
child: Builder(
  builder: (context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AuthCubit>().state.user?.role == RoleEnum.PARTNER) {
        context.go('/partner/partner-verification');
      }
    });
    return const App();
  },
),
```

Это принудительно перенаправит партнера на страницу верификации при запуске.

