part of 'app_cubit.dart';

enum Role { client, partner }

class AppState extends Equatable {
  const AppState({this.role = Role.client});
  final Role role;

  AppState copyWith({AppTheme? theme, Locale? locale, Role? role}) {
    return AppState(role: role ?? this.role);
  }

  @override
  List<Object?> get props => [role];
}
