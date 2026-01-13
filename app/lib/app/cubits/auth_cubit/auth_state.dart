part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

final class AuthState extends Equatable {
  const AuthState({
    required this.status,
    required this.user,
    this.token,
  });

  const AuthState.initial() : this(status: AuthStatus.initial, user: const UserModel.empty());

  const AuthState.authenticated(UserModel user, String token)
    : this(
        status: AuthStatus.authenticated,
        user: user,
        token: token,
      );

  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated, user: const UserModel.empty());

  final AuthStatus status;
  final UserModel user;
  final String? token;

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? token,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [status, user, token];
}
