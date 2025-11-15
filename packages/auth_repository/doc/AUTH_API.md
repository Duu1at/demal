# Authentication API Documentation

Полная документация по API для авторизации через OTP (One-Time Password).

**Base URL:** `/api/v1/auth`

**Авторизация:** Не требуется (Public endpoints)

---

## 1. Отправить OTP код

**Endpoint:** `POST /api/v1/auth/send-otp`

**Требования:**
- Авторизация: Не требуется
- Метод: POST

### 📋 Модель данных запроса

**Тело запроса (JSON):**
```json
{
  "phone_number": "+996555123456"
}
```

**Параметры:**

| Параметр | Тип | Обязательный | Описание | Формат | Пример |
|----------|-----|--------------|----------|--------|--------|
| `phone_number` | string | ✅ Да | Номер телефона | `+996XXXXXXXXX` (9 цифр после +996) | `+996555123456` |

**Валидация:**
- `phone_number` должен быть строкой
- Формат: `+996` + 9 цифр (всего 13 символов)
- Примеры валидных номеров: `+996555123456`, `+996700123456`
- Примеры невалидных номеров: `996555123456`, `+99655512345`, `+9965551234567`

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "message": "Код отправлен на номер +996555123456",
  "expires_in": 300
}
```

**Описание полей ответа:**

| Поле | Тип | Описание |
|------|-----|-----------|
| `success` | boolean | Успешность операции (всегда `true`) |
| `message` | string | Сообщение об отправке кода |
| `expires_in` | number | Время жизни кода в секундах (300 = 5 минут) |

**Примечание:** 
- OTP код действителен в течение 5 минут
- Код состоит из 4 цифр
- После отправки код сохраняется в базе данных и может быть использован только один раз

### ❌ Ошибки

#### 400 Bad Request - Неверный формат номера телефона

**Сценарий:** Номер телефона не соответствует формату `+996XXXXXXXXX`

```json
{
  "success": false,
  "error": "Bad Request",
  "message": "Phone number must be in format +996XXXXXXXXX",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/auth/send-otp"
}
```

**Возможные причины:**
- Отсутствует префикс `+996`
- Неправильное количество цифр (не 9 после +996)
- Содержит нецифровые символы
- Пустое значение

**Примеры невалидных запросов:**
```json
// Неправильный формат
{
  "phone_number": "996555123456"  // Отсутствует +
}

// Неправильное количество цифр
{
  "phone_number": "+99655512345"  // Только 8 цифр
}

// Пустое значение
{
  "phone_number": ""
}
```

#### 400 Bad Request - Отсутствует обязательное поле

**Сценарий:** Поле `phone_number` не передано

```json
{
  "success": false,
  "error": "Bad Request",
  "message": "phone_number should not be empty",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/auth/send-otp"
}
```

---

## 2. Верификация OTP кода

**Endpoint:** `POST /api/v1/auth/verify-otp`

**Требования:**
- Авторизация: Не требуется
- Метод: POST
- Заголовок: `x-app-role` (обязательный)

### 📋 Модель данных запроса

**Заголовки (Headers):**

| Заголовок | Тип | Обязательный | Описание | Возможные значения |
|-----------|-----|--------------|----------|-------------------|
| `x-app-role` | string | ✅ Да | Роль пользователя | `CLIENT`, `PARTNER`, `ADMIN` |

**Тело запроса (JSON):**
```json
{
  "phone_number": "+996555123456",
  "otp_code": "1234"
}
```

**Параметры:**

| Параметр | Тип | Обязательный | Описание | Формат | Пример |
|----------|-----|--------------|----------|--------|--------|
| `phone_number` | string | ✅ Да | Номер телефона | `+996XXXXXXXXX` | `+996555123456` |
| `otp_code` | string | ✅ Да | 4-значный OTP код | Ровно 4 цифры | `1234` |

**Валидация:**
- `phone_number` должен быть строкой в формате `+996XXXXXXXXX`
- `otp_code` должен быть строкой из ровно 4 цифр
- `x-app-role` должен быть одним из: `CLIENT`, `PARTNER`, `ADMIN`

### ✅ Успешный ответ (200 OK)

**Для существующего пользователя:**
```json
{
  "success": true,
  "auth_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1NTBlODQwMC1lMjliLTQxZDQtYTcxNi00NDY2NTU0NDAwMDAiLCJwaG9uZU51bWJlciI6Iis5OTY1NTUxMjM0NTYiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNjE4MDAwMDAwLCJleHAiOjE2MTg1OTUyMDB9.example",
  "is_new_user": false,
  "user": {
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "phone_number": "+996555123456",
    "full_name": "Иван Петров",
    "role": "CLIENT",
    "image_url": "https://example.com/avatar.jpg",
    "created_at": "2024-01-01T00:00:00.000Z"
  }
}
```

**Для нового пользователя:**
```json
{
  "success": true,
  "auth_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1NTBlODQwMC1lMjliLTQxZDQtYTcxNi00NDY2NTU0NDAwMDAiLCJwaG9uZU51bWJlciI6Iis5OTY1NTUxMjM0NTYiLCJyb2xlIjoiQ0xJRU5UIiwiaWF0IjoxNjE4MDAwMDAwLCJleHAiOjE2MTg1OTUyMDB9.example",
  "is_new_user": true,
  "user": {
    "user_id": "550e8400-e29b-41d4-a716-446655440001",
    "phone_number": "+996555123456",
    "full_name": null,
    "role": "CLIENT",
    "image_url": null,
    "created_at": "2024-01-01T00:00:00.000Z"
  }
}
```

**Описание полей ответа:**

| Поле | Тип | Описание |
|------|-----|-----------|
| `success` | boolean | Успешность операции (всегда `true`) |
| `auth_token` | string | JWT токен для авторизации в последующих запросах |
| `is_new_user` | boolean | `true` - новый пользователь, `false` - существующий |
| `user` | object | Данные пользователя |
| `user.user_id` | string | UUID пользователя |
| `user.phone_number` | string | Номер телефона |
| `user.full_name` | string \| null | Полное имя (может быть `null`) |
| `user.role` | string | Роль пользователя (`CLIENT`, `PARTNER`, `ADMIN`) |
| `user.image_url` | string \| null | URL аватара (может быть `null`) |
| `user.created_at` | string | Дата создания (ISO datetime) |

**Примечания:**
- После успешной верификации OTP код удаляется из базы данных и не может быть использован повторно
- Если пользователь не существует, он будет автоматически создан
- Роль пользователя устанавливается из заголовка `x-app-role`
- JWT токен содержит: `sub` (user_id), `phoneNumber`, `role`

### ❌ Ошибки

#### 400 Bad Request - Неверный OTP код

**Сценарий:** OTP код неверный, истек или уже использован

```json
{
  "success": false,
  "error": "INVALID_OTP",
  "message": "Неверный код подтверждения",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/auth/verify-otp"
}
```

**Возможные причины:**
- Неверный код (не совпадает с отправленным)
- Код истек (прошло более 5 минут)
- Код уже использован (одноразовый)
- Код не был отправлен для данного номера

**Примеры невалидных запросов:**
```json
// Неверный код
{
  "phone_number": "+996555123456",
  "otp_code": "9999"  // Неправильный код
}

// Истекший код (прошло более 5 минут)
{
  "phone_number": "+996555123456",
  "otp_code": "1234"  // Код был отправлен 6 минут назад
}
```

#### 400 Bad Request - Неверный формат номера телефона

**Сценарий:** Номер телефона не соответствует формату

```json
{
  "success": false,
  "error": "Bad Request",
  "message": "Phone number must be in format +996XXXXXXXXX",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/auth/verify-otp"
}
```

#### 400 Bad Request - Неверный формат OTP кода

**Сценарий:** OTP код не состоит из 4 цифр

```json
{
  "success": false,
  "error": "Bad Request",
  "message": "OTP code must be 4 digits",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/auth/verify-otp"
}
```

**Примеры невалидных кодов:**
- `"123"` - только 3 цифры
- `"12345"` - 5 цифр
- `"abcd"` - не цифры
- `""` - пустая строка

#### 400 Bad Request - Отсутствует обязательное поле

**Сценарий:** Не передано обязательное поле

```json
{
  "success": false,
  "error": "Bad Request",
  "message": "phone_number should not be empty",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/auth/verify-otp"
}
```

Или:

```json
{
  "success": false,
  "error": "Bad Request",
  "message": "otp_code should not be empty",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/auth/verify-otp"
}
```

#### 400 Bad Request - Отсутствует заголовок x-app-role

**Сценарий:** Заголовок `x-app-role` не передан или имеет неверное значение

```json
{
  "success": false,
  "error": "Bad Request",
  "message": "x-app-role header is required",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/auth/verify-otp"
}
```

**Правильные значения заголовка:**
- `x-app-role: CLIENT`
- `x-app-role: PARTNER`
- `x-app-role: ADMIN`

---

## Структуры данных

### SendOtpRequest (Запрос отправки OTP)

```typescript
{
  phone_number: string;  // Обязательный, формат: +996XXXXXXXXX
}
```

### SendOtpResponse (Ответ отправки OTP)

```typescript
{
  success: boolean;      // Всегда true
  message: string;       // Сообщение об отправке
  expires_in: number;   // Время жизни в секундах (300)
}
```

### VerifyOtpRequest (Запрос верификации OTP)

```typescript
{
  phone_number: string;  // Обязательный, формат: +996XXXXXXXXX
  otp_code: string;      // Обязательный, ровно 4 цифры
}
```

**Заголовки:**
```typescript
{
  'x-app-role': 'CLIENT' | 'PARTNER' | 'ADMIN';  // Обязательный
}
```

### VerifyOtpResponse (Ответ верификации OTP)

```typescript
{
  success: boolean;      // Всегда true
  auth_token: string;   // JWT токен
  is_new_user: boolean; // true - новый пользователь
  user: User;           // Данные пользователя
}
```

### User (Пользователь)

```typescript
{
  user_id: string;                    // UUID
  phone_number: string;              // Номер телефона
  full_name: string | null;           // Полное имя
  role: 'CLIENT' | 'PARTNER' | 'ADMIN';  // Роль
  image_url: string | null;           // URL аватара
  created_at: string;                 // ISO datetime
}
```

### ErrorResponse (Ошибка)

```typescript
{
  success: false;
  error: string;        // Тип ошибки
  message: string;      // Сообщение об ошибке
  timestamp: string;    // ISO datetime
  path: string;         // Путь запроса
}
```

---

## Сценарии использования

### Сценарий 1: Успешная авторизация нового пользователя

1. **Отправка OTP:**
   ```bash
   POST /api/v1/auth/send-otp
   {
     "phone_number": "+996555123456"
   }
   ```
   Ответ: `200 OK` с сообщением об отправке

2. **Верификация OTP:**
   ```bash
   POST /api/v1/auth/verify-otp
   Headers: x-app-role: CLIENT
   {
     "phone_number": "+996555123456",
     "otp_code": "1234"
   }
   ```
   Ответ: `200 OK` с `is_new_user: true` и JWT токеном

### Сценарий 2: Успешная авторизация существующего пользователя

1. **Отправка OTP:**
   ```bash
   POST /api/v1/auth/send-otp
   {
     "phone_number": "+996555123456"
   }
   ```

2. **Верификация OTP:**
   ```bash
   POST /api/v1/auth/verify-otp
   Headers: x-app-role: CLIENT
   {
     "phone_number": "+996555123456",
     "otp_code": "1234"
   }
   ```
   Ответ: `200 OK` с `is_new_user: false` и JWT токеном

### Сценарий 3: Неверный OTP код

1. **Отправка OTP:**
   ```bash
   POST /api/v1/auth/send-otp
   {
     "phone_number": "+996555123456"
   }
   ```

2. **Верификация с неверным кодом:**
   ```bash
   POST /api/v1/auth/verify-otp
   Headers: x-app-role: CLIENT
   {
     "phone_number": "+996555123456",
     "otp_code": "9999"  // Неверный код
   }
   ```
   Ответ: `400 Bad Request` с ошибкой `INVALID_OTP`

### Сценарий 4: Истекший OTP код

1. **Отправка OTP:**
   ```bash
   POST /api/v1/auth/send-otp
   {
     "phone_number": "+996555123456"
   }
   ```

2. **Ожидание более 5 минут**

3. **Верификация:**
   ```bash
   POST /api/v1/auth/verify-otp
   Headers: x-app-role: CLIENT
   {
     "phone_number": "+996555123456",
     "otp_code": "1234"
   }
   ```
   Ответ: `400 Bad Request` с ошибкой `INVALID_OTP`

---

## Примечания

1. **OTP код:**
   - Состоит из 4 цифр
   - Действителен в течение 5 минут (300 секунд)
   - Может быть использован только один раз
   - После использования удаляется из базы данных

2. **JWT токен:**
   - Содержит: `sub` (user_id), `phoneNumber`, `role`
   - Используется для авторизации в последующих запросах
   - Передается в заголовке: `Authorization: Bearer <token>`

3. **Создание пользователя:**
   - Если пользователь не существует, он создается автоматически
   - Роль устанавливается из заголовка `x-app-role`
   - Флаг `is_new_user` устанавливается в `true` для новых пользователей

4. **Обновление роли:**
   - При верификации OTP роль пользователя обновляется согласно заголовку `x-app-role`
   - Это позволяет пользователю переключаться между ролями CLIENT и PARTNER

5. **Формат номера телефона:**
   - Обязательный формат: `+996XXXXXXXXX`
   - Должен начинаться с `+996`
   - После префикса должно быть ровно 9 цифр
   - Всего 13 символов

6. **Безопасность:**
   - OTP коды одноразовые
   - Коды имеют ограниченное время жизни
   - После верификации код удаляется

---

## Swagger документация

Интерактивная документация доступна по адресу: `/api/docs`

