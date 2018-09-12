//
//  NavigatorType.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 16/12/2017.
//  Copyright © 2017 GuoXiaoMei. All rights reserved.
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
        // todo switch tab
//        // switch tab index
//        if let tabIndex = router.tabIndex {
//            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                if let mainViewController = appDelegate.mainRootVC {
//                    if let navigationController = mainViewController.selectedViewController as? UINavigationController {
//                        navigationController.popToRootViewController(animated: false)
//                    }
//                    mainViewController.selectedIndex = tabIndex
//                }
//            }
//        }
        return self.push(router.type.url, context: router)
    }
    
    @discardableResult
    public func open(_ url: URL) -> UIViewController? {
        if let scheme = url.scheme, scheme == Router.scheme {
            guard let router = Router(url.absoluteString) else {
                return nil
            }
            if navigator.handler(for: router.type.url) != nil {
                navigator.openURL(router.type.url, context: router)
                return nil
            } else {
                if router.isPresent() {
                    return navigator.present(router, wrap: UINavigationController.self)
                } else {
                    return navigator.push(router)
                }
            }
        } else {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
            return nil
        }
    }
    
    @discardableResult
    public func open(_ url: URL, direct: Bool) -> UIViewController? {
        if let scheme = url.scheme, scheme == Router.scheme {
            guard let router = Router(url.absoluteString) else {
                return nil
            }
            if navigator.handler(for: router.type.url) != nil {
                navigator.openURL(router.type.url, context: router)
                return nil
            } else {
                if direct && handleDirectOpen(router: router) {
                    return nil
                } else {
                    if router.isPresent() {
                        return navigator.present(router, wrap: UINavigationController.self)
                    } else {
                        return navigator.push(router)
                    }
                }
            }
        } else {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
        return nil
    }
    
    // 判断是否在一级页面直接跳转
    public func handleDirectOpen(router: Router) -> Bool {
        let types: [RouterType] = [
            .home, .message, .user
        ]
        if types.contains(router.type) {
            guard let topViewController = UIViewController.topMost,
                let tabBarControllerType = topViewController as? TabBarControllerType,
                tabBarControllerType.inTabBar else {
                return false
            }
            guard let tabBarController = topViewController.tabBarController else {
                return false
            }
            switch router.type {
            case .home:
                tabBarController.selectedIndex = 0
//                if let homeViewController = topViewController as? HomeViewController {
//                    if case let .home(name, uuid, tab) = router.parameter {
//                        homeViewController.reloadData(name: name, uuid: uuid, tab: tab)
//                    }
//                } else {
//                    tabBarController.selectedIndex = 0
//                }
            case .message:
                tabBarController.selectedIndex = 1
            case .user:
                tabBarController.selectedIndex = 2
            default:
                return false
            }
            return true
        }
        return false
    }
    
    @discardableResult
    public func push(_ url: URL) -> UIViewController? {
        if let scheme = url.scheme, scheme == Router.scheme {
            guard let router = Router(url.absoluteString) else {
                return nil
            }
            return navigator.push(router)
        } else {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
            return nil
        }
    }
    
    @discardableResult
    public func push(_ url: URL, direct: Bool) -> UIViewController? {
        if let scheme = url.scheme, scheme == Router.scheme {
            guard let router = Router(url.absoluteString) else {
                return nil
            }
            if direct && handleDirectOpen(router: router) {
                return nil
            } else {
                return navigator.push(router)
            }
        } else {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
        return nil
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
    
    public func viewController(_ parameter: RouterParameter) -> UIViewController? {
        let router = Router(parameter)
        return viewController(for: router.type.url, context: router)
    }
}
