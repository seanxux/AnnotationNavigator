//
//  URLNavigationMap.swift
//  AnnotationNavigator
//
//  Created by SeanXu on 16/12/2017.
//  Copyright © 2017 SeanXu. All rights reserved.
//

import UIKit
import URLNavigator

// Global Router
let navigator = Navigator()

struct NavigatorMap {
    static var scheme = ""
    static var host = ""
    
    init() {
        guard let urlTypes = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [[String: Any]],
            !urlTypes.isEmpty else {
                fatalError("You need config url scheme in project setting")
        }
        for type in urlTypes {
            if let isNavigator = type["Navigator"] as? Bool, isNavigator {
                if let host = type["CFBundleURLName"] as? String, !host.isEmpty {
                    NavigatorMap.host = host
                } else {
                    fatalError("You need config url scheme in project setting")
                }
                if let schemes = type["CFBundleURLSchemes"] as? [String],
                    let scheme = schemes.first, !scheme.isEmpty {
                    NavigatorMap.scheme = scheme
                } else {
                    fatalError("You need config url scheme in project setting")
                }
            }
        }
    }
    
    func initialize() {
        registerGenerated(navigator: navigator)
        registerCustom(navigator: navigator)
    }
    
    // Class Controller factory
    private func classViewControllerFactory<T: UIViewController>(_: T.Type) -> URLNavigator.ViewControllerFactory {
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
    private func nibViewControllerFactory<T: UIViewController>(_: T.Type) -> URLNavigator.ViewControllerFactory {
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
