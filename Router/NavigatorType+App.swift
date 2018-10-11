//
//  NavigatorType+Application.swift
//  JuYouFan
//
//  Created by SeanXu on 2018/8/13.
//  Copyright © 2018 GuoXiaoMei. All rights reserved.
//

import Foundation
import URLNavigator

extension NavigatorType {
    
    func handleOpenURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        handleOpenURL(url)
    }
    
    func handleOpenURL(_ url: URL) {
        if let viewController = UIViewController.topMost,
            viewController.isViewLoaded, viewController.view.window != nil {
            navigator.open(url, direct: true)
        } else {
            // save open url
        }
    }
    
}
