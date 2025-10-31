part of 'auth_cubit.dart';


final class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.user,
    this.token,
    this.errorMessage,
  });

  const AuthState.initial() : this(status: AuthStatus.initial);

  const AuthState.authenticated(UserModel user, String token)
      : this(status: AuthStatus.authenticated, user: user, token: token);


  const AuthState.unauthenticated()
      : this(status: AuthStatus.unauthenticated);

  const AuthState.failure(Object message)
      : this(status: AuthStatus.failure, errorMessage: message);

  final AuthStatus status;
  final UserModel? user;
  final String? token;
  final Object? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? token,
    Object? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, token, errorMessage];
}

enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  failure,
}

