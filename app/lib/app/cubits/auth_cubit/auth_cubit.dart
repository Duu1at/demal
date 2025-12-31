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
  }) : _repository = authRepository,
       _profileRepository = profileRepository,
       super(const AuthState.initial());

  final AuthRepository _repository;
  final ProfileRepository _profileRepository;

  Future<void> logIn() async {
    try {
      var user = _profileRepository.getProfileFromLocal();
      user ??= await _profileRepository.getProfile();
      final token = _repository.getToken();
      if (token == null) {
        emit(const AuthState.unauthenticated());
        return;
      }
      emit(AuthState.authenticated(user, token));
    } on Object catch (e) {
      emit(AuthState.failure(e));
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> logout() async {
    await _repository.logOut();
    emit(const AuthState.unauthenticated());
  }

  Future<void> deleteAccount() async {
    await Future.wait([
      _repository.deleteAccount(),
      _profileRepository.deleteProfileData(),
    ]);
    emit(const AuthState.unauthenticated());
  }
}
