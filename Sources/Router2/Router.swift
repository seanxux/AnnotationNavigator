//
//  Router.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 18/12/2017.
//  Copyright © 2017 GuoXiaoMei. All rights reserved.
//

import UIKit

// Router跳转
protocol Routable {}
// 通过Init方法初始化Controller
protocol InitRoutable: Routable {}
// 自定义Router跳转
protocol CustomRoutable: Routable {}

// sourcery: router="photoView"
class RouterPhotoViewController: UIViewController, CustomRoutable {
    // sourcery: parameter
    var urls: [String]?
    // sourcery: parameter
    var currentIndex: Int?
}

// sourcery: router="customerService"
class RouterCustomerServiceViewController: UIViewController, CustomRoutable {
    // sourcery: parameter
    var groupid: String?
}

// sourcery: router="tabHome"
class RouterHomeViewController: UIViewController, CustomRoutable {}

extension RouterType {
    // 全URL
    var url: String {
        return "gxm-bbc://baobeicang.com" + self.rawValue
    }
}

// Router封装
public struct Router {
    static let scheme = "gxm-bbc"
    var type: RouterType
    var parameter: RouterParameter
    var context: [String: Any] = [:]
    var tabIndex: Int? {
        didSet {
            context["tabIndex"] = tabIndex
        }
    }
    
    init(_ parameter: RouterParameter) {
        self.type = parameter.type
        self.parameter = parameter
    }
    
    // App URL Scheme方式初始化
    init?(_ urlScheme: String, tabIndex: Int? = nil) {
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
        guard let parameter = RouterParameter(type: type, parameter: urlScheme.queryParameters) else {
            return nil
        }
        self.type = type
        self.parameter = parameter
        self.context = urlScheme.queryParameters
        self.tabIndex = tabIndex
    }
    
    // App URL Scheme方式初始化（带参数）
    init?(_ urlScheme: String, context: [String: Any]) {
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
        self.context.merge(context) { (_, new) in new }
        guard let parameter = RouterParameter(type: type, parameter: self.context) else {
            return nil
        }
        self.type = type
        self.parameter = parameter
    }
    
    // Router类型方式初始化
    init(_ type: RouterType, context: [String: Any] = [:], tabIndex: Int? = nil) {
        self.type = type
        guard let parameter = RouterParameter(type: type, parameter: context) else {
            fatalError("router parameter interval error")
        }
        self.parameter = parameter
        self.context = context
        self.tabIndex = tabIndex
    }
    
//    // Web URL方式初始化
//    init(urlString: String) {
//        self.type = .web
//        self.parameter = .web(url: urlString)
//        self.context = ["url": urlString]
//    }
//    
//    // Weex
//    init(title: String, weex urlString: String, param: [String: Any]? = nil) {
//        self.type = .weex
//        self.parameter = .weex(pageTitle: title, url: urlString, param: param)
//        self.context = ["title": title, "url": urlString]
//        if let param = param {
//            self.context.merge(param) { (_, new) in new }
//        }
//    }
    
    func isPresent() -> Bool {
        if let transition = context["transition"] as? String,
            transition == "present" {
            return true
        }
        return false
    }
    
    /// Convert a JSON String into a Dictionary<String, Any> using NSJSONSerialization
    public static func parseJSONStringIntoDictionary(JSONString: String) -> [String: Any]? {
        let parsedJSON: Any? = Router.parseJSONString(JSONString: JSONString)
        return parsedJSON as? [String: Any]
    }
    
    /// Convert a JSON String into an Object using NSJSONSerialization
    public static func parseJSONString(JSONString: String) -> Any? {
        let data = JSONString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        if let data = data {
            let parsedJSON: Any?
            do {
                parsedJSON = try JSONSerialization.jsonObject(with: data,
                                                              options: JSONSerialization.ReadingOptions.allowFragments)
            } catch let error {
                print(error)
                parsedJSON = nil
            }
            return parsedJSON
        }
        
        return nil
    }
}
