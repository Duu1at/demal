import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class SmsRetrieverImpl implements SmsRetriever {
  SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsRetrieverApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    await smartAuth.getAppSignature();

    final res = await smartAuth.getSmsWithUserConsentApi();
    if (res.hasData) {
      final code = res.requireData.code;
      if (code != null) return code;
    }

    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
