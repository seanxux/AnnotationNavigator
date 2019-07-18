// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
//  Router.stencil.swift
//  AnnotationNavigator
//
//  Created by SeanXu on 27/03/2018.
//  Copyright © 2018 SeanXu. All rights reserved.
//

import URLNavigator

// swiftlint:disable all
extension NavigatorMap {

    func registerGenerated(navigator: NavigatorType) {
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
