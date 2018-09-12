//
//  HomeViewController.swift
//  NavigatorDemo
//
//  Created by SeanXu on 2018/8/13.
//

import UIKit

// sourcery: router="home"
class HomeViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var urls: [[String: String]] = [
        ["title": "详情", "url": "navidemo://demo-navigator.com/detail"],
        ["title": "详情", "url": "navidemo://demo-navigator.com/detail"],
        ["title": "详情", "url": "navidemo://demo-navigator.com/detail"],
        ["title": "详情", "url": "navidemo://demo-navigator.com/detail"],
    ]
    var schemes: [[String: Any]] = [
        ["title": "详情", "scheme": RouterParameter.detail(name: "AAA", uuid: "123")],
        ["title": "详情", "scheme": RouterParameter.detail(name: "AAA", uuid: "123")],
        ["title": "详情", "scheme": RouterParameter.detail(name: "AAA", uuid: "123")],
        ["title": "详情", "scheme": RouterParameter.detail(name: "AAA", uuid: "123")]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return urls.count
        } else {
            return schemes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") else {
            fatalError()
        }
        if indexPath.section == 0 {
            cell.textLabel?.text = urls[indexPath.row]["title"]
            cell.detailTextLabel?.text = "PUSH"
        } else {
            cell.textLabel?.text = schemes[indexPath.row]["title"] as? String
            cell.detailTextLabel?.text = "PUSH"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if let urlString = urls[indexPath.row]["url"], let url = URL(string: urlString) {
                navigator.push(url)
            }
        } else {
            if let scheme = schemes[indexPath.row]["scheme"] as? RouterParameter {
                navigator.push(scheme)
            }
        }
    }
    
}
