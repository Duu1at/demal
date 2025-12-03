import 'package:app/features/features.dart';

class OtpArgs {
  const OtpArgs({
    required this.phoneNumber,
    required this.otpCubit,
  });

  final String phoneNumber;
  final OtpCubit otpCubit;
}
