part of 'auth_cubit.dart';

final class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.user,
    this.token,
    this.errorMessage,
    this.hasCompletedOnboarding = false,
    this.role,
  });

  const AuthState.initial() : this(status: AuthStatus.initial);

  const AuthState.authenticated(
    String token, {
    bool hasCompletedOnboarding = true,
  }) : this(
         status: AuthStatus.authenticated,
         token: token,
         hasCompletedOnboarding: hasCompletedOnboarding,
       );

  const AuthState.unauthenticated({bool hasCompletedOnboarding = true})
    : this(
        status: AuthStatus.unauthenticated,
        hasCompletedOnboarding: hasCompletedOnboarding,
      );

  const AuthState.failure(Object message) : this(status: AuthStatus.failure, errorMessage: message);

  final AuthStatus status;
  final UserModel? user;
  final String? token;
  final Object? errorMessage;
  final bool hasCompletedOnboarding;
  final RoleEnum? role;

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? token,
    Object? errorMessage,
    bool? hasCompletedOnboarding,
    RoleEnum? role,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
    token,
    errorMessage,
    hasCompletedOnboarding,
    role,
  ];
}

enum AuthStatus { initial, authenticated, unauthenticated, failure }
