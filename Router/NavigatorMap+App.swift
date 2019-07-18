//
//  NavigatorMap+App.swift
//  YiLuTong
//
//  Created by SeanXu on 2018/11/19.
//  Copyright © 2018 SeanXu. All rights reserved.
//

import UIKit
import URLNavigator

extension NavigatorMap {
    
    func registerCustom(navigator: NavigatorType) {
        addRegister()
        addHandler()
    }
    
    private func addRegister() {
    }
    
    private func addHandler() {
        // 强制切回一级页面，选中tab
        navigator.handle(.main) { _, _, context in
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            guard let router = context as? Router,
                case let .main(tab) = router.parameter,
                let toTab = tab,
                let routerType = RouterType(rawValue: "/" + toTab),
                let index = appDelegate?.tabRouters.firstIndex(of: routerType) else {
                    return false
            }
            let topViewController = UIViewController.topMost
            // 当前controller是否是present
            if let navigationController = topViewController?.navigationController,
                navigationController.presentingViewController != nil,
                let delegate = UIApplication.shared.delegate as? AppDelegate,
                let rootViewController = delegate.window?.rootViewController {
                // dismiss all controller
                rootViewController.dismiss(animated: false, completion: {
                    navigator.openMainTab(index)
                })
            } else {
                navigator.openMainTab(index)
            }
            return true
        }
        
        // 外部打开
        navigator.handle(.external) { _, _, context in
            guard let router = context as? Router,
                case let .external(url) = router.parameter,
                let urlString = url, let openURL = URL(string: urlString) else {
                    return false
            }
            if UIApplication.shared.canOpenURL(openURL) {
                UIApplication.shared.openURL(openURL)
            }
            return true
        }
    }
    
}
