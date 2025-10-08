part of 'app_cubit.dart';

enum Role { client, partner }

class AppState extends Equatable {
  const AppState({required this.theme, this.locale, this.role = Role.client});
  final AppTheme theme;
  final Locale? locale;
  final Role role;

  AppState copyWith({AppTheme? theme, Locale? locale, Role? role}) {
    return AppState(
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [theme, locale, role];
}
