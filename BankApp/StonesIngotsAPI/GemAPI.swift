//
//  GemAPI.swift
//  BankApp
//
//  Created by Александр Молчан on 19.01.23.
//

import Foundation
import Moya

enum GemAPI {
    case getStonesInfo
    case getIngotInfo
}

extension GemAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://belarusbank.by/api")!
    }
    
    var path: String {
        switch self {
            case .getStonesInfo:
                return "/getgems"
            case .getIngotInfo:
                return "/getinfodrall"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
//        var params = [String: Any]()
        return nil
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.queryString
    }
}


