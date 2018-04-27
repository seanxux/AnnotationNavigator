// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
//  Router.stencil.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 27/03/2018.
//  Copyright © 2018 SeanXu. All rights reserved.
//

import URLNavigator

// swiftlint:disable all
extension URLNavigationMap {

    static func initializeGenerated(navigator: NavigatorType) {
        navigator.register(.addVisitLog) { _, _, context in
            guard let router = context as? Router,
                case let .addVisitLog(companyId) = router.parameter else {
                return nil
            }
            let viewController = AddVisitLogDetailViewController()
            viewController.companyId = companyId
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.posDisplay) { _, _, context in
            guard let router = context as? Router,
                case let .posDisplay(pageTitle, latitude, longitude) = router.parameter else {
                return nil
            }
            let viewController = CRMMapLocationViewController(pageTitle: pageTitle, latitude: latitude, longitude: longitude)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.web) { _, _, context in
            guard let router = context as? Router,
                case let .web(url) = router.parameter else {
                return nil
            }
            let viewController = CRMWebViewController(url: url)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.companyDetail) { _, _, context in
            guard let router = context as? Router,
                case let .companyDetail(companyId) = router.parameter else {
                return nil
            }
            let viewController = CompanyBaseInfoViewController()
            viewController.companyId = companyId
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.privateSea) { _, _, context in
            guard let router = context as? Router,
                case let .privateSea(status) = router.parameter else {
                return nil
            }
            let viewController = CompanyListViewController()
            viewController.status = status
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.createBuilding) { _, _, context in
            let viewController = CreateOfficeBuildingViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.kps) { _, _, context in
            guard let router = context as? Router,
                case let .kps(companyId) = router.parameter else {
                return nil
            }
            let viewController = KPManageViewController()
            viewController.companyId = companyId
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.staffVisitLog) { _, _, context in
            let viewController = ManagerVisitLogsViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.contacts) { _, _, context in
            let viewController = MyContactViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.createCompany) { _, _, context in
            let viewController = NewCompanyViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.publicSea) { _, _, context in
            let viewController = OpenSeaMainViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.replenishHistory) { _, _, context in
            guard let router = context as? Router,
                case let .replenishHistory(shelfId) = router.parameter else {
                return nil
            }
            let viewController = ReplenishHistoryViewController(shelfId: shelfId)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.signedBillDetail) { _, _, context in
            guard let router = context as? Router,
                case let .signedBillDetail(uniqueId, type) = router.parameter else {
                return nil
            }
            let viewController = SignedBillDetailViewController(uniqueId: uniqueId, type: type)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.sign) { _, _, context in
            guard let router = context as? Router,
                case let .sign(buildingId, companyId, companyName, companyAlias, kpId, endOrder, companyPhotos, stationPhotos) = router.parameter else {
                return nil
            }
            let viewController = SignedBillViewController()
            viewController.buildingId = buildingId
            viewController.companyId = companyId
            viewController.companyName = companyName
            viewController.companyAlias = companyAlias
            viewController.kpId = kpId
            viewController.endOrder = endOrder
            viewController.companyPhotos = companyPhotos
            viewController.stationPhotos = stationPhotos
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.trainingVideo) { _, _, context in
            let viewController = TrainVideoListViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.updateCompany) { _, _, context in
            guard let router = context as? Router,
                case let .updateCompany(companyId) = router.parameter else {
                return nil
            }
            let viewController = UpdateCompanyInfoViewController()
            viewController.companyId = companyId
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        navigator.register(.visitLog) { _, _, context in
            let viewController = VisitLogViewController()
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
    }

}
// swiftlint:enable all
