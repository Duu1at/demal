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

  Future<void> checkAuthStatus() async {
    try {
      final token = _repository.getToken();
      final onboardingStatus = _repository.getOnboardingStatus();

      if (token == null) {
        emit(AuthState.unauthenticated(hasCompletedOnboarding: onboardingStatus));
        return;
      }

      emit(
        AuthState.authenticated(
          token,
          hasCompletedOnboarding: onboardingStatus,
        ),
      );
    } on Object catch (e) {
      emit(AuthState.failure(e));
    }
  }

  Future<void> changeRole(RoleEnum role) async {
    await _repository.setRole(role);

    emit(state.copyWith(role: role));
  }

  Future<void> logout() async {
    final onboardingStatus = state.hasCompletedOnboarding;
    await _repository.logOut();
    emit(AuthState.unauthenticated(hasCompletedOnboarding: onboardingStatus));
  }

  Future<void> deleteAccount() async {
    await Future.wait([
      _repository.deleteAccount(),
      _profileRepository.deleteProfileData(),
      _repository.saveOnboardingStatus(false),
    ]);
    emit(const AuthState.unauthenticated(hasCompletedOnboarding: false));
  }

  Future<void> login(UserModel user, String token) async {
    if (!state.hasCompletedOnboarding) {
      await _repository.saveOnboardingStatus(true);
    }

    emit(AuthState.authenticated(token));
  }

  Future<void> completeOnboarding() async {
    await _repository.saveOnboardingStatus(true);
    emit(
      state.copyWith(
        hasCompletedOnboarding: true,
        status: AuthStatus.unauthenticated,
      ),
    );
  }
}
