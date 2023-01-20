//
//  NewsAPI.swift
//  BankApp
//
//  Created by Александр Молчан on 20.01.23.
//

import Foundation
import Moya

enum NewsAPI {
    case getNews
}

extension NewsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://belarusbank.by/api/news_info")!
    }
    
    var path: String {
        return ""
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
        var params = [String: Any]()
        switch self {
            case .getNews:
                params["lang"] = "ru"
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
}
