import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/models/request_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.repository) : super(const OtpState());

  final AuthRepository repository;
  Timer? _timer;

  Future<void> sendOtp(String phoneNumber) async {
    emit(state.copyWith(sendStatus: RequestLoading()));
    try {
      await repository.sendOtp(phoneNumber);
      emit(state.copyWith(sendStatus: const RequestSuccess(null)));
      startTimer();
    } on Object catch (e) {
      emit(
        state.copyWith(sendStatus: RequestFailure(e)),
      );
    }
  }

  Future<void> verifyOtpCode({
    required String phoneNumber,
    required String pin,
  }) async {
    emit(state.copyWith(verifyStatus: RequestLoading()));
    try {
    final res= await repository.verifyOtp(phoneNumber, pin);
      emit(state.copyWith(verifyStatus:  RequestSuccess<AuthLoginModel>(res)));
    } on Object catch (e) {
      emit(state.copyWith(verifyStatus: RequestFailure(e)));
    }
  }

  void startTimer() {
    _timer?.cancel();
    int seconds = 4;
    emit(state.copyWith(remainingSeconds: seconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds--;
      emit(state.copyWith(remainingSeconds: seconds));
      if (seconds <= 0) {
        _timer?.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
