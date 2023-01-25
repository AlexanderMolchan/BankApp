//
//  FilialModel.swift
//  BankApp
//
//  Created by Александр Молчан on 17.01.23.
//

import Foundation

struct FilialsCity: Decodable {
    var city: String
    var cityType: String

    enum CodingKeys: String, CodingKey {
        case city = "name"
        case cityType = "name_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.cityType = try container.decode(String.self, forKey: .cityType)
    }
    
}

struct AtmCity: Decodable {
    var city: String
    var cityType: String

    enum CodingKeys: String, CodingKey {
        case city = "city"
        case cityType = "city_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.cityType = try container.decode(String.self, forKey: .cityType)
    }
    
}

struct AtmInfo: Decodable {
    var latitude: String
    var longitude: String
    var cashIn: String
    var address: String
    var house: String
    var city: String
    var atmError: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "gps_x"
        case longitude = "gps_y"
        case cashIn = "cash_in"
        case address = "address"
        case house = "house"
        case city = "city"
        case atmError = "ATM_error"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
        cashIn = try container.decode(String.self, forKey: .cashIn)
        address = try container.decode(String.self, forKey: .address)
        house = try container.decode(String.self, forKey: .house)
        city = try container.decode(String.self, forKey: .city)
        atmError = try container.decode(String.self, forKey: .atmError)
    }
    
}

struct FilialInfo: Decodable {
    var latitude: String
    var longitude: String
    var name: String
    var street: String
    var house: String
    var city: String
    var phone: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "GPS_X"
        case longitude = "GPS_Y"
        case name = "filial_name"
        case street = "street"
        case house = "home_number"
        case city = "name"
        case phone = "phone_info"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
        name = try container.decode(String.self, forKey: .name)
        street = try container.decode(String.self, forKey: .street)
        house = try container.decode(String.self, forKey: .house)
        city = try container.decode(String.self, forKey: .city)
        phone = try container.decode(String.self, forKey: .phone)
    }
    
}
