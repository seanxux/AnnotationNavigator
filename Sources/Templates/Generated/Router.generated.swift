// Generated using Sourcery 0.14.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
//  Router.stencil.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 27/03/2018.
//  Copyright © 2018 GuoXiaoMei. All rights reserved.
//
import UIKit

// swiftlint:disable superfluous_disable_command
public enum RouterType: String {
    case detail = "/detail"
    case home = "/home"
    case message = "/message"
    case user = "/user"
    case web = "/web"
}

// swiftlint:disable line_length type_body_length
public enum RouterParameter {
    case detail(name: String?, uuid: String?)
    case home
    case message
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

    // swiftlint:disable line_length function_body_length unused_closure_parameter
    init?(type: RouterType, parameter: [String: Any] = [:]) {
        do {
            switch type {
            case .detail:
                let name: String? = try parameter.get("name")
                let uuid: String? = try parameter.get("uuid")
                self = .detail(name: name, uuid: uuid)
            case .home:
                self = .home
            case .message:
                self = .message
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
        case .detail:
            return .detail
        case .home:
            return .home
        case .message:
            return .message
        case .user:
            return .user
        case .web:
            return .web
        }
    }

    func toDictionary() -> [String: Any] {
        switch self {
        case let .detail(name, uuid):
            var parameter: [String: Any] = [:]
            parameter["name"] = name
            parameter["uuid"] = uuid
            return parameter
        case .home:
            return [:]
        case .message:
            return [:]
        case .user:
            return [:]
        case let .web(url):
            var parameter: [String: Any] = [:]
            parameter["url"] = url
            return parameter
        }
    }
}
// swiftlint:enable line_length type_body_length

public enum RouterError: Error {
    case typeNotMatch
}
