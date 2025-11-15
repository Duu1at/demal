# Profiles API Documentation

Полная документация по API для работы с профилями клиентов и партнеров.

**Base URL:** `/api/v1`

**Авторизация:** Все endpoints требуют JWT токен в заголовке `Authorization: Bearer <token>`

---

## Users API (Профиль клиента)

### Base URL: `/api/v1/users`

---

## 1. Получить информацию о текущем пользователе

**Endpoint:** `GET /api/v1/users/me`

**Требования:**
- Авторизация: Требуется
- Роль: Любая (CLIENT, PARTNER, ADMIN)

### ✅ Успешный ответ (200 OK)

**Для клиента:**
```json
{
  "success": true,
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

**Для партнера (с профилем партнера):**
```json
{
  "success": true,
  "user": {
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "phone_number": "+996555123456",
    "full_name": "Иван Петров",
    "role": "PARTNER",
    "image_url": "https://example.com/avatar.jpg",
    "created_at": "2024-01-01T00:00:00.000Z",
    "partner_profile": {
      "profile_id": "550e8400-e29b-41d4-a716-446655440002",
      "company_name": "Туристическая компания \"Горные тропы\"",
      "description": "Профессиональные туристические туры по Кыргызстану",
      "documents_url": "https://example.com/documents.pdf",
      "verification_status": "VERIFIED",
      "card_number": "1234567890123456"
    }
  }
}
```

### ❌ Ошибки

#### 404 Not Found - Пользователь не найден
```json
{
  "success": false,
  "error": "Not Found",
  "message": "User not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/users/me"
}
```

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/users/me"
}
```

---

## 2. Обновить профиль пользователя

**Endpoint:** `PATCH /api/v1/users/profile`

**Требования:**
- Авторизация: Требуется
- Роль: Любая

**Тело запроса:**
```json
{
  "full_name": "Иван Петров",
  "image_url": "https://example.com/avatar.jpg"
}
```

**Параметры:**
- `full_name` (string, optional, max: 255) - Полное имя пользователя
- `image_url` (string, optional, max: 500) - URL аватара пользователя

**Примечание:** Оба параметра опциональны, можно обновить только один из них.

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
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

### ❌ Ошибки

#### 400 Bad Request - Ошибка валидации
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "full_name must be a string",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/users/profile"
}
```

**Другие возможные ошибки валидации:**
- `full_name must be shorter than or equal to 255 characters`
- `image_url must be a string`
- `image_url must be shorter than or equal to 500 characters`

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/users/profile"
}
```

---

## Partners API (Профиль партнера)

### Base URL: `/api/v1/partners`

---

## 1. Создать или обновить профиль партнера

**Endpoint:** `POST /api/v1/partners/profile`

**Требования:**
- Авторизация: Требуется
- Роль: `PARTNER` или `CLIENT`

**Тело запроса:**
```json
{
  "company_name": "Туристическая компания \"Горные тропы\"",
  "description": "Профессиональные туристические туры по Кыргызстану",
  "documents_url": "https://example.com/documents.pdf",
  "card_number": "1234567890123456"
}
```

**Параметры:**
- `company_name` (string, required, max: 255) - Название компании
- `description` (string, optional) - Описание компании
- `documents_url` (string, optional, max: 500) - URL документов
- `card_number` (string, optional, max: 20) - Номер карты для выплат

**Примечание:** 
- Если профиль не существует, он будет создан, и роль пользователя автоматически изменится на `PARTNER`
- Если профиль существует, он будет обновлен, и статус верификации сбросится на `PENDING`

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "profile": {
    "profile_id": "550e8400-e29b-41d4-a716-446655440002",
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "company_name": "Туристическая компания \"Горные тропы\"",
    "description": "Профессиональные туристические туры по Кыргызстану",
    "documents_url": "https://example.com/documents.pdf",
    "verification_status": "PENDING",
    "card_number": "1234567890123456"
  }
}
```

### ❌ Ошибки

#### 400 Bad Request - Ошибка валидации
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "company_name should not be empty",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/partners/profile"
}
```

**Другие возможные ошибки валидации:**
- `company_name must be a string`
- `company_name must be shorter than or equal to 255 characters`
- `description must be a string`
- `documents_url must be a string`
- `documents_url must be shorter than or equal to 500 characters`
- `card_number must be a string`
- `card_number must be shorter than or equal to 20 characters`

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/partners/profile"
}
```

---

## 2. Получить статус верификации партнера

**Endpoint:** `GET /api/v1/partners/verification-status`

**Требования:**
- Авторизация: Требуется
- Роль: `PARTNER`

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "verification_status": "VERIFIED",
  "admin_comments": "Документы проверены, все в порядке",
  "submitted_at": "2024-01-01T00:00:00.000Z",
  "reviewed_at": "2024-01-05T00:00:00.000Z"
}
```

**Возможные статусы верификации:**
- `PENDING` - Ожидает проверки
- `VERIFIED` - Верифицирован
- `REJECTED` - Отклонен

### ❌ Ошибки

#### 403 Forbidden - Профиль партнера не найден
```json
{
  "success": false,
  "error": "Forbidden",
  "message": "Partner profile not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/partners/verification-status"
}
```

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/partners/verification-status"
}
```

---

## 3. Получить статистику партнера

**Endpoint:** `GET /api/v1/partners/statistics`

**Требования:**
- Авторизация: Требуется
- Роль: `PARTNER`

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "statistics": {
    "total_tours": 25,
    "active_tours": 10,
    "completed_tours": 12,
    "cancelled_tours": 3,
    "total_bookings": 150,
    "total_revenue": 1500000,
    "average_rating": 4.5,
    "total_reviews": 45
  }
}
```

**Описание полей:**
- `total_tours` - Общее количество созданных туров
- `active_tours` - Количество активных туров
- `completed_tours` - Количество завершенных туров
- `cancelled_tours` - Количество отмененных туров
- `total_bookings` - Общее количество оплаченных бронирований
- `total_revenue` - Общая выручка (сумма всех оплаченных бронирований)
- `average_rating` - Средний рейтинг по всем отзывам (округлено до 1 знака после запятой)
- `total_reviews` - Общее количество отзывов

### ❌ Ошибки

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/partners/statistics"
}
```

---

## Структуры данных

### User (Пользователь)

```typescript
{
  user_id: string;                    // UUID пользователя
  phone_number: string;                // Номер телефона
  full_name: string | null;            // Полное имя (может быть null)
  role: 'CLIENT' | 'PARTNER' | 'ADMIN';  // Роль пользователя
  image_url: string | null;           // URL аватара (может быть null)
  created_at: string;                 // Дата создания (ISO datetime)
  partner_profile?: PartnerProfile;   // Профиль партнера (если есть)
}
```

### PartnerProfile (Профиль партнера)

```typescript
{
  profile_id: string;                  // UUID профиля
  user_id: string;                   // UUID пользователя
  company_name: string;               // Название компании
  description: string | null;         // Описание (может быть null)
  documents_url: string | null;       // URL документов (может быть null)
  verification_status: 'PENDING' | 'VERIFIED' | 'REJECTED';  // Статус верификации
  card_number: string | null;         // Номер карты (может быть null)
}
```

### VerificationStatus (Статус верификации)

```typescript
{
  verification_status: 'PENDING' | 'VERIFIED' | 'REJECTED';  // Статус
  admin_comments: string | null;      // Комментарии администратора (может быть null)
  submitted_at: string;               // Дата подачи заявки (ISO datetime)
  reviewed_at: string;               // Дата последнего обновления (ISO datetime)
}
```

### PartnerStatistics (Статистика партнера)

```typescript
{
  total_tours: number;                // Всего туров
  active_tours: number;               // Активных туров
  completed_tours: number;            // Завершенных туров
  cancelled_tours: number;            // Отмененных туров
  total_bookings: number;             // Всего бронирований
  total_revenue: number;              // Общая выручка
  average_rating: number;             // Средний рейтинг
  total_reviews: number;              // Всего отзывов
}
```

### Error Response (Ошибка)

```typescript
{
  success: false;
  error: string;                       // Тип ошибки (Bad Request, Not Found, etc.)
  message: string;                    // Сообщение об ошибке
  timestamp: string;                  // Время возникновения (ISO datetime)
  path: string;                       // Путь запроса
}
```

---

## Статусы верификации партнера

- `PENDING` - Ожидает проверки администратором
- `VERIFIED` - Верифицирован, может создавать туры
- `REJECTED` - Отклонен, требуется исправление документов

---

## Роли пользователей

- `CLIENT` - Обычный клиент, может бронировать туры
- `PARTNER` - Партнер, может создавать туры и управлять ими
- `ADMIN` - Администратор, имеет полный доступ

---

## Примечания

1. **Автоматическое изменение роли:**
   - При создании профиля партнера роль пользователя автоматически меняется с `CLIENT` на `PARTNER`

2. **Сброс статуса верификации:**
   - При обновлении профиля партнера статус верификации автоматически сбрасывается на `PENDING`

3. **Профиль партнера в ответе пользователя:**
   - Если у пользователя есть профиль партнера, он будет включен в ответ `GET /api/v1/users/me`

4. **Статистика партнера:**
   - Считаются только оплаченные бронирования (`status: 'PAID'`)
   - Средний рейтинг округляется до 1 знака после запятой
   - Если отзывов нет, `average_rating` будет равен `0`

5. **Валидация:**
   - Все строковые поля имеют ограничения по длине
   - Email валидируется по стандартному формату (если используется)

---

## Swagger документация

Интерактивная документация доступна по адресу: `/api/docs`

