part of 'otp_cubit.dart';

enum OtpStatus { initial, loading, success, failure }

class OtpState extends Equatable {
  const OtpState({this.status = OtpStatus.initial, this.exception});

  final OtpStatus status;
  final Exception? exception;

  OtpState copyWith({OtpStatus? status, Exception? exception, String? phone}) {
    return OtpState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [status, exception];
}
