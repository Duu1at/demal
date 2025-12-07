import 'package:core/core.dart';

final class ValidationException extends AppException<String> {
  const ValidationException(super.error);

  @override
  ErrorModel getModel() {
    return ErrorModel(
      title: 'Ошибка валидации',
      message: error,
    );
  }

  @override
  String getUiMessage() => error;
}
