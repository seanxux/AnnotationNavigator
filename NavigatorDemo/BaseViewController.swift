//
//  BaseViewController.swift
//  NavigatorDemo
//
//  Created by SeanXu on 2018/4/27.
//

import UIKit

class BaseViewController: UIViewController, Routable {
    
    var isPresented: Bool {
        return navigationController?.viewControllers.count == 1 &&
            navigationController?.presentingViewController != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

