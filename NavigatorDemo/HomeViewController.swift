//
//  HomeViewController.swift
//  NavigatorDemo
//
//  Created by SeanXu on 2018/8/13.
//

import UIKit

// sourcery: router="home", name="Home Page"
class HomeViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var urls: [[String: String]] = [
        ["title": "detail", "url": "navidemo://demo-navigator.com/detail"],
        ["title": "detail with parameter", "url": "navidemo://demo-navigator.com/detail?name=A&uuid=111"],
        ["title": "detail(present)", "url": "navidemo://demo-navigator.com/detail?name=A&uuid=111&transition=present"],
        ["title": "web", "url": "navidemo://demo-navigator.com/web?url=xxx"],
    ]
    var schemes: [[String: Any]] = [
//        ["title": "detail scheme", "scheme": RouterParameter.detail(name: "AAA", uuid: "123")],
//        ["title": "web scheme", "scheme": RouterParameter.web(url: "https://www.google.com")]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
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
            cell.detailTextLabel?.text = urls[indexPath.row]["url"]
        } else {
            cell.textLabel?.text = schemes[indexPath.row]["title"] as? String
            if let parameter = schemes[indexPath.row]["scheme"] as? RouterParameter {
                cell.detailTextLabel?.text = ".\(parameter)"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if let urlString = urls[indexPath.row]["url"], let url = URL(string: urlString) {
                navigator.open(url)
            }
        } else {
            if let scheme = schemes[indexPath.row]["scheme"] as? RouterParameter {
                navigator.push(scheme)
            }
        }
    }
    
}

extension HomeViewController: TabBarControllerType {
    var isRootController: Bool {
        return true
    }
}
