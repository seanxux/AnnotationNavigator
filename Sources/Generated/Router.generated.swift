// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
//  Router.stencil.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 27/03/2018.
//  Copyright © 2018 SeanXu. All rights reserved.
//

public enum RouterType: String {
    case home
    case message
    case user
    case web
}

// swiftlint:disable line_length type_body_length
public enum RouterParameter {
    case home
    case message
    case user
    case web(url: String)
    
    init?(urlScheme: String) {
        fatalError()
    }
    init?(type: RouterType, parameter: [String: Any] = [:]) {
        fatalError()
    }
    var type: RouterType {
        return .home
    }
}

public enum RouterError: Error {
    case typeNotMatch
}
