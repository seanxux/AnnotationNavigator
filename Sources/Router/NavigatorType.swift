//
//  NavigatorType.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 16/12/2017.
//  Copyright © 2017 SeanXu. All rights reserved.
//

import Foundation
import URLNavigator

extension NavigatorType {
    func register(_ router: RouterType, _ factory: @escaping URLNavigator.ViewControllerFactory) {
        register(router.url, factory)
    }
    
    func handle(_ router: RouterType, _ factory: @escaping URLOpenHandlerFactory) {
        handle(router.url, factory)
    }
    
    @discardableResult
    public func push(_ router: Router) -> UIViewController? {
        // switch tab index
        if let tabIndex = router.tabIndex {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                if let mainViewController = appDelegate.mainRootVC {
                    if let navigationController = mainViewController.selectedViewController as? UINavigationController {
                        navigationController.popToRootViewController(animated: false)
                    }
                    mainViewController.selectedIndex = tabIndex
                }
            }
        }
        return self.push(router.type.url, context: router)
    }
    
    @discardableResult
    public func open(_ url: URL) -> UIViewController? {
        if let scheme = url.scheme, scheme == Router.scheme,
            let router = Router(url.absoluteString) {
            if router.isPresent() {
                return navigator.present(router)
            } else {
                return navigator.push(router)
            }
        } else {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
            return nil
        }
    }
    
    @discardableResult
    public func push(_ url: URL) -> UIViewController? {
        if let scheme = url.scheme, scheme == Router.scheme,
            let router = Router(url.absoluteString) {
            return navigator.push(router)
        } else {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
            return nil
        }
    }
    
    @discardableResult
    public func present(_ url: URL, wrap: UINavigationController.Type? = nil) -> UIViewController? {
        if let scheme = url.scheme, scheme == Router.scheme,
            let router = Router(url.absoluteString) {
            return navigator.present(router, wrap: wrap)
        } else {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
            return nil
        }
    }
    
    @discardableResult
    public func present(_ router: Router, wrap: UINavigationController.Type? = nil) -> UIViewController? {
        return self.present(router.type.url, context: router, wrap: wrap)
    }
    
    @discardableResult
    public func push(_ parameter: RouterParameter, from: UINavigationControllerType? = nil, animated: Bool = true) -> UIViewController? {
        let router = Router(parameter)
        return self.pushURL(router.type.url,
                            context: router,
                            from: from,
                            animated: animated)
    }
    
    @discardableResult
    public func present(_ parameter: RouterParameter, context: Any? = nil, wrap: UINavigationController.Type? = nil, from: UIViewControllerType? = nil, animated: Bool = true, completion: (() -> Void)? = nil) -> UIViewController? {
        let router = Router(parameter)
        return self.presentURL(router.type.url,
                               context: router,
                               wrap: wrap,
                               from: from,
                               animated: animated,
                               completion: completion)
    }
    
    @discardableResult
    public func open(_ parameter: RouterParameter, context: Any? = nil) -> Bool {
        let router = Router(parameter)
        return self.openURL(router.type.url, context: router)
    }
}
