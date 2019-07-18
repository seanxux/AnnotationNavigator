//
//  Router.swift
//  AnnotationNavigator
//
//  Created by SeanXu on 18/12/2017.
//  Copyright © 2017 SeanXu. All rights reserved.
//

import UIKit

// Router
public struct Router {
    
    var type: RouterType
    var parameter: RouterParameter
    var context: [String: Any] = [:]
    
    /// 初始化
    ///
    /// - Parameter parameter: router参数类型
    init(_ parameter: RouterParameter) {
        self.type = parameter.type
        self.parameter = parameter
    }
    
    /// App URL Scheme方式初始化
    ///
    /// - Parameters:
    ///   - urlScheme: url
    ///   - context: 附加参数
    init?(_ urlScheme: String, context: [String: Any]? = nil) {
        guard let url = URL(string: urlScheme) else {
            return nil
        }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.query = nil
        guard let path = urlComponents?.path else {
            return nil
        }
        guard let type = RouterType(rawValue: path) else {
            return nil
        }
        self.context = urlScheme.queryParameters
        if let extraContext = context {
            self.context.merge(extraContext) { (_, new) in new }
        }
        guard let parameter = RouterParameter(type: type, parameter: self.context) else {
            return nil
        }
        self.type = type
        self.parameter = parameter
    }
    
    /// Router类型方式初始化
    ///
    /// - Parameters:
    ///   - type: 页面p类型
    ///   - context: 参数
    init(_ type: RouterType, context: [String: Any] = [:]) {
        self.type = type
        guard let parameter = RouterParameter(type: type, parameter: context) else {
            fatalError("router parameter interval error")
        }
        self.parameter = parameter
        self.context = context
    }

    /// transition类型
    ///
    /// - Returns: 是否使用present transition
    func isPresent() -> Bool {
        if let transition = context["transition"] as? String,
            transition == RouterTransitionType.present.rawValue {
            return true
        }
        return false
    }
    
}
