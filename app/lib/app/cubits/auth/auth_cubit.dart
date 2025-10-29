import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repository)
    : super(
        AuthState(
          user: User(
            imageUrl: repository.getUserData()?.user.imageUrl,
            isNewUser: repository.getUserData()?.isNewUser ?? false,
            role: repository.getUserData()?.user.role,
          ),
          token: repository.getToken(),
        ),
      );

  final AuthRepository repository;

  void changeRole(Role role) {
    emit(state.copyWith(user: state.user?.copyWith(role: role)));
  }
}
