part of 'auth_cubit.dart';

final class AuthState extends Equatable {
  const AuthState({this.user, this.token});

  final User? user;
  final String? token;

  bool get isFirstTime => token == null;

  Role get role => user?.role ?? Role.client;

  AuthState copyWith({User? user, String? token, bool? isNewUser}) {
    return AuthState(user: user ?? this.user, token: token ?? this.token);
  }

  @override
  List<Object?> get props => [user, token];
}

class User extends Equatable {
  const User({
    this.imageUrl,
    this.role,
    this.phoneNumber,
    this.isNewUser = false,
  });

  final String? imageUrl;
  final Role? role;
  final String? phoneNumber;
  final bool isNewUser;

  User copyWith({
    String? imageUrl,
    Role? role,
    String? phoneNumber,
    bool? isNewUser,
  }) {
    return User(
      imageUrl: imageUrl ?? this.imageUrl,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
