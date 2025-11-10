part of 'otp_cubit.dart';

class OtpState extends Equatable {
  const OtpState({
    this.sendStatus = const RequestInitial(),
    this.verifyStatus = const RequestInitial(),
    this.remainingSeconds = 4,
  });

  final RequestStatus<void> sendStatus;
  final RequestStatus<AuthLoginModel> verifyStatus;
  final num remainingSeconds;

  OtpState copyWith({
    RequestStatus<void>? sendStatus,
    RequestStatus<AuthLoginModel>? verifyStatus,
    num? remainingSeconds,
  }) {
    return OtpState(
      sendStatus: sendStatus ?? this.sendStatus,
      verifyStatus: verifyStatus ?? this.verifyStatus,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }

  @override
  List<Object?> get props => [sendStatus, verifyStatus, remainingSeconds];
}
