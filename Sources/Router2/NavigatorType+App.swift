//
//  NavigatorType+Application.swift
//  JuYouFan
//
//  Created by SeanXu on 2018/8/13.
//  Copyright © 2018 GuoXiaoMei. All rights reserved.
//

import Foundation
import URLNavigator
import SVProgressHUD

extension NavigatorType {
    
    func handleOpenURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        handleOpenURL(url)
    }
    
    func handleOpenURL(_ url: URL) {
        if AppContextManager.shared.account != nil,
            let viewController = UIViewController.topMost,
            viewController.isViewLoaded, viewController.view.window != nil {
            navigator.open(url, direct: true)
        } else {
            CommonManager.shared.navigatorURL = url
        }
    }
    
}
