import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    var webView : WKWebView!
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        connectBinaryControllerChannel()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate {
    
    func connectBinaryControllerChannel(){
        
        let controller = window?.rootViewController as! FlutterViewController
        
        let webViewFactory = iOSWebViewFactory(messenger: controller.binaryMessenger)
        registrar(forPlugin: "iOSWebViewFactory")?.register(webViewFactory, withId: "ios_webview")
        
        
    }
    
}
