final class Env {
  static const baseUrl = String.fromEnvironment(
    'DEFINEEXAMPLE_BASE_URL',
    defaultValue: 'http://localhost:3000/api/v1',
  );
}
