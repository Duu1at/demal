final class Api {
  static const baseUrl = String.fromEnvironment(
    'DEFINEEXAMPLE_BASE_URL',
    defaultValue: 'http://localhost:3000/api/v1',
  );
}
