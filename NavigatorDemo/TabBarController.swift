//
//  TabBarController.swift
//  NavigatorDemo
//
//  Created by SeanXu on 2018/8/13.
//

import UIKit

protocol TabBarControllerType {
    var isRootController: Bool { get }
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.tabRouters = [.home, .message, .user]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
