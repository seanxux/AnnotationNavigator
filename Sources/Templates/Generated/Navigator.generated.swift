// Generated using Sourcery 0.14.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
//  Router.stencil.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 27/03/2018.
//  Copyright © 2018 GuoXiaoMei. All rights reserved.
//

import URLNavigator

// swiftlint:disable superfluous_disable_command
// swiftlint:disable line_length function_body_length unused_closure_parameter
extension NavigatorMap {

    static func initializeGenerated(navigator: NavigatorType) {
        navigator.register(.detail) { _, _, context in
            guard let router = context as? Router,
                case let .detail(name, uuid) = router.parameter else {
                return nil
            }
            let viewController = DetailViewController()
            if name != nil {
                viewController.name = name
            }
            if uuid != nil {
                viewController.uuid = uuid
            }
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.home) { _, _, context in
            let viewController = HomeViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.message) { _, _, context in
            let viewController = MessageViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.user) { _, _, context in
            let viewController = UserViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.web) { _, _, context in
            guard let router = context as? Router,
                case let .web(url) = router.parameter else {
                return nil
            }
            let viewController = WebViewController(url: url)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
    }

}
// swiftlint:enable line_length function_body_length unused_closure_parameter
