//
//  Router+App.swift
//  YiLuTong
//
//  Created by SeanXu on 2018/11/19.
//  Copyright © 2018 SeanXu. All rights reserved.
//

import UIKit

// sourcery: router="main"
class RouterMainViewController: UIViewController, CustomRoutable {
    // sourcery: parameter
    // home、message、user
    var tab: String?
}

// sourcery: router="external"
class RouterExternalViewController: UIViewController, CustomRoutable {
    // sourcery: parameter
    var url: String?
}
