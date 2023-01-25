//
//  UserDefaults.swift
//  BankApp
//
//  Created by Александр Молчан on 25.01.23.
//

import Foundation

class DefaultsManager {
    private static let defaults = UserDefaults.standard
    
    static var firstStart: Bool {
        get {
            defaults.value(forKey: #function) as? Bool ?? true
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var savedTownArray: [String] {
        get {
            defaults.value(forKey: #function) as? [String] ?? [String]()
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
}
