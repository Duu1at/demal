# Tours API Documentation

Полная документация по API для работы с турами.

**Base URL:** `/api/v1/tours`

**Авторизация:** Endpoints для партнеров требуют JWT токен в заголовке `Authorization: Bearer <token>`

---

## 1. Получить список туров (с фильтрацией)

**Endpoint:** `GET /api/v1/tours`

**Требования:**
- Авторизация: Не требуется (Public)

**Query параметры (все опциональны):**

| Параметр | Тип | Обязательный | Описание | Пример |
|----------|-----|--------------|----------|--------|
| `page` | number | ❌ Нет | Номер страницы | `1` |
| `limit` | number | ❌ Нет | Количество элементов на странице | `20` |
| `search` | string | ❌ Нет | Поиск по названию, описанию, местоположению | `"горы"` |
| `location` | string | ❌ Нет | Фильтр по местоположению | `"Иссык-Куль"` |
| `tour_type` | string | ❌ Нет | Фильтр по типу тура | `"Активный отдых"` |
| `date_from` | string | ❌ Нет | Дата начала (ISO date) | `"2024-06-01"` |
| `date_to` | string | ❌ Нет | Дата окончания (ISO date) | `"2024-06-30"` |
| `price_min` | number | ❌ Нет | Минимальная цена | `1000` |
| `price_max` | number | ❌ Нет | Максимальная цена | `10000` |
| `sort_by` | string | ❌ Нет | Сортировка | `"price_asc"`, `"price_desc"`, `"date_asc"`, `"date_desc"`, `"rating_desc"` |

**Пример запроса:** `GET /api/v1/tours?page=1&limit=20&location=Иссык-Куль&price_min=1000&sort_by=price_asc`

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "tours": [
    {
      "tour_id": "550e8400-e29b-41d4-a716-446655440000",
      "title": "Тур по озеру Иссык-Куль",
      "main_image_url": "https://example.com/main-image.jpg",
      "location": "Озеро Иссык-Куль",
      "tour_type": "Активный отдых",
      "date": "2024-06-15",
      "time": "09:00",
      "price": 5000,
      "currency": "KGS",
      "available_spots": 20,
      "description": "Прекрасный однодневный тур",
      "program": {
        "09:00": "Встреча",
        "10:00": "Выезд"
      },
      "meeting_point": {
        "address": "Бишкек, пр. Чуй, 145",
        "coordinates": "42.8746,74.5698"
      },
      "whats_included": ["Трансфер", "Обед", "Гид"],
      "whats_not_included": ["Личные расходы", "Алкоголь"],
      "what_to_bring": "Удобная одежда, солнцезащитный крем",
      "image_gallery_urls": [
        "https://example.com/image1.jpg",
        "https://example.com/image2.jpg"
      ],
      "organizer": {
        "id": "550e8400-e29b-41d4-a716-446655440001",
        "fullName": "Иван Петров",
        "imageUrl": "https://example.com/avatar.jpg"
      },
      "status": "ACTIVE",
      "average_rating": 4.5,
      "reviews_count": 15,
      "created_at": "2024-01-01T00:00:00.000Z",
      "updated_at": "2024-01-01T00:00:00.000Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total_items": 50,
    "total_pages": 3
  }
}
```

---

## 2. Получить детали тура

**Endpoint:** `GET /api/v1/tours/{tour_id}`

**Требования:**
- Авторизация: Не требуется (Public)

**Path параметры:**

| Параметр | Тип | Обязательный | Описание | Пример |
|----------|-----|--------------|----------|--------|
| `tour_id` | string | ✅ Да | UUID тура | `550e8400-e29b-41d4-a716-446655440000` |

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "tour": {
    "tour_id": "550e8400-e29b-41d4-a716-446655440000",
    "title": "Тур по озеру Иссык-Куль",
    "main_image_url": "https://example.com/main-image.jpg",
    "location": "Озеро Иссык-Куль",
    "tour_type": "Активный отдых",
    "date": "2024-06-15",
    "time": "09:00",
    "price": 5000,
    "currency": "KGS",
    "available_spots": 20,
    "description": "Прекрасный однодневный тур",
    "program": {
      "09:00": "Встреча",
      "10:00": "Выезд",
      "12:00": "Прибытие"
    },
    "meeting_point": {
      "address": "Бишкек, пр. Чуй, 145",
      "coordinates": "42.8746,74.5698"
    },
    "whats_included": ["Трансфер", "Обед", "Гид"],
    "whats_not_included": ["Личные расходы", "Алкоголь"],
    "what_to_bring": "Удобная одежда, солнцезащитный крем",
    "image_gallery_urls": [
      "https://example.com/image1.jpg",
      "https://example.com/image2.jpg"
    ],
    "organizer": {
      "id": "550e8400-e29b-41d4-a716-446655440001",
      "fullName": "Иван Петров",
      "imageUrl": "https://example.com/avatar.jpg"
    },
    "status": "ACTIVE",
    "average_rating": 4.5,
    "reviews_count": 15,
    "created_at": "2024-01-01T00:00:00.000Z",
    "updated_at": "2024-01-01T00:00:00.000Z"
  }
}
```

### ❌ Ошибки

#### 404 Not Found - Тур не найден
```json
{
  "success": false,
  "error": "Not Found",
  "message": "Tour not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000"
}
```

---

## 3. Создать тур

**Endpoint:** `POST /api/v1/tours`

**Требования:**
- Авторизация: Требуется
- Роль: `PARTNER` (только верифицированные партнеры)

### 📋 Модель данных запроса

**Тело запроса (JSON):**

| Поле | Тип | Обязательный | Описание | Ограничения | Пример |
|------|-----|--------------|----------|-------------|--------|
| `title` | string | ✅ Да | Название тура | max: 255 | `"Тур по озеру Иссык-Куль"` |
| `main_image_url` | string | ✅ Да | URL главного изображения | max: 500 | `"https://example.com/main-image.jpg"` |
| `location` | string | ✅ Да | Местоположение | max: 255 | `"Озеро Иссык-Куль"` |
| `tour_type` | string | ✅ Да | Тип тура | max: 255 | `"Активный отдых"` |
| `date` | string | ✅ Да | Дата тура | ISO date format | `"2024-06-15"` |
| `time` | string | ✅ Да | Время начала | HH:mm format | `"09:00"` |
| `price` | number | ✅ Да | Цена за место | min: 0 | `5000` |
| `currency` | string | ❌ Нет | Валюта | max: 3, default: "KGS" | `"KGS"` |
| `available_spots` | number | ✅ Да | Доступные места | min: 1, integer | `20` |
| `description` | string | ❌ Нет | Описание тура | - | `"Прекрасный однодневный тур"` |
| `program` | object | ❌ Нет | Программа тура (JSON) | - | `{"09:00": "Встреча"}` |
| `meeting_point` | object | ❌ Нет | Точка встречи | - | См. ниже |
| `whats_included` | string[] | ✅ Да | Что включено | массив строк | `["Трансфер", "Обед"]` |
| `whats_not_included` | string[] | ✅ Да | Что не включено | массив строк | `["Личные расходы"]` |
| `what_to_bring` | string | ❌ Нет | Что взять с собой | - | `"Удобная одежда"` |
| `image_gallery_urls` | string[] | ✅ Да | URL галереи изображений | массив строк | `["https://example.com/image1.jpg"]` |

**Структура `meeting_point`:**
```json
{
  "address": "Бишкек, пр. Чуй, 145",  // Обязательное
  "coordinates": "42.8746,74.5698"   // Опциональное
}
```

**Пример запроса:**
```json
{
  "title": "Тур по озеру Иссык-Куль",
  "main_image_url": "https://example.com/main-image.jpg",
  "location": "Озеро Иссык-Куль",
  "tour_type": "Активный отдых",
  "date": "2024-06-15",
  "time": "09:00",
  "price": 5000,
  "currency": "KGS",
  "available_spots": 20,
  "description": "Прекрасный однодневный тур с посещением основных достопримечательностей",
  "program": {
    "09:00": "Встреча в центре города",
    "10:00": "Выезд к озеру",
    "12:00": "Прибытие на место",
    "13:00": "Обед",
    "18:00": "Возвращение"
  },
  "meeting_point": {
    "address": "Бишкек, пр. Чуй, 145",
    "coordinates": "42.8746,74.5698"
  },
  "whats_included": ["Трансфер", "Обед", "Гид", "Страховка"],
  "whats_not_included": ["Личные расходы", "Алкоголь", "Сувениры"],
  "what_to_bring": "Удобная одежда, солнцезащитный крем, вода",
  "image_gallery_urls": [
    "https://example.com/image1.jpg",
    "https://example.com/image2.jpg",
    "https://example.com/image3.jpg"
  ]
}
```

### ✅ Успешный ответ (201 Created)

```json
{
  "tour": {
    "tour_id": "550e8400-e29b-41d4-a716-446655440000",
    "title": "Тур по озеру Иссык-Куль",
    "main_image_url": "https://example.com/main-image.jpg",
    "location": "Озеро Иссык-Куль",
    "tour_type": "Активный отдых",
    "date": "2024-06-15",
    "time": "09:00",
    "price": 5000,
    "currency": "KGS",
    "available_spots": 20,
    "description": "Прекрасный однодневный тур",
    "program": {
      "09:00": "Встреча",
      "10:00": "Выезд"
    },
    "meeting_point": {
      "address": "Бишкек, пр. Чуй, 145",
      "coordinates": "42.8746,74.5698"
    },
    "whats_included": ["Трансфер", "Обед", "Гид"],
    "whats_not_included": ["Личные расходы", "Алкоголь"],
    "what_to_bring": "Удобная одежда, солнцезащитный крем",
    "image_gallery_urls": [
      "https://example.com/image1.jpg",
      "https://example.com/image2.jpg"
    ],
    "organizer": {
      "id": "550e8400-e29b-41d4-a716-446655440001",
      "fullName": "Иван Петров",
      "imageUrl": "https://example.com/avatar.jpg"
    },
    "status": "ACTIVE",
    "average_rating": null,
    "reviews_count": 0,
    "created_at": "2024-01-01T00:00:00.000Z",
    "updated_at": "2024-01-01T00:00:00.000Z"
  }
}
```

### ❌ Ошибки

#### 403 Forbidden - Недостаточно прав
```json
{
  "success": false,
  "error": "Forbidden",
  "message": "Only verified partners can create tours",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours"
}
```

**Причины:**
- Пользователь не является партнером
- Партнер не верифицирован (статус не `VERIFIED`)

#### 400 Bad Request - Ошибка валидации

**Пример 1: Отсутствует обязательное поле**
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "title should not be empty",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours"
}
```

**Пример 2: Неверный формат данных**
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "price must be a positive number",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours"
}
```

**Пример 3: Превышена максимальная длина**
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "title must be shorter than or equal to 255 characters",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours"
}
```

**Пример 4: Неверный формат даты**
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "date must be a valid ISO 8601 date string",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours"
}
```

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours"
}
```

---

## 4. Обновить тур

**Endpoint:** `PATCH /api/v1/tours/{tour_id}`

**Требования:**
- Авторизация: Требуется
- Роль: `PARTNER`
- Условие: Тур должен принадлежать текущему пользователю

**Path параметры:**

| Параметр | Тип | Обязательный | Описание |
|----------|-----|--------------|----------|
| `tour_id` | string | ✅ Да | UUID тура |

### 📋 Модель данных запроса

**Тело запроса (JSON):** Все поля опциональны, можно обновить только нужные

| Поле | Тип | Обязательный | Описание | Ограничения |
|------|-----|--------------|----------|-------------|
| `title` | string | ❌ Нет | Название тура | max: 255 |
| `main_image_url` | string | ❌ Нет | URL главного изображения | max: 500 |
| `location` | string | ❌ Нет | Местоположение | max: 255 |
| `tour_type` | string | ❌ Нет | Тип тура | max: 255 |
| `date` | string | ❌ Нет | Дата тура | ISO date format |
| `time` | string | ❌ Нет | Время начала | HH:mm format |
| `price` | number | ❌ Нет | Цена за место | min: 0 |
| `currency` | string | ❌ Нет | Валюта | max: 3 |
| `available_spots` | number | ❌ Нет | Доступные места | min: 1, integer |
| `description` | string | ❌ Нет | Описание тура | - |
| `program` | object | ❌ Нет | Программа тура (JSON) | - |
| `meeting_point` | object | ❌ Нет | Точка встречи | - |
| `whats_included` | string[] | ❌ Нет | Что включено | массив строк |
| `whats_not_included` | string[] | ❌ Нет | Что не включено | массив строк |
| `what_to_bring` | string | ❌ Нет | Что взять с собой | - |
| `image_gallery_urls` | string[] | ❌ Нет | URL галереи изображений | массив строк |

**Пример запроса (обновление только цены):**
```json
{
  "price": 6000
}
```

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "tour": {
    "tour_id": "550e8400-e29b-41d4-a716-446655440000",
    "title": "Тур по озеру Иссык-Куль",
    "main_image_url": "https://example.com/main-image.jpg",
    "location": "Озеро Иссык-Куль",
    "tour_type": "Активный отдых",
    "date": "2024-06-15",
    "time": "09:00",
    "price": 6000,
    "currency": "KGS",
    "available_spots": 20,
    "description": "Прекрасный однодневный тур",
    "program": {
      "09:00": "Встреча",
      "10:00": "Выезд"
    },
    "meeting_point": {
      "address": "Бишкек, пр. Чуй, 145",
      "coordinates": "42.8746,74.5698"
    },
    "whats_included": ["Трансфер", "Обед", "Гид"],
    "whats_not_included": ["Личные расходы", "Алкоголь"],
    "what_to_bring": "Удобная одежда, солнцезащитный крем",
    "image_gallery_urls": [
      "https://example.com/image1.jpg",
      "https://example.com/image2.jpg"
    ],
    "organizer": {
      "id": "550e8400-e29b-41d4-a716-446655440001",
      "fullName": "Иван Петров",
      "imageUrl": "https://example.com/avatar.jpg"
    },
    "status": "ACTIVE",
    "average_rating": 4.5,
    "reviews_count": 15,
    "created_at": "2024-01-01T00:00:00.000Z",
    "updated_at": "2024-01-01T00:00:00.000Z"
  }
}
```

### ❌ Ошибки

#### 403 Forbidden - Не ваш тур
```json
{
  "success": false,
  "error": "Forbidden",
  "message": "You can only update your own tours",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000"
}
```

#### 404 Not Found - Тур не найден
```json
{
  "success": false,
  "error": "Not Found",
  "message": "Tour not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000"
}
```

#### 400 Bad Request - Ошибка валидации
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "price must be a positive number",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000"
}
```

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000"
}
```

---

## 5. Удалить тур

**Endpoint:** `DELETE /api/v1/tours/{tour_id}`

**Требования:**
- Авторизация: Требуется
- Роль: `PARTNER`
- Условие: Тур должен принадлежать текущему пользователю
- Ограничение: Нельзя удалить тур с активными бронированиями (PENDING или PAID)

**Path параметры:**

| Параметр | Тип | Обязательный | Описание |
|----------|-----|--------------|----------|
| `tour_id` | string | ✅ Да | UUID тура |

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "message": "Tour deleted successfully"
}
```

### ❌ Ошибки

#### 400 Bad Request - Есть активные бронирования
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "Cannot delete tour with active bookings",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000"
}
```

**Причина:** У тура есть бронирования со статусом `PENDING` или `PAID`

#### 403 Forbidden - Не ваш тур
```json
{
  "success": false,
  "error": "Forbidden",
  "message": "You can only delete your own tours",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000"
}
```

#### 404 Not Found - Тур не найден
```json
{
  "success": false,
  "error": "Not Found",
  "message": "Tour not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000"
}
```

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000"
}
```

---

## 6. Получить свои туры (для партнера)

**Endpoint:** `GET /api/v1/tours/my`

**Требования:**
- Авторизация: Требуется
- Роль: `PARTNER`

**Query параметры:**

| Параметр | Тип | Обязательный | Описание | Пример |
|----------|-----|--------------|----------|--------|
| `page` | number | ❌ Нет | Номер страницы | `1` |
| `limit` | number | ❌ Нет | Количество элементов на странице | `20` |

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "tours": [
    {
      "tour_id": "550e8400-e29b-41d4-a716-446655440000",
      "title": "Тур по озеру Иссык-Куль",
      "main_image_url": "https://example.com/main-image.jpg",
      "location": "Озеро Иссык-Куль",
      "tour_type": "Активный отдых",
      "date": "2024-06-15",
      "time": "09:00",
      "price": 5000,
      "currency": "KGS",
      "available_spots": 20,
      "description": "Прекрасный однодневный тур",
      "program": {
        "09:00": "Встреча",
        "10:00": "Выезд"
      },
      "meeting_point": {
        "address": "Бишкек, пр. Чуй, 145",
        "coordinates": "42.8746,74.5698"
      },
      "whats_included": ["Трансфер", "Обед", "Гид"],
      "whats_not_included": ["Личные расходы", "Алкоголь"],
      "what_to_bring": "Удобная одежда, солнцезащитный крем",
      "image_gallery_urls": [
        "https://example.com/image1.jpg",
        "https://example.com/image2.jpg"
      ],
      "organizer": {
        "id": "550e8400-e29b-41d4-a716-446655440001",
        "fullName": "Иван Петров",
        "imageUrl": "https://example.com/avatar.jpg"
      },
      "status": "ACTIVE",
      "average_rating": 4.5,
      "reviews_count": 15,
      "created_at": "2024-01-01T00:00:00.000Z",
      "updated_at": "2024-01-01T00:00:00.000Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total_items": 5,
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
  "path": "/api/v1/tours/my"
}
```

---

## 7. Получить отзывы тура

**Endpoint:** `GET /api/v1/tours/{tour_id}/reviews`

**Требования:**
- Авторизация: Не требуется (Public)

**Path параметры:**

| Параметр | Тип | Обязательный | Описание |
|----------|-----|--------------|----------|
| `tour_id` | string | ✅ Да | UUID тура |

**Query параметры:**

| Параметр | Тип | Обязательный | Описание | Пример |
|----------|-----|--------------|----------|--------|
| `page` | number | ❌ Нет | Номер страницы | `1` |
| `limit` | number | ❌ Нет | Количество элементов на странице | `20` |

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "reviews": [
    {
      "review_id": "550e8400-e29b-41d4-a716-446655440002",
      "user": {
        "id": "550e8400-e29b-41d4-a716-446655440003",
        "fullName": "Петр Иванов",
        "imageUrl": "https://example.com/avatar2.jpg"
      },
      "rating": 5,
      "text": "Отличный тур! Очень понравилось.",
      "created_at": "2024-01-05T00:00:00.000Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total_items": 15,
    "total_pages": 1
  }
}
```

### ❌ Ошибки

#### 404 Not Found - Тур не найден
```json
{
  "success": false,
  "error": "Not Found",
  "message": "Tour not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000/reviews"
}
```

---

## 8. Получить бронирования тура (для партнера)

**Endpoint:** `GET /api/v1/tours/{tour_id}/bookings`

**Требования:**
- Авторизация: Требуется
- Роль: `PARTNER`
- Условие: Тур должен принадлежать текущему пользователю

**Path параметры:**

| Параметр | Тип | Обязательный | Описание |
|----------|-----|--------------|----------|
| `tour_id` | string | ✅ Да | UUID тура |

### ✅ Успешный ответ (200 OK)

```json
{
  "success": true,
  "bookings": [
    {
      "booking_id": "550e8400-e29b-41d4-a716-446655440004",
      "user": {
        "id": "550e8400-e29b-41d4-a716-446655440005",
        "fullName": "Анна Сидорова",
        "phoneNumber": "+996555123456"
      },
      "seats_count": 2,
      "total_amount": 10000,
      "status": "PAID",
      "name": "Анна Сидорова",
      "email": "anna@example.com",
      "created_at": "2024-01-10T00:00:00.000Z"
    }
  ]
}
```

### ❌ Ошибки

#### 403 Forbidden - Не ваш тур
```json
{
  "success": false,
  "error": "Forbidden",
  "message": "You can only view bookings for your own tours",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000/bookings"
}
```

#### 404 Not Found - Тур не найден
```json
{
  "success": false,
  "error": "Not Found",
  "message": "Tour not found",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000/bookings"
}
```

#### 401 Unauthorized - Не авторизован
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Unauthorized",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "path": "/api/v1/tours/550e8400-e29b-41d4-a716-446655440000/bookings"
}
```

---

## Структуры данных

### Tour (Тур)

```typescript
{
  tour_id: string;                    // UUID тура
  title: string;                      // Название
  main_image_url: string;             // URL главного изображения
  location: string;                   // Местоположение
  tour_type: string;                  // Тип тура
  date: string;                       // Дата (ISO date: "2024-06-15")
  time: string;                       // Время ("09:00")
  price: number;                      // Цена
  currency: string;                   // Валюта
  available_spots: number;            // Доступные места
  description: string | null;         // Описание
  program: object | null;             // Программа (JSON)
  meeting_point: object | null;       // Точка встречи
  whats_included: string[];          // Что включено
  whats_not_included: string[];      // Что не включено
  what_to_bring: string | null;      // Что взять с собой
  image_gallery_urls: string[];       // URL галереи
  organizer: Organizer;               // Организатор
  status: 'ACTIVE' | 'COMPLETED' | 'CANCELLED';  // Статус
  average_rating: number | null;     // Средний рейтинг
  reviews_count: number;              // Количество отзывов
  created_at: string;                // Дата создания (ISO datetime)
  updated_at: string;                // Дата обновления (ISO datetime)
}
```

### Organizer (Организатор)

```typescript
{
  id: string;                        // UUID организатора
  fullName: string | null;           // Полное имя
  imageUrl: string | null;           // URL аватара
}
```

### MeetingPoint (Точка встречи)

```typescript
{
  address: string;                   // Адрес (обязательное)
  coordinates?: string;              // Координаты (опциональное, формат: "lat,lng")
}
```

### Pagination (Пагинация)

```typescript
{
  page: number;                      // Текущая страница
  limit: number;                    // Элементов на странице
  total_items: number;              // Всего элементов
  total_pages: number;               // Всего страниц
}
```

---

## Статусы туров

- `ACTIVE` - Активный тур, доступен для бронирования
- `COMPLETED` - Завершенный тур
- `CANCELLED` - Отмененный тур

---

## Сортировка туров

Доступные значения для `sort_by`:
- `date_asc` - По дате (от ранних к поздним)
- `date_desc` - По дате (от поздних к ранним)
- `price_asc` - По цене (от дешевых к дорогим)
- `price_desc` - По цене (от дорогих к дешевым)
- `rating_desc` - По рейтингу (от высоких к низким)

---

## Примечания

1. **Создание туров:**
   - Только верифицированные партнеры (`verification_status: 'VERIFIED'`) могут создавать туры
   - При создании тура статус автоматически устанавливается в `ACTIVE`

2. **Обновление туров:**
   - Можно обновить только свои туры
   - Все поля опциональны, можно обновить только нужные

3. **Удаление туров:**
   - Можно удалить только свои туры
   - Нельзя удалить тур с активными бронированиями (статус `PENDING` или `PAID`)

4. **Фильтрация:**
   - Поиск (`search`) ищет по названию, описанию и местоположению
   - Фильтры можно комбинировать
   - Все фильтры опциональны

5. **Рейтинг:**
   - Средний рейтинг рассчитывается автоматически на основе отзывов
   - Округляется до 1 знака после запятой
   - Если отзывов нет, `average_rating` будет `null`

6. **Валидация:**
   - Все строковые поля имеют ограничения по длине
   - Цены должны быть неотрицательными числами
   - Количество мест должно быть положительным целым числом
   - Дата должна быть в формате ISO 8601 (YYYY-MM-DD)
   - Время должно быть в формате HH:mm

---

## Swagger документация

Интерактивная документация доступна по адресу: `/api/docs`

