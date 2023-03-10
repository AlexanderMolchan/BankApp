//
//  FilialsAPI.swift
//  BankApp
//
//  Created by Александр Молчан on 17.01.23.
//

import Foundation
import Moya

enum FilialsApi {
    case getFilialsCity
    case getAtmCity
    case getAtmInfo(city: String)
    case getFilials(city: String)
}

extension FilialsApi: TargetType {
    var baseURL: URL {
        switch self {
            case .getAtmInfo, .getAtmCity:
                return URL(string: "https://belarusbank.by/api/atm")!
            case .getFilials, .getFilialsCity:
                return URL(string: "https://belarusbank.by/api/filials_info")!
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        switch self {
            case .getAtmInfo: return .get
            case .getFilials: return .get
            case .getFilialsCity: return .get
            case .getAtmCity: return .get
        }
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        var params = [String: Any]()
        switch self {
            case .getAtmInfo(let city):
                params["city"] = city
            case .getFilials(let city):
                params["city"] = city
            case .getFilialsCity, .getAtmCity:
                return nil
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .getAtmInfo, .getFilials, .getFilialsCity, .getAtmCity:
                return URLEncoding.queryString
        }
    }
}

