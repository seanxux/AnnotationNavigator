//
//  MessageViewController.swift
//  NavigatorDemo
//
//  Created by SeanXu on 2018/8/13.
//

import UIKit

// sourcery: router="message", name="Message Center"
class MessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Message"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MessageViewController: TabBarControllerType {
    var isRootController: Bool {
        return true
    }
}
