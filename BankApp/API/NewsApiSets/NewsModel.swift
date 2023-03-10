//
//  NewsModel.swift
//  BankApp
//
//  Created by Александр Молчан on 20.01.23.
//

import Foundation

struct NewsModel: Decodable {
    var name: String
    var newsText: String
    var image: String
    var date: String
    var link: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name_ru"
        case newsText = "html_ru"
        case image = "img"
        case date = "start_date"
        case link = "link"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.newsText = try container.decode(String.self, forKey: .newsText)
        self.image = try container.decode(String.self, forKey: .image)
        self.date = try container.decode(String.self, forKey: .date)
        self.link = try container.decode(String.self, forKey: .link)
    }
}
