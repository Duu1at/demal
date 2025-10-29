import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.repository) : super(const OtpState());

  final AuthRepository repository;

  Future<void> sendOtp(String phoneNumber) async {
    emit(state.copyWith(status: OtpStatus.loading));
    try {
      await repository.sendOtp(phoneNumber);
      emit(state.copyWith(status: OtpStatus.success, phone: phoneNumber));
    } catch (e) {
      emit(
        state.copyWith(
          status: OtpStatus.failure,
          exception: Exception(e.toString()),
        ),
      );
    }
  }

  Future<void> verifyOtpCode({
    required String phoneNumber,
    required String pin,
  }) async {
    emit(state.copyWith(status: OtpStatus.loading));
    try {
      await repository.verifyOtp(phoneNumber, pin);
      emit(state.copyWith(status: OtpStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: OtpStatus.failure,
          exception: Exception(e.toString()),
        ),
      );
    }
  }
}
