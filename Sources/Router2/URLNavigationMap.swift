//
//  URLNavigationMap.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 16/12/2017.
//  Copyright © 2017 GuoXiaoMei. All rights reserved.
//

import Foundation
import URLNavigator

// 全局Router
let navigator = Navigator()

struct URLNavigationMap {
    // 注册Router
    static func initialize(navigator: NavigatorType) {
        // Weex
//        navigator.register(.weex) { _, _, context in
//            guard let router = context as? Router,
//                case let .weex(pageTitle, url, param) = router.parameter else {
//                    return nil
//            }
//            let weexParam = param ?? router.context
//            let viewController = CRMWeexViewController(pageTitle: pageTitle, url: url, param: weexParam)
//            viewController.hidesBottomBarWhenPushed = true
//            return viewController
//        }
    }
    
    // Class Controller工厂
    private static func classViewControllerFactory<T: UIViewController>(_: T.Type) -> URLNavigator.ViewControllerFactory {
        return { (url: URLConvertible, values: [String: Any], context: Any?) -> T? in
            guard url.urlValue != nil else { return nil }
            let viewController = T()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
    }
    
    // Nib Controller工厂
    private static func nibViewControllerFactory<T: UIViewController>(_: T.Type) -> URLNavigator.ViewControllerFactory {
        return { (url: URLConvertible, values: [String: Any], context: Any?) -> T? in
            guard url.urlValue != nil else { return nil }
            let className = NSStringFromClass(T.self).components(separatedBy: ".").last!
            let viewController = T(nibName: className, bundle: nil)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
    }
    
    // Web Controller工厂
    private static func webViewControllerFactory(url: URLConvertible, values _: [String: Any], context: Any?) -> UIViewController? {
        guard let router = context as? Router,
            case let .web(url) = router.parameter else {
                return nil
        }
        let webViewController = WebViewController(url: url)
        webViewController.hidesBottomBarWhenPushed = true
        return webViewController
    }

//    // 切换Tab
//    private static func switchToTabIndex(_ index: Int) {
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            if let mainViewController = appDelegate.mainRootVC {
//                mainViewController.selectedIndex = index
//            }
//        }
//    }
}
