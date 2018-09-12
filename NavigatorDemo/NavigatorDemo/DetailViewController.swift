//
//  DetailViewController.swift
//  NavigatorDemo
//
//  Created by SeanXu on 2018/8/13.
//

import UIKit

// sourcery: router="detail"
class DetailViewController: BaseViewController {
    
    // sourcery:begin: parameter
    var name: String?
    var uuid: String?
    // sourcery:end

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.yellow
        title = "Detail"
        
        if isPresented {
            let closeItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
            navigationItem.leftBarButtonItem = closeItem
        }
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

}
