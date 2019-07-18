//
//  RouterParameter.swift
//  JuYouFan
//
//  Created by SeanXu on 2019/2/20.
//  Copyright © 2019 SeanXu. All rights reserved.
//

import Foundation

extension RouterParameter {
    var urlScheme: String {
        return urlScheme(transition: nil)
    }
    
    func urlScheme(transition: String?) -> String {
        let url = URL(string: type.url)
        var queries = parameters
        if let transition = transition {
            queries["transition"] = transition
        }
        guard !queries.isEmpty else {
            return url?.absoluteString ?? ""
        }
        let fullURL = url?.added(queries)
        return fullURL?.absoluteString ?? ""
    }
}
