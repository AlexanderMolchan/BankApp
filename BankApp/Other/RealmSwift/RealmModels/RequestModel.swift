//
//  RequestModel.swift
//  BankApp
//
//  Created by Александр Молчан on 24.01.23.
//

import Foundation
import RealmSwift

class RequestModel: Object {
    @objc dynamic var date: Date = Date()
    @objc dynamic var statusCode: Int = Int()
    @objc private dynamic var type = RequestType.news.rawValue
    
    var enumType: RequestType {
        get {
            return RequestType(rawValue: type) ?? .error
        } set {
            return type = newValue.rawValue
        }
    }
    
    convenience init(date: Date, statusCode: Int, type: RequestType.RawValue) {
        self.init()
        self.date = date
        self.statusCode = statusCode
        self.type = type
    }
    
}
