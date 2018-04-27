//
//  URLNavigationMap.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 16/12/2017.
//  Copyright © 2017 SeanXu. All rights reserved.
//

import Foundation
import URLNavigator
import SKPhotoBrowser
import ObjectMapper

// 全局Router
let navigator = Navigator()

struct URLNavigationMap {
    // 注册Router
    static func initialize(navigator: NavigatorType) {
        navigator.handle(.tabHome) { _, _, _ in
            self.switchToTabIndex(0)
            return true
        }
        navigator.handle(.tabWorkbench) { _, _, _ in
            self.switchToTabIndex(1)
            return true
        }
        navigator.handle(.tabMine) { _, _, _ in
            self.switchToTabIndex(2)
            return true
        }
        
        // Weex
        navigator.register(.weex) { _, _, context in
            guard let router = context as? Router,
                case let .weex(pageTitle, url, param) = router.parameter else {
                    return nil
            }
            let weexParam = param ?? router.context
            let viewController = CRMWeexViewController(pageTitle: pageTitle, url: url, param: weexParam)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        
        // Feedback
        navigator.register(.feedback) { _, _, context in
            guard let router = context as? Router,
                case let .feedback(pageTitle, url, param) = router.parameter else {
                    return nil
            }
            let weexParam = param ?? router.context
            let viewController = FeedBackViewController(pageTitle: pageTitle, url: url, param: weexParam)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        
        // 照片浏览
        navigator.register(.photoView) { _, _, context in
            guard let router = context as? Router else {
                return nil
            }
            if let urls = router.context["urls"] as? [String],
                let currentIndex = router.context["currentIndex"] as? Int {
                let photoBrowser = SKPhotoBrowser(photos: urls.map {
                    let photo = SKPhoto.photoWithImageURL($0)
                    photo.shouldCachePhotoURLImage = true
                    return photo
                })
                photoBrowser.currentPageIndex = currentIndex
                photoBrowser.hidesBottomBarWhenPushed = true
                return photoBrowser
            }
            return nil
        }
        
        // 公司列表
        navigator.register(.companyList) { _, _, context in
            guard let router = context as? Router else {
                return nil
            }
            let companyListVC = CompanyListViewController(nibName: "CompanyListViewController", bundle: nil)
            companyListVC.isInPublicSea = true
            companyListVC.isShowBuildingInfo = false
            if let type = router.context["type"] as? String,
                let status = Int(type),
                let id = router.context["buildingId"] as? String,
                let buildingId = Int(id) {
                companyListVC.status = status
                if let buildingStr = router.context["building"] as? String {
                    let modelStr = "{ \"building\": \(buildingStr)}"
                    companyListVC.buildingModel = BuildingModel(JSONString: modelStr)
                }
                companyListVC.buildingId = buildingId
            }
            companyListVC.hidesBottomBarWhenPushed = true
            return companyListVC
        }
    }
    
    // Class Controller工厂
    private static func classViewControllerFactory<T: UIViewController>(_: T.Type) -> URLNavigator.ViewControllerFactory {
        return { (url: URLConvertible, values: [String: Any], context: Any?) -> T? in
            guard url.urlValue != nil else { return nil }
            let viewController = T()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
    }
    
    // Nib Controller工厂
    private static func nibViewControllerFactory<T: UIViewController>(_: T.Type) -> URLNavigator.ViewControllerFactory {
        return { (url: URLConvertible, values: [String: Any], context: Any?) -> T? in
            guard url.urlValue != nil else { return nil }
            let className = NSStringFromClass(T.self).components(separatedBy: ".").last!
            let viewController = T(nibName: className, bundle: nil)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
    }
    
    // Web Controller工厂
    private static func webViewControllerFactory(url: URLConvertible, values _: [String: Any], context: Any?) -> UIViewController? {
        guard let router = context as? Router,
            case let .web(url) = router.parameter else {
                return nil
        }
        let webViewController = CRMWebViewController(url: url)
        webViewController.hidesBottomBarWhenPushed = true
        return webViewController
    }
    
    // 切换Tab
    private static func switchToTabIndex(_ index: Int) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let mainViewController = appDelegate.mainRootVC {
                mainViewController.selectedIndex = index
            }
        }
    }
}
