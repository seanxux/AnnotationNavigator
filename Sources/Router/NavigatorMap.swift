//
//  URLNavigationMap.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 16/12/2017.
//  Copyright © 2017 GuoXiaoMei. All rights reserved.
//

import UIKit
import URLNavigator

// Global Router
let navigator = Navigator()

struct NavigatorMap {
    
    static func initialize() {
        NavigatorMap.initializeGenerated(navigator: navigator)
        NavigatorMap.initializeCustom(navigator: navigator)
    }
    
    // Regist custom Router
    static func initializeCustom(navigator: NavigatorType) {
    }
    
    // Class Controller factory
    private static func classViewControllerFactory<T: UIViewController>(_: T.Type) -> URLNavigator.ViewControllerFactory {
        return { (url: URLConvertible, values: [String: Any], context: Any?) -> T? in
            guard url.urlValue != nil else { return nil }
            let viewController = T()
            #if os(iOS)
            viewController.hidesBottomBarWhenPushed = true
            #endif
            return viewController
        }
    }
    
    // Nib controller factory
    private static func nibViewControllerFactory<T: UIViewController>(_: T.Type) -> URLNavigator.ViewControllerFactory {
        return { (url: URLConvertible, values: [String: Any], context: Any?) -> T? in
            guard url.urlValue != nil else { return nil }
            let className = NSStringFromClass(T.self).components(separatedBy: ".").last!
            let viewController = T(nibName: className, bundle: nil)
            #if os(iOS)
            viewController.hidesBottomBarWhenPushed = true
            #endif
            return viewController
        }
    }
}
