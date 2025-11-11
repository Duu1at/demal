abstract final class Env {
  static const baseUrl = String.fromEnvironment(
    'DEFINEEXAMPLE_BASE_URL',
    defaultValue: 'http://83.217.223.86:3000',
  );
}
