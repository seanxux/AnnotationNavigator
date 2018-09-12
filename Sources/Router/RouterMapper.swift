//
//  RouterMapper.swift
//  JuYouFan
//
//  Created by SeanXu on 2018/9/11.
//  Copyright © 2018 GuoXiaoMei. All rights reserved.
//

import Foundation

public struct RouterMapper<D: Decodable> {
    
    public func decode(_ jsonString: String) -> D? {
        let decoder = JSONDecoder()
        guard let jsonData = jsonString.data(using: .utf8), !jsonData.isEmpty else {
            return nil
        }
        do {
            return try decoder.decode(D.self, from: jsonData)
        } catch {
            return nil
        }
    }
    
}
