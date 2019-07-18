//
//  NavigatorType+Application.swift
//  JuYouFan
//
//  Created by SeanXu on 2018/8/13.
//  Copyright © 2018 SeanXu. All rights reserved.
//

import Foundation
import URLNavigator

extension NavigatorType {
    /// navigate to url page
    ///
    /// - Parameter urlString: router url string
    func handleOpenURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        handleOpenURL(url)
    }
    
    /// navigate to url page
    ///
    /// - Parameter url: router url
    func handleOpenURL(_ url: URL) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let viewController = appDelegate.window?.rootViewController,
            viewController.isViewLoaded,
            viewController.view.window != nil {
            navigator.open(url, useCustomHandler: true)
        } else {
            // save open url
        }
    }
    
    /// router跳转时优先检查是否需要自定义跳转处理，比如直接切换tabBar
    func addCustomHandler() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let tabRouters = appDelegate?.tabRouters else { return }
        
        let tabBarItemHandler: URLOpenHandlerFactory = { url, values, context in
            guard let topViewController = UIViewController.topMost,
                let tabBarControllerType = topViewController as? TabBarControllerType,
                tabBarControllerType.isRootController else {
                    return false
            }
            guard let tabBarController = topViewController.tabBarController,
                let router = context as? Router else {
                return false
            }
            // 切换选中tab
            if let index = tabRouters.firstIndex(of: router.type) {
                tabBarController.selectedIndex = index
            }
            return true
        }
        tabRouters.forEach { type in
            navigator.customHandle(type, tabBarItemHandler)
        }
    }
    
    /// switch to tab
    ///
    /// - Parameter selectedIndex: tabBar index
    func openMainTab(_ selectedIndex: Int) {
        let topViewController = UIViewController.topMost
        if let navigationController = topViewController?.navigationController,
            let tabBarController = topViewController?.tabBarController {
            if navigationController.viewControllers.count > 1 {
                navigationController.popToRootViewController(animated: false)
            }
            if selectedIndex != tabBarController.selectedIndex {
                tabBarController.selectedIndex = selectedIndex
            }
        }
    }
}
