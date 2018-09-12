//
//  CRMWeexViewController.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 15/01/2018.
//  Copyright © 2018 SeanXu. All rights reserved.
//

import UIKit

// sourcery: router="custom"
class CustomViewController: UIViewController, CustomRoutable {
    // sourcery: parameter, alias="title"
    public var pageTitle: String?
    // sourcery: parameter
    public var url: String
    // sourcery: parameter
    public var param: [String: Any]?
    
    init(pageTitle: String?, url: String, param: [String: Any]?) {
        self.pageTitle = pageTitle
        self.url = url
        self.param = param
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
