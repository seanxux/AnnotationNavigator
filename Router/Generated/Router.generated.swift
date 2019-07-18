// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
//  Router.stencil.swift
//  AnnotationNavigator
//
//  Created by SeanXu on 27/03/2018.
//  Copyright © 2018 SeanXu. All rights reserved.
//
import UIKit
#if canImport(ObjectMapper)
import ObjectMapper
#endif

// swiftlint:disable all
public enum RouterType: String {
    /// RouterType: Custom Page
    case custom = "/custom"
    /// RouterType: Detail Page
    case detail = "/detail"
    /// RouterType: Home Page
    case home = "/home"
    /// RouterType: Message Center
    case message = "/message"
    /// RouterType: 
    case external = "/external"
    /// RouterType: 
    case main = "/main"
    /// RouterType: User Center
    case user = "/user"
    /// RouterType: Web Page
    case web = "/web"

    var name: String {
        switch self {
        case .custom:
            return "Custom Page"
        case .detail:
            return "Detail Page"
        case .home:
            return "Home Page"
        case .message:
            return "Message Center"
        case .external:
            return ""
        case .main:
            return ""
        case .user:
            return "User Center"
        case .web:
            return "Web Page"
        }
    }
}

extension CustomViewController: RouterControllerType {
    var routerType: RouterType { return .custom }
}
extension DetailViewController: RouterControllerType {
    var routerType: RouterType { return .detail }
}
extension HomeViewController: RouterControllerType {
    var routerType: RouterType { return .home }
}
extension MessageViewController: RouterControllerType {
    var routerType: RouterType { return .message }
}
extension RouterExternalViewController: RouterControllerType {
    var routerType: RouterType { return .external }
}
extension RouterMainViewController: RouterControllerType {
    var routerType: RouterType { return .main }
}
extension UserViewController: RouterControllerType {
    var routerType: RouterType { return .user }
}
extension WebViewController: RouterControllerType {
    var routerType: RouterType { return .web }
}

// swiftlint:disable all
public enum RouterParameter {
    case custom(pageTitle: String?, url: String, param: [String: Any]?)
    case detail(name: String?, uuid: String?)
    case home
    case message
    case external(url: String?)
    case main(tab: String?)
    case user
    case web(url: String)

    init?(urlScheme: String) {
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
        guard let parameter = RouterParameter(type: type, parameter: url.queryParameters) else {
            return nil
        }
        self = parameter
    }

    init?(type: RouterType, parameter: [String: Any] = [:]) {
        do {
            switch type {
            case .custom:
                let pageTitle: String? = try parameter.get("title")
                let url: String = try parameter.get("url")
                var param: [String: Any]?
                let paramTemp: String? = try parameter.get("param")
                if let paramTemp = paramTemp {
                    param = RouterParser.parseJSONStringIntoDictionary(JSONString: paramTemp)
                } else {
                    param = nil
                }
                self = .custom(pageTitle: pageTitle, url: url, param: param)
            case .detail:
                let name: String? = try parameter.get("name")
                let uuid: String? = try parameter.get("uuid")
                self = .detail(name: name, uuid: uuid)
            case .home:
                self = .home
            case .message:
                self = .message
            case .external:
                let url: String? = try parameter.get("url")
                self = .external(url: url)
            case .main:
                let tab: String? = try parameter.get("tab")
                self = .main(tab: tab)
            case .user:
                self = .user
            case .web:
                let url: String = try parameter.get("url")
                self = .web(url: url)
            }
        } catch {
            return nil
        }
    }

    var type: RouterType {
        switch self {
        case .custom:
            return .custom
        case .detail:
            return .detail
        case .home:
            return .home
        case .message:
            return .message
        case .external:
            return .external
        case .main:
            return .main
        case .user:
            return .user
        case .web:
            return .web
        }
    }

    var parameters: [String: Any] {
        switch self {
        case let .custom(pageTitle, url, param):
            var parameter: [String: Any] = [:]
            parameter["title"] = pageTitle
            parameter["url"] = url
            parameter["param"] = param
            return parameter
        case let .detail(name, uuid):
            var parameter: [String: Any] = [:]
            parameter["name"] = name
            parameter["uuid"] = uuid
            return parameter
        case .home:
            return [:]
        case .message:
            return [:]
        case let .external(url):
            var parameter: [String: Any] = [:]
            parameter["url"] = url
            return parameter
        case let .main(tab):
            var parameter: [String: Any] = [:]
            parameter["tab"] = tab
            return parameter
        case .user:
            return [:]
        case let .web(url):
            var parameter: [String: Any] = [:]
            parameter["url"] = url
            return parameter
        }
    }
}

extension RouterType {
    // Full URL
    var url: String {
        return NavigatorMap.scheme + "://" + NavigatorMap.host + rawValue
    }
}

public enum RouterError: Error {
    case typeNotMatch
}
