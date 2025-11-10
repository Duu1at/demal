
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

@immutable
final class NetworkClient {
  NetworkClient({Connectivity? connectivity}) : connectivity = connectivity ?? Connectivity();

  final Connectivity connectivity;

  Future<bool> checkInternetConnection() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult.any(
      (element) =>
          element == ConnectivityResult.mobile ||
          element == ConnectivityResult.ethernet ||
          element == ConnectivityResult.wifi,
    );
  }
}
