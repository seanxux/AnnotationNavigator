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
    case _placeholder = "/_placeholder"
}

// swiftlint:disable line_length type_body_length
public enum RouterParameter {
    case _placeholder

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
            case ._placeholder:
                self = ._placeholder
            }
        } catch {
            return nil
        }
    }

    var type: RouterType {
        switch self {
        case ._placeholder:
            return ._placeholder
        }
    }

    func toDictionary() -> [String: Any] {
        switch self {
        case ._placeholder:
            return [:]
        }
    }
}
// swiftlint:enable line_length type_body_length

extension RouterType {
    // Full URL
    var url: String {
        return Router.scheme + "://" + Router.host + rawValue
    }
}

public enum RouterError: Error {
    case typeNotMatch
}
