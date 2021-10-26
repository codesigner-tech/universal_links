import 'src/universal_links_interface.dart';

class UniversalLinks extends UniversalLinksInterface {
  UniversalLinks({
    required OnLinkFunction onAppLink,
    String? urlPatten,
  }) {
    UniversalLinksInterface.instance.onAppLink(onAppLink: onAppLink);
    if (urlPatten != null) {
      UniversalLinksInterface.instance.setUrlPatten(urlPatten);
    }
  }

  @override
  Future<Uri?> getInitialAppLink() {
    return UniversalLinksInterface.instance.getInitialAppLink();
  }

  @override
  Future<Uri?> getLatestAppLink() async {
    return UniversalLinksInterface.instance.getLatestAppLink();
  }

  @override
  void onAppLink({required onAppLink}) {
    UniversalLinksInterface.instance.onAppLink(onAppLink: onAppLink);
  }
}
