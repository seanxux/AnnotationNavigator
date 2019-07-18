//
//  WebViewController.swift
//  NavigatorDemo
//
//  Created by SeanXu on 2018/8/13.
//

import UIKit

// sourcery: router="web", name="Web Page"
class WebViewController: BaseViewController, InitRoutable {
    
    // sourcery: parameter
    var url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
        title = "Web"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
