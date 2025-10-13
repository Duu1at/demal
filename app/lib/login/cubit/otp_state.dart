part of 'otp_cubit.dart';

enum OtpStatus { initial, loading, success, failure }

class OtpState extends Equatable {
  const OtpState({this.status = OtpStatus.initial, this.error, this.phone});

  final OtpStatus status;
  final String? error;
  final String? phone;

  OtpState copyWith({OtpStatus? status, String? error, String? phone}) {
    return OtpState(
      status: status ?? this.status,
      error: error,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [status, error, phone];
}
