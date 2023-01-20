//
//  NewsProvider.swift
//  BankApp
//
//  Created by Александр Молчан on 20.01.23.
//

import Foundation
import Moya

final class NewsProvider {
    private let provider = MoyaProvider<NewsAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getNews(success: @escaping ArrayResponce<NewsModel>, failure: @escaping Error) {
        provider.request(.getNews) { result in
            switch result {
                case .success(let response):
                    guard let news = try? JSONDecoder().decode([NewsModel].self, from: response.data) else { return }
                    success(news)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
