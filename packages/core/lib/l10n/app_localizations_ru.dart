// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get verificationStatusTitle => 'Статус верификации';

  @override
  String get editTourTitle => 'Редактирование тура';

  @override
  String get createTourTitle => 'Создание тура';

  @override
  String get save => 'Сохранить';

  @override
  String get tourTitleLabel => 'Название тура';

  @override
  String get tourTitleHint => 'Например: Тур по озеру Иссык-Куль';

  @override
  String get tourTypeExampleHint => 'Например: Активный отдых, Экскурсия';

  @override
  String get tourLocationHint => 'Где проходит тур';

  @override
  String get dateLabel => 'Дата';

  @override
  String get dateFormatHint => 'ДД.ММ.ГГГГ';

  @override
  String get timeLabel => 'Время';

  @override
  String get timeFormatHint => 'ЧЧ:ММ';

  @override
  String get priceLabel => 'Цена';

  @override
  String get priceMustBeGreaterThanZero => 'Цена должна быть больше 0';

  @override
  String get currencyLabel => 'Валюта';

  @override
  String get availableSpotsLabel => 'Доступные места';

  @override
  String get spotsCountHint => 'Количество мест';

  @override
  String get spotsMustBeGreaterThanZero => 'Количество мест должно быть больше 0';

  @override
  String get detailedDescriptionHint => 'Подробное описание тура';

  @override
  String get meetingPointLabel => 'Точка встречи';

  @override
  String get meetingPointHint => 'Адрес места встречи';

  @override
  String get whatToBringLabel => 'Что взять с собой';

  @override
  String get whatToBringHint => 'Рекомендации для участников';

  @override
  String get mainImageLabel => 'Главное изображение *';

  @override
  String get addMainImageLabel => 'Добавить главное изображение';

  @override
  String get galleryImagesLabel => 'Галерея изображений *';

  @override
  String get maxImagesCountError => 'Максимум 10 изображений';

  @override
  String get addCountLabel => 'Добавить';

  @override
  String get addItemHint => 'Добавить пункт';

  @override
  String get addAtLeastOneItemError => 'Добавьте хотя бы один пункт';

  @override
  String get toursBookingsTitle => 'Бронирования туров';

  @override
  String get next => 'Next';

  @override
  String otpMessage(Object phone) {
    return 'На номер $phone было отправлено 6-значное сообщение OTP';
  }

  @override
  String get selectLang => 'Выберите язык';

  @override
  String get selectTheme => 'Выберите тему';

  @override
  String get lightTheme => 'Светлая тема';

  @override
  String get darkTheme => 'Тёмная тема';

  @override
  String get aboutUs => 'О наc';

  @override
  String get lastUpdate => 'Последнее обновление:';

  @override
  String get contactUs => 'Свяжитесь с нами';

  @override
  String get appDescription =>
      'Это приложение объединяет все предложения по отдыху в Кыргызстане от надежных организаторов.';

  @override
  String get withUsYouGet => 'С нами вы получаете: ';

  @override
  String get timeSavingTitle => 'Экономия времени: ';

  @override
  String get timeSavingDescription =>
      'Все актуальные туры на любую дату теперь собраны в одной удобной ленте. Не тратьте больше часы на поиск в социальных сетях.';

  @override
  String get safetyAndTrustTitle => 'Безопасность и доверие: ';

  @override
  String get safetyAndTrustDescription =>
      'Мы сотрудничаем только с надежными партнерами. Вы можете ознакомиться с честными отзывами и рейтингами перед тем, как сделать выбор.';

  @override
  String get simplicityAndConvenienceTitle => 'Простота и удобство: ';

  @override
  String get simplicityAndConvenienceDescription =>
      'Бронируйте и оплачивайте туры онлайн в приложении за несколько кликов.';

  @override
  String get myTickets => 'Мои билеты';

  @override
  String get appTheme => 'Тема приложения';

  @override
  String get profile => 'Профиль';

  @override
  String get appLanguage => 'Язык приложения';

  @override
  String get shareApp => 'Поделиться';

  @override
  String get logOut => 'Выйти';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get version => 'Версия: ';

  @override
  String get partnerVerificationTitle => 'Верификация';

  @override
  String get companyNameLabel => 'Название компании';

  @override
  String get companyNameHint => 'Например, ООО \"Турклуб\"';

  @override
  String get descriptionLabel => 'Описание';

  @override
  String get descriptionHint => 'Например, Мы предлагаем туры в горы, в лес, в пустыню и т.д.';

  @override
  String get cardNumberLabel => 'Номер карты';

  @override
  String get cardNumberHint => 'XXXX XXXX XXXX XXXX';

  @override
  String get attachDocumentsTitle => 'Прикрепите документы или фотографии документов';

  @override
  String get realPhotoHint => 'Пожалуйста, приложите реальное фото документа';

  @override
  String get documentChip => 'Документ';

  @override
  String get chooseFilesButton => 'Выбрать файл';

  @override
  String get takePhotoButton => 'Сделать фото';

  @override
  String get termsAgreement => 'Я согласен с условием использования и обработки персональных данных';

  @override
  String get submitForVerification => 'Отправить на проверку';

  @override
  String get companyNameRequired => 'Название компании обязательно';

  @override
  String get descriptionRequired => 'Описание обязательно';

  @override
  String get cardNumberRequired => 'Номер карты должен содержать 16 цифр';

  @override
  String get documentsRequired => 'Необходимо приложить документы';

  @override
  String get termsRequired => 'Необходимо согласиться с условиями';

  @override
  String get validationError => 'Ошибка валидации';

  @override
  String get error => 'Ошибка';

  @override
  String get somethingWentWrong => 'Что-то пошло не так';

  @override
  String get pleaseTryLater => 'Пожалуйста, попробуйте позже или свяжитесь с поддержкой';

  @override
  String get search => 'Поиск';

  @override
  String totalAmount(Object amount) {
    return 'Итоговая сумма: $amount';
  }

  @override
  String get failedToLoadTickets => 'Не удалось загрузить билеты';

  @override
  String get failedToLoadNextPage => 'Не удалось загрузить следующую страницу';

  @override
  String get checkInternetConnection => 'Проверьте подключение к интернету';

  @override
  String get retry => 'Повторить';

  @override
  String get tourBooked => 'Ваш тур забронирован!';

  @override
  String get myTour => 'Мой тур';

  @override
  String pay(Object amount) {
    return 'Оплатить $amount';
  }

  @override
  String get whatIsIncluded => 'Что включено';

  @override
  String get whatIsNotIncluded => 'Не включено';

  @override
  String get tourProgram => 'Программа тура';

  @override
  String get description => 'Описание';

  @override
  String get gatheringPlace => 'Место сбора';

  @override
  String get hide => 'Скрыть';

  @override
  String get showMore => 'Показать больше';

  @override
  String get reviews => 'Отзывы';

  @override
  String get noReviewsYet => 'Пока нет отзывов';

  @override
  String get anonymousUser => 'Анонимный пользователь';

  @override
  String get failedToLoadReviews => 'Произошла ошибка при загрузке отзывов.';

  @override
  String get tourOrganizer => 'Организатор тура';

  @override
  String get bookTour => 'Забронировать';

  @override
  String get welcome => 'Добро пожаловать!';

  @override
  String get signIn => 'Войти';

  @override
  String get signInGoogle => 'Войти через Google';

  @override
  String get signInApple => 'Войти через Apple';

  @override
  String get verify => 'Проверить';

  @override
  String get enterCode => 'Введите код';

  @override
  String get enter6Digits => 'Введите 6 цифр';

  @override
  String get resendCode => 'Отправить повторно';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерея';

  @override
  String get delete => 'Удалить';

  @override
  String get deletePhoto => 'Удалить фото';

  @override
  String get fieldRequired => 'Поле обязательно для заполнения';

  @override
  String get statusPending => 'Ожидает подтверждения';

  @override
  String get statusConfirmed => 'Подтверждено';

  @override
  String get statusPaid => 'Оплачено';

  @override
  String get statusCompleted => 'Завершен';

  @override
  String get statusCancelled => 'Отменено';

  @override
  String get statusUnknown => 'Неизвестно';

  @override
  String get dateAndTime => 'Дата и время: ';

  @override
  String get seatsCount => 'Количество мест: ';

  @override
  String get total => 'Итого';

  @override
  String get statusLabel => 'Статус: ';

  @override
  String get noTickets => 'У вас пока нет билетов';

  @override
  String get contactDetails => 'Контактные данные';

  @override
  String get fullName => 'ФИО';

  @override
  String get guests => 'Гости';

  @override
  String get noToursFound => 'Туры не найдены';

  @override
  String get adjustSearch => 'Попробуйте изменить параметры поиска';

  @override
  String get failedToLoadTours => 'Не удалось загрузить туры';

  @override
  String get filtersTitle => 'Фильтры';

  @override
  String get reset => 'Сбросить';

  @override
  String get locationLabel => 'Местоположение';

  @override
  String get locationHint => 'Город, регион...';

  @override
  String get tourTypeLabel => 'Тип тура';

  @override
  String get tourTypeHint => 'Например, хайкинг, сафари';

  @override
  String get dateRangeLabel => 'Диапазон дат';

  @override
  String get dateFromLabel => 'От';

  @override
  String get dateToLabel => 'До';

  @override
  String get priceRangeLabel => 'Цена (мин - макс)';

  @override
  String get minHint => 'Мин';

  @override
  String get maxHint => 'Макс';

  @override
  String get sortByLabel => 'Сортировать по';

  @override
  String get sortDateAsc => 'Дата ↑';

  @override
  String get sortDateDesc => 'Дата ↓';

  @override
  String get sortPriceAsc => 'Цена ↑';

  @override
  String get sortPriceDesc => 'Цена ↓';

  @override
  String get sortRatingDesc => 'Рейтинг ↓';

  @override
  String get apply => 'Применить';

  @override
  String get invalidDateRange => 'Неверный диапазон дат';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get notSpecified => 'Не указано';

  @override
  String get profileInfoSubtitle => 'Фото профиля, имя, описание';

  @override
  String get becomeOrganizerTitle => 'Стать туроператором';

  @override
  String get becomeOrganizerAction => 'Стать организатором';

  @override
  String get deleteAccountTitle => 'Удалить аккаунт';

  @override
  String get deleteAccountConfirmation =>
      'Вы уверены, что хотите удалить свой аккаунт? Это действие необратимо, и все ваши данные будут удалены навсегда.';

  @override
  String get logoutTitle => 'Выйти из аккаунта';

  @override
  String get logoutConfirmation => 'Вы уверены, что хотите выйти из своего аккаунта?';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get profileUpdatedSuccess => 'Профиль успешно обновлен';

  @override
  String get nameLabel => 'Имя';

  @override
  String get phoneLabel => 'Номер телефона';

  @override
  String get notSpecifiedEmail => 'Не указан';

  @override
  String get roleUpgradeTitle => 'Стать организатором';

  @override
  String get roleUpgradeDescription =>
      'После смены роли на организатора вам будут недоступны функции клиента. Вы сможете создавать и управлять турами, но не сможете бронировать туры как клиент.';

  @override
  String get searchTours => 'Поиск туров';

  @override
  String get email => 'Электронная почта';

  @override
  String get tourFallback => 'Тур';

  @override
  String reviewsCountParam(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return '($countString отзывов)';
  }

  @override
  String get noTitle => 'Без названия';

  @override
  String get edit => 'Редактировать';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get currencySom => 'сом';

  @override
  String get seats => 'Мест';

  @override
  String get noToursYet => 'У вас пока нет туров';

  @override
  String get createFirstTourAction => 'Создайте свой первый тур и начните принимать бронирования';

  @override
  String get failedToLoadToursTitle => 'Не удалось загрузить туры';

  @override
  String get checkInternetAndTryAgain => 'Проверьте подключение к интернету и попробуйте снова';

  @override
  String get statusActive => 'Активный';

  @override
  String get statusDraft => 'Черновик';

  @override
  String get toMain => 'Перейти на главную';

  @override
  String get participantsCount => 'Участников';

  @override
  String get amountPaid => 'Сумма оплачено';

  @override
  String get noBookingsForTour => 'Пока нет бронирований для этого тура';

  @override
  String get bookingStatusPendingShort => 'Ожидает';

  @override
  String get bookingStatusConfirmedShort => 'Подтверждено';

  @override
  String get bookingStatusPaidShort => 'Оплачено';

  @override
  String get bookingStatusCompletedShort => 'Завершено';

  @override
  String get bookingStatusCancelledShort => 'Отменено';

  @override
  String get bookingStatusUnknownShort => 'Неизвестно';

  @override
  String get documentUploaded => 'Документ загружен';

  @override
  String get ipCertificateScan => 'Скан свидетельства ИП';

  @override
  String get uploadIpCertificateHint =>
      'Пожалуйста, загрузите скан вашего ИП свидетельства в хорошем качестве. Документ также можно взять в приложении Tunduk.';

  @override
  String get verificationCongratulations => 'Поздравляем!';

  @override
  String get verificationRejectedTitle => 'Заявка отклонена';

  @override
  String get verificationPendingTitle => 'Заявка на рассмотрении';

  @override
  String get verificationApprovedDesc => 'Ваша заявка одобрена. Теперь вы стали партнером и можете создавать туры.';

  @override
  String get verificationRejectedDescDefault =>
      'Ваша заявка была отклонена модератором. Пожалуйста, исправьте данные и отправьте снова.';

  @override
  String verificationRejectedReason(Object reason) {
    return 'Причина отклонения: $reason';
  }

  @override
  String get verificationPendingDesc =>
      'Ваша заявка на верификацию отправлена и находится на проверке. Рассмотрение занимает от 1 до 2 рабочих дней.';

  @override
  String get date => 'Дата';

  @override
  String get availableSpots => 'Осталось мест';

  @override
  String get bookingDetailsTitle => 'Детали бронирования';

  @override
  String get whatsappNumberHint => 'Укажите номер, к которому привязан WhatsApp';

  @override
  String submittedAt(Object date) {
    return 'Отправлено: $date';
  }

  @override
  String get resubmitRequest => 'Заново отправить заявку';

  @override
  String get updateStatus => 'Обновить статус';
}
