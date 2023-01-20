//
//  GemProvider.swift
//  BankApp
//
//  Created by Александр Молчан on 19.01.23.
//

import Foundation
import Moya

final class GemProvider {
    private let provider = MoyaProvider<GemAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getStonesInfo(success: @escaping ArrayResponce<StoneModel>, failure: @escaping Error) {
        provider.request(.getStonesInfo) { result in
            switch result {
                case .success(let response):
                    guard let stonesInfo = try? JSONDecoder().decode([StoneModel].self, from: response.data) else { return }
                    success(stonesInfo)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getIngotsInfo(succes: @escaping ArrayResponce<IngotModel>, failure: @escaping Error) {
        provider.request(.getIngotInfo) { result in
            switch result {
                case .success(let response):
                    guard let ingotsInfo = try? JSONDecoder().decode([IngotModel].self, from: response.data) else { return }
                    succes(ingotsInfo)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
