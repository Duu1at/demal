import 'package:app/features/features.dart';

class OtpArgs {
  const OtpArgs({
    required this.email,
    required this.otpCubit,
  });

  final String email;
  final OtpCubit otpCubit;
}
