//
//  UserViewController.swift
//  NavigatorDemo
//
//  Created by SeanXu on 2018/8/13.
//

import UIKit

// sourcery: router="user", name="User Center"
class UserViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "User"
    }

}

extension UserViewController: TabBarControllerType {
    var isRootController: Bool {
        return true
    }
}
