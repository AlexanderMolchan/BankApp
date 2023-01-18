//
//  FilialProvider.swift
//  BankApp
//
//  Created by Александр Молчан on 17.01.23.
//

import Foundation
import Moya

typealias ArrayResponce<T: Decodable> = (([T]) -> Void)
typealias ObjectResponce<T: Decodable> = (([T]) -> Void)

typealias Error = ((String) -> Void)

final class FilialProvider {
    private let provider = MoyaProvider<FilialsApi>(plugins: [NetworkLoggerPlugin()])
    
    func getAtmInfo(city: String, success: @escaping ArrayResponce<AtmInfo>, failure: @escaping Error) {
        provider.request(.getAtmInfo(city: city)) { result in
            switch result {
                case .success(let responce):
                    guard let atmInfo = try? JSONDecoder().decode([AtmInfo].self, from: responce.data) else { return }
                    success(atmInfo)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getFilialsInfo(city: String, success: @escaping ArrayResponce<FilialInfo>, failure: @escaping Error) {
        provider.request(.getFilials(city: city)) { result in
            switch result {
                case .success(let responce):
                    guard let filialInfo = try? JSONDecoder().decode([FilialInfo].self, from: responce.data) else { return }
                    success(filialInfo)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getFilialCityList(success: @escaping ArrayResponce<FilialsCity>, failure: @escaping Error) {
        provider.request(.getFilialsCity) { result in
            switch result {
                case .success(let responce):
                    guard let cityList = try? JSONDecoder().decode([FilialsCity].self, from: responce.data)
                    else { return }
                    success(cityList)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getAtmCityList(success: @escaping ArrayResponce<AtmCity>, failure: @escaping Error) {
        provider.request(.getAtmCity) { result in
            switch result {
                case .success(let responce):
                    guard let cityList = try? JSONDecoder().decode([AtmCity].self, from: responce.data)
                    else { return }
                    success(cityList)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
}
