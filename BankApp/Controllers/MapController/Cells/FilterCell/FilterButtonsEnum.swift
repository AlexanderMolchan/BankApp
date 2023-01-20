//
//  FilterButtonsEnum.swift
//  BankApp
//
//  Created by Александр Молчан on 17.01.23.
//

import Foundation

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

