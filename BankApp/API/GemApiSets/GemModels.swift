//
//  GemModels.swift
//  BankApp
//
//  Created by Александр Молчан on 19.01.23.
//

import Foundation

struct StoneModel: Decodable {
    var attestat: String
    var form: String
    var facets: String
    var weight: String
    var color: String
    var cost: String
    var city: String
    var filialNumber: String

    enum CodingKeys: String, CodingKey {
        case attestat = "attestat"
        case form = "name_ru"
        case facets = "grani"
        case weight = "weight"
        case color = "color"
        case cost = "cost"
        case city = "name"
        case filialNumber = "filial_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attestat = try container.decode(String.self, forKey: .attestat)
        self.form = try container.decode(String.self, forKey: .form)
        self.facets = try container.decode(String.self, forKey: .facets)
        self.weight = try container.decode(String.self, forKey: .weight)
        self.color = try container.decode(String.self, forKey: .color)
        self.cost = try container.decode(String.self, forKey: .cost)
        self.city = try container.decode(String.self, forKey: .city)
        self.filialNumber = try container.decode(String.self, forKey: .filialNumber)
    }
}

struct IngotModel: Decodable {
    var goldTen: String
    var goldTwenty: String
    var goldFifty: String
    var silverTen: String
    var silverTwenty: String
    var silverFifty: String
    var platinumTen: String
    var platinumTwenty: String
    var platinumFifty: String
    var city: String
    var filialNumber: String
    
    enum CodingKeys: String, CodingKey {
        case goldTen = "ZOL_10_out"
        case goldTwenty = "ZOL_20_out"
        case goldFifty = "ZOL_50_out"
        case silverTen = "SIL_10_out"
        case silverTwenty = "SIL_20_out"
        case silverFifty = "SIL_50_out"
        case platinumTen = "PL_10_out"
        case platinumTwenty = "PL_20_out"
        case platinumFifty = "PL_50_out"
        case city = "name"
        case filialNumber = "filial_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.goldTen = try container.decode(String.self, forKey: .goldTen)
        self.goldTwenty = try container.decode(String.self, forKey: .goldTwenty)
        self.goldFifty = try container.decode(String.self, forKey: .goldFifty)
        self.silverTen = try container.decode(String.self, forKey: .silverTen)
        self.silverTwenty = try container.decode(String.self, forKey: .silverTwenty)
        self.silverFifty = try container.decode(String.self, forKey: .silverFifty)
        self.platinumTen = try container.decode(String.self, forKey: .platinumTen)
        self.platinumTwenty = try container.decode(String.self, forKey: .platinumTwenty)
        self.platinumFifty = try container.decode(String.self, forKey: .platinumFifty)
        self.city = try container.decode(String.self, forKey: .city)
        self.filialNumber = try container.decode(String.self, forKey: .filialNumber)
    }
}
