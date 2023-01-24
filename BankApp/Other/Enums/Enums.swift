//
//  Enums.swift
//  BankApp
//
//  Created by Александр Молчан on 24.01.23.
//

import Foundation

enum MarkerType {
    case atm
    case filial
}

enum FilterButtons: CaseIterable {
    case all
    case atm
    case filial
    
    var name: String {
        switch self {
            case .all:
                return "Все"
            case .atm:
                return "Банкоматы"
            case .filial:
                return "Отделения"
        }
    }
    
}
    
    enum RequestType: String {
        case filials
        case towns
        case atm
        case radius
        case ingots
        case gems
        case news
        case error
        
        var name: String {
            switch self {
                case .filials: return "Отделения"
                case .towns: return "Города"
                case .atm: return "Банкоматы"
                case .radius: return "Ближайшие объекты"
                case .ingots: return "Драгоценные металлы"
                case .gems: return "Драгоценные камни"
                case .news: return "Новости"
                case .error: return "Ошибка сохранения"
            }
        }
        
    }
    

