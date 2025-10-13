import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(const OtpState());

  Future<void> sendOtp({required String phone}) async {
    emit(state.copyWith(status: OtpStatus.loading, phone: phone));
  }

  Future<void> verifyPin(String pin) async {
    try {
      emit(state.copyWith(status: OtpStatus.loading, error: null));
      emit(state.copyWith(status: OtpStatus.success, error: null));
    } catch (e) {
      final message = (e is Exception) ? e.toString() : 'Unknown error';
      emit(state.copyWith(status: OtpStatus.failure, error: message));
    }
  }
}
