import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_universal_links.dart';

typedef OnLinkFunction = void Function(Uri uri);
typedef LinkValidation = Future<bool> Function(Uri uri);

class UniversalLinksInterface extends PlatformInterface {
  static const _token = Object();
  static UniversalLinksInterface _instance = MethodChannelUniversalLink();
  static UniversalLinksInterface get instance => _instance;

  UniversalLinksInterface() : super(token: _token);

  static set instance(UniversalLinksInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Callback when your app is woke up by an incoming link
  /// [uri] and [stringUri] are same value.
  void onAppLink({required OnLinkFunction onAppLink}) =>
      throw UnimplementedError(
        'onAppLink not implemented on the current platform.',
      );

  /// set the url patten
  void setUrlPatten(String urlPatten) => throw UnimplementedError(
        'setUrlPatten not implemented on the current platform.',
      );

  /// Gets the initial / first link
  /// returns [Uri] or [null]
  Future<Uri?> getInitialAppLink() => throw UnimplementedError(
        'getInitialAppLink() not implemented on the current platform.',
      );

  /// Gets the latest link
  /// returns [Uri] or [null]
  Future<Uri?> getLatestAppLink() => throw UnimplementedError(
        'getLatestAppLink not implemented on the current platform.',
      );
}
