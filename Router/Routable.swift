//
//  Routable.swift
//  NavigatorDemo
//
//  Created by SeanXu on 2018/9/13.
//

import UIKit

// Router跳转
protocol Routable {}
// 通过Init方法初始化Controller
protocol InitRoutable: Routable {}
// 自定义Router跳转
protocol CustomRoutable: Routable {}

// sourcery: router="none"
class RouterNoneViewController: UIViewController, Routable {}
