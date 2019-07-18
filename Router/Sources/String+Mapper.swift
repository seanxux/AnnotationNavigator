//
//  String+Mapper.swift
//  JuYouFan
//
//  Created by SeanXu on 2018/11/9.
//  Copyright © 2018 SeanXu. All rights reserved.
//

import Foundation

extension String {
    public func map<D: Decodable>(_ type: D.Type) -> D? {
        let decoder = JSONDecoder()
        guard let jsonData = data(using: .utf8), !jsonData.isEmpty else {
            return nil
        }
        do {
            return try decoder.decode(D.self, from: jsonData)
        } catch {
            return nil
        }
    }
}
