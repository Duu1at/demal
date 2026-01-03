import 'dart:async';
import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  }) : _authRepository = authRepository,
       _profileRepository = profileRepository,
       super(const AuthState.initial());

  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  Future<void> checkUser() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final token = _authRepository.getToken();
      if (token == null) {
        emit(const AuthState.unauthenticated());
        return;
      }
      var user = _profileRepository.getProfileFromLocal();
      user ??= await _profileRepository.getProfile();
      emit(AuthState.authenticated(user, token));
    } on Object catch (_) {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> logout() async {
    await _authRepository.logOut();
    emit(const AuthState.unauthenticated());
  }

  Future<void> deleteAccount() async {
    await Future.wait([
      _authRepository.deleteAccount(),
      _profileRepository.deleteProfileData(),
    ]);
    emit(const AuthState.unauthenticated());
  }

  void updateUser(UserModel user) {
    if (state.status == AuthStatus.authenticated) {
      emit(state.copyWith(user: user));
    }
  }
}
