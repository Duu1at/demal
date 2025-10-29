import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.repository) : super(const OtpState());

  final AuthRepository repository;

  Future<void> sendOtp(String phoneNumber) async {
    try {
      emit(state.copyWith(status: OtpStatus.loading));
      final response = await repository.sendOtp(phoneNumber);
      emit(state.copyWith(status: OtpStatus.success));
    } catch (e) {
      emit(state.copyWith(status: OtpStatus.failure, error: e.toString()));
    }
  }

  Future<void> verifyPin({
    required String phoneNumber,
    required String pin,
  }) async {
    try {
      emit(state.copyWith(status: OtpStatus.loading));
      final response = await repository.verifyOtp(phoneNumber, pin);
      emit(state.copyWith(status: OtpStatus.success));
    } catch (e) {
      final message = (e is Exception) ? e.toString() : 'Unknown error';
      emit(state.copyWith(status: OtpStatus.failure, error: message));
    }
  }
}
