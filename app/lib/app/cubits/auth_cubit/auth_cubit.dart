import 'dart:async';
import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart' as profile_repo;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository, this._profileRepository) : super(const AuthState.initial());

  final AuthRepository _repository;
  final profile_repo.ProfileRepository _profileRepository;

  Future<void> checkAuthStatus() async {
    try {
      final token = _repository.getToken();
      final userData = _repository.getUserData();
      final onboardingStatus = _repository.getOnboardingStatus();

      if (token == null || userData == null) {
        emit(
          AuthState.unauthenticated(hasCompletedOnboarding: onboardingStatus),
        );
        return;
      }

      emit(
        AuthState.authenticated(
          userData.user,
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
      _repository.saveOnboardingStatus(false),
    ]);
    emit(const AuthState.unauthenticated(hasCompletedOnboarding: false));
  }

  Future<void> login(UserModel user, String token) async {
    if (!state.hasCompletedOnboarding) {
      await _repository.saveOnboardingStatus(true);
    }

    emit(AuthState.authenticated(user, token));
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

  /// Refresh user profile data from server and update auth state
  Future<void> refreshProfile() async {
    try {
      if (state.status != AuthStatus.authenticated) return;

      final profile = await _profileRepository.getProfile();

      // Convert profile UserModel to auth UserModel
      final updatedUser = state.user?.copyWith(
        userId: profile.user.userId,
        phoneNumber: profile.user.phoneNumber,
        fullName: profile.user.fullName,
        role: profile.user.role != null
            ? RoleEnum.values.firstWhere(
                (e) => e.name == profile.user.role,
                orElse: () => RoleEnum.UNKNOWN,
              )
            : null,
        imageUrl: profile.user.imageUrl,
        createdAt: profile.user.createdAt,
        partnerProfile: profile.user.partnerProfile,
      );

      if (updatedUser != null) {
        emit(state.copyWith(user: updatedUser));
      }
    } on Object catch (_) {
      // Silently fail - keep existing state
    }
  }
}
