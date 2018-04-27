// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
//  Router.stencil.swift
//  GXM-CRM
//
//  Created by XUXIAOTENG on 27/03/2018.
//  Copyright © 2018 SeanXu. All rights reserved.
//
import ObjectMapper

public enum RouterType: String {
    case addVisitLog = "/add_visit_log"
    case posDisplay = "/pos_display"
    case web = "/web"
    case weex = "/weex"
    case companyDetail = "/company_detail"
    case privateSea = "/private_sea"
    case createBuilding = "/create_building"
    case feedback = "/feedback"
    case kps = "/kps"
    case staffVisitLog = "/staff_visit_log"
    case contacts = "/contacts"
    case createCompany = "/create_company"
    case publicSea = "/public_sea"
    case replenishHistory = "/replenish_history"
    case companyList = "/company_list"
    case tabHome = "/tab_home"
    case photoView = "/photo_view"
    case signedBillDetail = "/signed_bill_detail"
    case sign = "/sign"
    case trainingVideo = "/training_video"
    case updateCompany = "/update_company"
    case tabMine = "/tab_mine"
    case visitLog = "/visit_log"
    case tabWorkbench = "/tab_workbench"
}

// swiftlint:disable all
public enum RouterParameter {
    case addVisitLog(companyId: Int)
    case posDisplay(pageTitle: String?, latitude: Double, longitude: Double)
    case web(url: String)
    case weex(pageTitle: String?, url: String, param: [String: Any]?)
    case companyDetail(companyId: Int)
    case privateSea(status: Int?)
    case createBuilding
    case feedback(pageTitle: String?, url: String, param: [String: Any]?)
    case kps(companyId: Int)
    case staffVisitLog
    case contacts
    case createCompany
    case publicSea
    case replenishHistory(shelfId: Int)
    case companyList
    case tabHome
    case photoView
    case signedBillDetail(uniqueId: String, type: Int)
    case sign(buildingId: Int?, companyId: Int?, companyName: String?, companyAlias: String?, kpId: Int?, endOrder: Int?, companyPhotos: [PhotoModel]?, stationPhotos: [PhotoModel]?)
    case trainingVideo
    case updateCompany(companyId: Int)
    case tabMine
    case visitLog
    case tabWorkbench

    init?(urlScheme: String) {
        guard let url = URL(string: urlScheme) else {
            return nil
        }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.query = nil
        guard let path = urlComponents?.path else {
            return nil
        }
        guard let type = RouterType(rawValue: path) else {
            return nil
        }
        guard let parameter = RouterParameter(type: type, parameter: url.queryParameters) else {
            return nil
        }
        self = parameter
    }
    init?(type: RouterType, parameter: [String: Any] = [:]) {
        do {
            switch type {
            case .addVisitLog:
                let companyId: Int = try parameter.get("companyId")
                self = .addVisitLog(companyId: companyId)
            case .posDisplay:
                let pageTitle: String? = try parameter.get("posName")
                let latitude: Double = try parameter.get("lat")
                let longitude: Double = try parameter.get("lng")
                self = .posDisplay(pageTitle: pageTitle, latitude: latitude, longitude: longitude)
            case .web:
                let url: String = try parameter.get("url")
                self = .web(url: url)
            case .weex:
                let pageTitle: String? = try parameter.get("title")
                let url: String = try parameter.get("url")
                var param: [String: Any]?
                let paramTemp: String? = try parameter.get("param")
                if let paramTemp = paramTemp {
                    param = Router.parseJSONStringIntoDictionary(JSONString: paramTemp)
                } else {
                    param = nil
                }
                self = .weex(pageTitle: pageTitle, url: url, param: param)
            case .companyDetail:
                let companyId: Int = try parameter.get("companyId")
                self = .companyDetail(companyId: companyId)
            case .privateSea:
                let status: Int? = try parameter.get("status")
                self = .privateSea(status: status)
            case .createBuilding:
                self = .createBuilding
            case .feedback:
                let pageTitle: String? = try parameter.get("title")
                let url: String = try parameter.get("url")
                var param: [String: Any]?
                let paramTemp: String? = try parameter.get("param")
                if let paramTemp = paramTemp {
                    param = Router.parseJSONStringIntoDictionary(JSONString: paramTemp)
                } else {
                    param = nil
                }
                self = .feedback(pageTitle: pageTitle, url: url, param: param)
            case .kps:
                let companyId: Int = try parameter.get("companyId")
                self = .kps(companyId: companyId)
            case .staffVisitLog:
                self = .staffVisitLog
            case .contacts:
                self = .contacts
            case .createCompany:
                self = .createCompany
            case .publicSea:
                self = .publicSea
            case .replenishHistory:
                let shelfId: Int = try parameter.get("shelfId")
                self = .replenishHistory(shelfId: shelfId)
            case .companyList:
                self = .companyList
            case .tabHome:
                self = .tabHome
            case .photoView:
                self = .photoView
            case .signedBillDetail:
                let uniqueId: String = try parameter.get("uniqueId")
                let type: Int = try parameter.get("type")
                self = .signedBillDetail(uniqueId: uniqueId, type: type)
            case .sign:
                let buildingId: Int? = try parameter.get("buildingId")
                let companyId: Int? = try parameter.get("companyId")
                let companyName: String? = try parameter.get("companyName")
                let companyAlias: String? = try parameter.get("companyAlias")
                let kpId: Int? = try parameter.get("kpId")
                let endOrder: Int? = try parameter.get("endOrder")
                var companyPhotos: [PhotoModel]?
                let companyPhotosTemp: String? = try parameter.get("companyPhotos")
                if let companyPhotosTemp = companyPhotosTemp {
                    companyPhotos = Mapper<PhotoModel>().mapArray(JSONString: companyPhotosTemp)
                } else {
                    companyPhotos = nil
                }
                var stationPhotos: [PhotoModel]?
                let stationPhotosTemp: String? = try parameter.get("stationPhotos")
                if let stationPhotosTemp = stationPhotosTemp {
                    stationPhotos = Mapper<PhotoModel>().mapArray(JSONString: stationPhotosTemp)
                } else {
                    stationPhotos = nil
                }
                self = .sign(buildingId: buildingId, companyId: companyId, companyName: companyName, companyAlias: companyAlias, kpId: kpId, endOrder: endOrder, companyPhotos: companyPhotos, stationPhotos: stationPhotos)
            case .trainingVideo:
                self = .trainingVideo
            case .updateCompany:
                let companyId: Int = try parameter.get("companyId")
                self = .updateCompany(companyId: companyId)
            case .tabMine:
                self = .tabMine
            case .visitLog:
                self = .visitLog
            case .tabWorkbench:
                self = .tabWorkbench
            }
        } catch {
            return nil
        }
    }

    var type: RouterType {
        switch self {
        case .addVisitLog:
            return .addVisitLog
        case .posDisplay:
            return .posDisplay
        case .web:
            return .web
        case .weex:
            return .weex
        case .companyDetail:
            return .companyDetail
        case .privateSea:
            return .privateSea
        case .createBuilding:
            return .createBuilding
        case .feedback:
            return .feedback
        case .kps:
            return .kps
        case .staffVisitLog:
            return .staffVisitLog
        case .contacts:
            return .contacts
        case .createCompany:
            return .createCompany
        case .publicSea:
            return .publicSea
        case .replenishHistory:
            return .replenishHistory
        case .companyList:
            return .companyList
        case .tabHome:
            return .tabHome
        case .photoView:
            return .photoView
        case .signedBillDetail:
            return .signedBillDetail
        case .sign:
            return .sign
        case .trainingVideo:
            return .trainingVideo
        case .updateCompany:
            return .updateCompany
        case .tabMine:
            return .tabMine
        case .visitLog:
            return .visitLog
        case .tabWorkbench:
            return .tabWorkbench
        }
    }

    func toDictionary() -> [String: Any] {
        switch self {
        case let .addVisitLog(companyId):
            var parameter: [String: Any] = [:]
            parameter["companyId"] = companyId
            return parameter
        case let .posDisplay(pageTitle, latitude, longitude):
            var parameter: [String: Any] = [:]
            parameter["pageTitle"] = pageTitle
            parameter["latitude"] = latitude
            parameter["longitude"] = longitude
            return parameter
        case let .web(url):
            var parameter: [String: Any] = [:]
            parameter["url"] = url
            return parameter
        case let .weex(pageTitle, url, param):
            var parameter: [String: Any] = [:]
            parameter["pageTitle"] = pageTitle
            parameter["url"] = url
            parameter["param"] = param
            return parameter
        case let .companyDetail(companyId):
            var parameter: [String: Any] = [:]
            parameter["companyId"] = companyId
            return parameter
        case let .privateSea(status):
            var parameter: [String: Any] = [:]
            parameter["status"] = status
            return parameter
        case .createBuilding:
            return [:]
        case let .feedback(pageTitle, url, param):
            var parameter: [String: Any] = [:]
            parameter["pageTitle"] = pageTitle
            parameter["url"] = url
            parameter["param"] = param
            return parameter
        case let .kps(companyId):
            var parameter: [String: Any] = [:]
            parameter["companyId"] = companyId
            return parameter
        case .staffVisitLog:
            return [:]
        case .contacts:
            return [:]
        case .createCompany:
            return [:]
        case .publicSea:
            return [:]
        case let .replenishHistory(shelfId):
            var parameter: [String: Any] = [:]
            parameter["shelfId"] = shelfId
            return parameter
        case .companyList:
            return [:]
        case .tabHome:
            return [:]
        case .photoView:
            return [:]
        case let .signedBillDetail(uniqueId, type):
            var parameter: [String: Any] = [:]
            parameter["uniqueId"] = uniqueId
            parameter["type"] = type
            return parameter
        case let .sign(buildingId, companyId, companyName, companyAlias, kpId, endOrder, companyPhotos, stationPhotos):
            var parameter: [String: Any] = [:]
            parameter["buildingId"] = buildingId
            parameter["companyId"] = companyId
            parameter["companyName"] = companyName
            parameter["companyAlias"] = companyAlias
            parameter["kpId"] = kpId
            parameter["endOrder"] = endOrder
            parameter["companyPhotos"] = companyPhotos
            parameter["stationPhotos"] = stationPhotos
            return parameter
        case .trainingVideo:
            return [:]
        case let .updateCompany(companyId):
            var parameter: [String: Any] = [:]
            parameter["companyId"] = companyId
            return parameter
        case .tabMine:
            return [:]
        case .visitLog:
            return [:]
        case .tabWorkbench:
            return [:]
        }
    }
}
// swiftlint:enable all

public enum RouterError: Error {
    case typeNotMatch
}
