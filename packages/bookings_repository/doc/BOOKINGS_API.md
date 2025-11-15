# Bookings API Documentation

Полная документация по API для работы с бронированиями.

**Base URL:** `/api/v1/bookings`

**Авторизация:** Все endpoints (кроме `confirm-payment`) требуют JWT токен в заголовке `Authorization: Bearer <token>`

---

## 1. Создать бронирование

**Endpoint:** `POST /api/v1/bookings`

**Требования:**
- Роль: `CLIENT`
- Авторизация: Требуется

**Тело запроса:**
```json
{
  "tour_id": "550e8400-e29b-41d4-a716-446655440000",
  "seats_count": 2,
  "name": "Иван Петров",
  "email": "ivan@example.com"
}
```

**Параметры:**
- `tour_id` (string, required) - UUID тура
- `seats_count` (number, required, min: 1) - Количество мест
- `name` (string, required, max: 255) - Имя бронирующего
- `email` (string, optional, max: 255) - Email бронирующего

### ✅ Успешный ответ (201 Created)

```json
{
  "booking": {
    "booking_id": "550e8400-e29b-41d4-a716-446655440001",
    "tour": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "title": "Тур по горам Ала-Арча",
      "mainImageUrl": "https://example.com/tour-image.jpg",
      "location": "Бишкек, Кыргызстан",
      "date": "2024-06-15T00:00:00.000Z",
      "time": "09:00",
      "price": 5000
    },
    "seats_count": 2,
    "total_amount": 10000,
    "status": "PENDING",
    "name": "Иван Петров",
    "email": "ivan@example.com",
    "created_at": "2024-01-01T00:00:00.000Z"
  }
}
```

### ❌ Ошибки

#### 400 Bad Request - Недостаточно мест
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "Not enough available spots",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings"
}
```

#### 400 Bad Request - Тур не активен
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "Tour is not active",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings"
}
```

#### 400 Bad Request - Ошибка валидации
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "seats_count must be a positive number",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings"
}
```

#### 404 Not Found - Тур не найден
```json
{
  "success": false,
  "error": "Not Found",
  "message": "Tour not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings"
}
```

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings"
}
```

---

## 2. Получить свои бронирования

**Endpoint:** `GET /api/v1/bookings/my`

**Требования:**
- Роль: `CLIENT`
- Авторизация: Требуется

**Query параметры:**
- `page` (number, optional, default: 1) - Номер страницы
- `limit` (number, optional, default: 20) - Количество элементов на странице

**Пример запроса:** `GET /api/v1/bookings/my?page=1&limit=20`

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "bookings": [
    {
      "booking_id": "550e8400-e29b-41d4-a716-446655440001",
      "tour": {
        "id": "550e8400-e29b-41d4-a716-446655440000",
        "title": "Тур по горам Ала-Арча",
        "mainImageUrl": "https://example.com/tour-image.jpg",
        "location": "Бишкек, Кыргызстан",
        "date": "2024-06-15T00:00:00.000Z",
        "time": "09:00",
        "price": 5000
      },
      "seats_count": 2,
      "total_amount": 10000,
      "status": "PENDING",
      "name": "Иван Петров",
      "email": "ivan@example.com",
      "created_at": "2024-01-01T00:00:00.000Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total_items": 1,
    "total_pages": 1
  }
}
```

### ❌ Ошибки

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings/my"
}
```

---

## 3. Отменить бронирование

**Endpoint:** `POST /api/v1/bookings/{booking_id}/cancel`

**Требования:**
- Роль: `CLIENT`
- Авторизация: Требуется

**Path параметры:**
- `booking_id` (string, required) - UUID бронирования

**Пример запроса:** `POST /api/v1/bookings/550e8400-e29b-41d4-a716-446655440001/cancel`

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "message": "Booking cancelled successfully",
  "booking": {
    "booking_id": "550e8400-e29b-41d4-a716-446655440001",
    "tour": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "title": "Тур по горам Ала-Арча",
      "mainImageUrl": "https://example.com/tour-image.jpg",
      "location": "Бишкек, Кыргызстан",
      "date": "2024-06-15T00:00:00.000Z",
      "time": "09:00",
      "price": 5000
    },
    "seats_count": 2,
    "total_amount": 10000,
    "status": "CANCELLED",
    "name": "Иван Петров",
    "email": "ivan@example.com",
    "created_at": "2024-01-01T00:00:00.000Z"
  }
}
```

### ❌ Ошибки

#### 400 Bad Request - Бронирование уже отменено
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "Booking is already cancelled",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings/550e8400-e29b-41d4-a716-446655440001/cancel"
}
```

#### 403 Forbidden - Нет доступа
```json
{
  "success": false,
  "error": "Forbidden",
  "message": "You can only cancel your own bookings",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings/550e8400-e29b-41d4-a716-446655440001/cancel"
}
```

#### 404 Not Found - Бронирование не найдено
```json
{
  "success": false,
  "error": "Not Found",
  "message": "Booking not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings/550e8400-e29b-41d4-a716-446655440001/cancel"
}
```

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings/550e8400-e29b-41d4-a716-446655440001/cancel"
}
```

---

## 4. Подтвердить оплату (Webhook)

**Endpoint:** `POST /api/v1/bookings/{booking_id}/confirm-payment`

**Требования:**
- Авторизация: Не требуется (Public endpoint)
- Используется как webhook для платежной системы finik.kg

**Path параметры:**
- `booking_id` (string, required) - UUID бронирования

**Пример запроса:** `POST /api/v1/bookings/550e8400-e29b-41d4-a716-446655440001/confirm-payment`

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "message": "Payment confirmed",
  "booking": {
    "booking_id": "550e8400-e29b-41d4-a716-446655440001",
    "tour": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "title": "Тур по горам Ала-Арча",
      "mainImageUrl": "https://example.com/tour-image.jpg",
      "location": "Бишкек, Кыргызстан",
      "date": "2024-06-15T00:00:00.000Z",
      "time": "09:00",
      "price": 5000
    },
    "seats_count": 2,
    "total_amount": 10000,
    "status": "PAID",
    "name": "Иван Петров",
    "email": "ivan@example.com",
    "created_at": "2024-01-01T00:00:00.000Z"
  }
}
```

### ❌ Ошибки

#### 400 Bad Request - Бронирование уже оплачено
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "Booking is already paid",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings/550e8400-e29b-41d4-a716-446655440001/confirm-payment"
}
```

#### 404 Not Found - Бронирование не найдено
```json
{
  "success": false,
  "error": "Not Found",
  "message": "Booking not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/bookings/550e8400-e29b-41d4-a716-446655440001/confirm-payment"
}
```

---

## Структуры данных

### Booking (Бронирование)

```typescript
{
  booking_id: string;           // UUID бронирования
  tour: TourInfo;               // Информация о туре
  seats_count: number;          // Количество мест
  total_amount: number;          // Общая сумма
  status: 'PENDING' | 'PAID' | 'CANCELLED';  // Статус бронирования
  name: string;                 // Имя бронирующего
  email: string | null;         // Email (может быть null)
  created_at: string;           // Дата создания (ISO datetime)
}
```

### TourInfo (Информация о туре)

```typescript
{
  id: string;                  // UUID тура
  title: string;                // Название тура
  mainImageUrl: string;         // URL главного изображения
  location: string;             // Местоположение
  date: string;                // Дата тура (ISO date)
  time: string;                // Время начала ("HH:mm")
  price: number;               // Цена за место
}
```

### Pagination (Пагинация)

```typescript
{
  page: number;                // Текущая страница
  limit: number;               // Элементов на странице
  total_items: number;         // Всего элементов
  total_pages: number;         // Всего страниц
}
```

### Error Response (Ошибка)

```typescript
{
  success: false;
  error: string;               // Тип ошибки (Bad Request, Not Found, etc.)
  message: string;             // Сообщение об ошибке
  timestamp: string;            // Время возникновения (ISO datetime)
  path: string;                // Путь запроса
}
```

---

## Статусы бронирования

- `PENDING` - Ожидает оплаты
- `PAID` - Оплачено
- `CANCELLED` - Отменено

---

## Примечания

1. Все endpoints (кроме `confirm-payment`) требуют JWT авторизации
2. Endpoint `confirm-payment` является публичным и используется как webhook для платежной системы
3. При создании бронирования автоматически уменьшается количество доступных мест в туре
4. При отмене бронирования места возвращаются обратно в тур
5. Все даты и время возвращаются в формате ISO 8601
6. Цены возвращаются в числовом формате (не строки)

---

## Swagger документация

Интерактивная документация доступна по адресу: `/api/docs`

