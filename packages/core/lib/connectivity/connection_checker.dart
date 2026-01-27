import 'package:api_client/api_client.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

@immutable
final class ConnectionChecker {
  const ConnectionChecker(this.connectivity);
  final Connectivity connectivity;

  Future<bool> checkInternetConnection() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      return isConnected(connectivityResult);
    } on Object catch (e, s) {
      throw ConnectionException(e, s);
    }
  }

  bool isConnected(List<ConnectivityResult> result) {
    return result.any(
      (element) =>
          element == ConnectivityResult.mobile ||
          element == ConnectivityResult.ethernet ||
          element == ConnectivityResult.wifi,
    );
  }
}
