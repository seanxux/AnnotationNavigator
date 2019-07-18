//
//  NavigatorType.swift
//  AnnotationNavigator
//
//  Created by SeanXu on 16/12/2017.
//  Copyright © 2017 SeanXu. All rights reserved.
//

import Foundation
import URLNavigator

extension NavigatorType {
    
    /// register a view controller factory to the router
    ///
    /// - Parameters:
    ///   - router: RouterType
    ///   - factory: factory
    func register(_ router: RouterType, _ factory: @escaping URLNavigator.ViewControllerFactory) {
        register(router.url, factory)
    }
    
    /// register a handler factory to the router
    ///
    /// - Parameters:
    ///   - router: RouterType
    ///   - factory: factory
    func handle(_ router: RouterType, _ factory: @escaping URLOpenHandlerFactory) {
        handle(router.url, factory)
    }
    
    /// get the handler for router
    ///
    /// - Parameters:
    ///   - router: RouterType
    ///   - context: parameter
    /// - Returns: handler
    func handler(for router: RouterType, context: Any?) -> URLOpenHandler? {
        return handler(for: router.url, context: context)
    }
    
    /// register a custom handler factory to the router
    ///
    /// - Parameters:
    ///   - router: RouterType
    ///   - factory: handler factory
    func customHandle(_ router: RouterType, _ factory: @escaping URLOpenHandlerFactory) {
//        customHandle(router.url, factory)
    }
    
    /// get the custom handler for router
    ///
    /// - Parameters:
    ///   - router: RouterType
    ///   - factory: custom handler
    func customHandler(for router: RouterType, context: Any?) -> URLOpenHandler? {
//        return customHandler(for: router.url, context: context)
        return nil
    }
    
    /// push to router page
    ///
    /// - Parameter router: router
    /// - Returns: controller
    @discardableResult
    public func push(_ router: Router) -> UIViewController? {
        return self.pushURL(router.type.url, context: router)
    }
    
    /// navigate to url (push/present/handler/openURL)
    ///
    /// - Parameter url: router url
    /// - Returns: controller
    @discardableResult
    public func open(_ url: URL) -> UIViewController? {
        if let scheme = url.scheme, scheme == NavigatorMap.scheme {
            guard let router = Router(url.absoluteString) else {
                return nil
            }
            if navigator.handler(for: router.type, context: router) != nil {
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
    
    /// navigate to url (push/present/handler/openURL)
    ///
    /// - Parameters:
    ///   - url: router url
    ///   - useCustomHandler: wether using the custom handler
    /// - Returns: controller
    @discardableResult
    public func open(_ url: URL, useCustomHandler: Bool) -> UIViewController? {
        if let scheme = url.scheme, scheme == NavigatorMap.scheme {
            guard let router = Router(url.absoluteString) else {
                return nil
            }
            if navigator.handler(for: router.type.url) != nil {
                navigator.openURL(router.type.url, context: router)
                return nil
            } else {
                if useCustomHandler, executeCustomHandler(router: router) {
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
    
    /// execute custom handler
    ///
    /// - Parameter router: RouterType
    /// - Returns: result
    private func executeCustomHandler(router: Router) -> Bool {
        guard let action = customHandler(for: router.type, context: router) else {
            return false
        }
        return action()
    }
    
    /// push to url page
    ///
    /// - Parameter url: router url
    /// - Returns: controller
    @discardableResult
    public func push(_ url: URL) -> UIViewController? {
        if let scheme = url.scheme, scheme == NavigatorMap.scheme {
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
    
    /// push to url page
    ///
    /// - Parameters:
    ///   - url: router url
    ///   - useCustomHandler: wether using the custom handler
    /// - Returns: controller
    @discardableResult
    public func push(_ url: URL, useCustomHandler: Bool) -> UIViewController? {
        if let scheme = url.scheme, scheme == NavigatorMap.scheme {
            guard let router = Router(url.absoluteString) else {
                return nil
            }
            if useCustomHandler && executeCustomHandler(router: router) {
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
    
    /// check handler exist or push to url page
    ///
    /// - Parameters:
    ///   - url: router url
    ///   - useCustomHandler: wether using the custom handler
    /// - Returns: controller
    @discardableResult
    public func pushOrHandle(_ url: URL, useCustomHandler: Bool) -> UIViewController? {
        if navigator.handler(for: url) != nil {
            return navigator.open(url)
        } else {
            return navigator.push(url, useCustomHandler: useCustomHandler)
        }
    }
    
    /// present to url
    ///
    /// - Parameters:
    ///   - url: router url
    ///   - wrap: wrap in UINavigationController
    /// - Returns: controller
    @discardableResult
    public func present(_ url: URL, wrap: UINavigationController.Type? = nil) -> UIViewController? {
        if let scheme = url.scheme, scheme == NavigatorMap.scheme,
            let router = Router(url.absoluteString) {
            return navigator.present(router, wrap: wrap)
        } else {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
            return nil
        }
    }
    
    /// present to router
    ///
    /// - Parameters:
    ///   - router: router
    ///   - wrap: wrap in UINavigationController
    /// - Returns: controller
    @discardableResult
    public func present(_ router: Router, wrap: UINavigationController.Type? = nil) -> UIViewController? {
        return self.presentURL(router.type.url, context: router, wrap: wrap)
    }
    
    /// push to router parameters
    ///
    /// - Parameters:
    ///   - parameter: router parameter
    ///   - from: from
    ///   - animated: animated
    /// - Returns: controller
    @discardableResult
    public func push(_ parameter: RouterParameter, from: UINavigationControllerType? = nil, animated: Bool = true) -> UIViewController? {
        let router = Router(parameter)
        return self.pushURL(router.type.url,
                            context: router,
                            from: from,
                            animated: animated)
    }
    
    /// present to router parameter
    ///
    /// - Parameters:
    ///   - parameter: router parameter
    ///   - context: context
    ///   - wrap: wrap
    ///   - from: from
    ///   - animated: animated
    ///   - completion: completion
    /// - Returns: controller for router
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
    
    /// open router with parameter
    ///
    /// - Parameters:
    ///   - parameter: router parameter
    ///   - context: context
    /// - Returns: open result
    @discardableResult
    public func open(_ parameter: RouterParameter, context: Any? = nil) -> Bool {
        let router = Router(parameter)
        return self.openURL(router.type.url, context: router)
    }
    
    /// new controller for router parameter
    ///
    /// - Parameter parameter: router parameter
    /// - Returns: controller for router
    public func viewController(_ parameter: RouterParameter) -> UIViewController? {
        let router = Router(parameter)
        return viewController(for: router.type.url, context: router)
    }
}
