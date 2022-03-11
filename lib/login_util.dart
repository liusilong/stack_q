import 'package:flutter/services.dart';

/// author: Liusilong
/// date: 2022/3/11
/// desc:
//

class LoginUtil {
  LoginUtil() {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  final MethodChannel _channel = const MethodChannel('my-channel');

  Function(String, int)? _loginSuccessCallback;

  Future<void> login(String name, int age, {Function(String, int)? callback}) async {
    _loginSuccessCallback = callback;
    var params = {'name': name, 'age': age};
    // call native method 'login'
    await _channel.invokeMethod('login', params);
  }

  Future<dynamic> _methodCallHandler(MethodCall call) async {
    String method = call.method;
    if (method == 'loginSuccess') {
      if (_loginSuccessCallback != null) {
        final map = call.arguments;
        _loginSuccessCallback?.call(map['name'] as String, map['age'] as int);
      }
    }
  }
}
