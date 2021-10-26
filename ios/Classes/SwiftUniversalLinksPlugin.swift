import Flutter
import UIKit

public class SwiftUniversalLinksPlugin: NSObject, FlutterPlugin {

  fileprivate var methodChannel: FlutterMethodChannel
  fileprivate var initialLink: String?
  fileprivate var latestLink: String?
  fileprivate var urlPatten: String?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(name: "tech.codesigner.universal_links/messages", binaryMessenger: registrar.messenger())
    let instance = SwiftUniversalLinksPlugin(methodChannel: methodChannel)
    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    registrar.addApplicationDelegate(instance)
  }

  init(methodChannel: FlutterMethodChannel) {
    self.methodChannel = methodChannel
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "getInitialAppLink":
        result(initialLink)
        break
      case "getLatestAppLink":
        result(latestLink)
        break
      case "setUrlPatten":
        urlPatten = (call.arguments as! [String: String])["urlPatten"]
        break
      default:
        result(FlutterMethodNotImplemented)
        break
    }
  }

  // Universal Links
  public func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([Any]) -> Void) -> Bool {

    switch userActivity.activityType {
      case NSUserActivityTypeBrowsingWeb:
        guard let url = userActivity.webpageURL else {
          return false
        }
        return handleLink(url: url)
      default: return false
    }
  }

  // Custom URL schemes
  public func application(
    _ application: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return handleLink(url: url)
  }

  fileprivate func handleLink(url: URL) -> Bool {
    debugPrint("iOS handleLink: \(url.absoluteString)")
    if (initialLink == nil) {
      initialLink = url.absoluteString
    }
    latestLink = url.absoluteString
    if(urlPatten != nil && latestLink != nil){
      do{
        let regex = try NSRegularExpression(pattern: urlPatten!, options: NSRegularExpression.Options.caseInsensitive)
        let res = regex.matches(in: latestLink!, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, latestLink!.count))
        debugPrint("regex.matches: \(res.count)")
        if(res.count > 0) {
          return false
        }
      } catch {

      }
    }
    methodChannel.invokeMethod("onAppLink", arguments: latestLink)
    return true
  }
}
