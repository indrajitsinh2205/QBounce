//
//  WebViewFactory.swift
//  Runner
//
//  Created by Harsh on 20/02/25.
//

import UIKit


class iOSWebViewFactory: NSObject, FlutterPlatformViewFactory {
    
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return iOSWebViewFactoryPlatformView(frame: frame, viewId: viewId, messenger: messenger, arguments: args)
    }
    
}
class iOSWebViewFactoryPlatformView: NSObject, FlutterPlatformView {
    
    private var _view: UIView
    
    init(frame: CGRect,
         viewId: Int64,
         messenger: FlutterBinaryMessenger,
         arguments args: Any?
    ) {
        
//        if let args = args as? [String: Any],
//           let urlString = args["url"] as? String
//        {
            
            let controller = WebViewController(urlString: "https://quietbounce.com/?trafficSource=qbounce.netlify.app")

            self._view = controller.view
            print("Assigned view in widget.")
            
//        }else{
//            _view = UIView(frame: frame)
//            print("Not found any url args in widget.")
//        }
        
        super.init()
    }
    
    func view() -> UIView {
        return _view
    }
        
}
