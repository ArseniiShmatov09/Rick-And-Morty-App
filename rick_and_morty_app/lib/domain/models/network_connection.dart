import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnection extends ChangeNotifier {
  bool _isOffline = false;
  bool get isOffline => _isOffline;

  NetworkConnection() {
    _checkInternetConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectivityStatus(result);
    });
  }

  Future<void> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(connectivityResult);
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _isOffline = true;
    } else {
      _isOffline = false;
    }
    notifyListeners();
  }

  Future<void> reload() async {
    await _checkInternetConnection();
  }
}
