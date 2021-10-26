import 'package:flutter/services.dart';

import 'universal_links_interface.dart';

class MethodChannelUniversalLink extends UniversalLinksInterface {
  /// Method channel name
  static const String _messagesChannel =
      'tech.codesigner.universal_links/messages';

  /// Channel handler
  static const MethodChannel _channel = MethodChannel(_messagesChannel);

  /// List of methods called by [MethodChannel]
  ///
  /// Callback when your app is woke up by an incoming link
  static const String _onAppLinkMethod = 'onAppLink';

  /// [getInitialAppLink] method call name
  static const String _getInitialAppLinkMethod = 'getInitialAppLink';

  /// [setUrlPatten] method call name
  static const String _setUrlPatten = 'setUrlPatten';

  /// [getLatestAppLink] method call name
  static const String _getLatestAppLinkMethod = 'getLatestAppLink';

  @override
  void onAppLink({required OnLinkFunction onAppLink}) {
    _channel.setMethodCallHandler(
      (call) {
        switch (call.method) {
          case _onAppLinkMethod:
            if (call.arguments != null) {
              final uri = call.arguments.toString();
              onAppLink(Uri.parse(uri));
            }
        }
        return Future.value();
      },
    );
  }

  @override
  Future<Uri?> getInitialAppLink() async {
    final result = await _channel.invokeMethod(_getInitialAppLinkMethod);
    if (result == null) return null;
    return Uri.tryParse(result);
  }

  @override
  void setUrlPatten(String urlPatten) async {
    await _channel.invokeMethod(_setUrlPatten, {"urlPatten": urlPatten});
  }

  @override
  Future<Uri?> getLatestAppLink() async {
    final result = await _channel.invokeMethod(_getLatestAppLinkMethod);
    if (result == null) return null;
    return Uri.tryParse(result);
  }
}
