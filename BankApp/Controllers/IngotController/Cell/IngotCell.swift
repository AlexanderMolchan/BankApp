//
//  IngotCell.swift
//  BankApp
//
//  Created by Александр Молчан on 19.01.23.
//

import UIKit

class IngotCell: UITableViewCell {
    static let id = String(describing: IngotCell.self)
    
    @IBOutlet weak var filialLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tenLabel: UILabel!
    @IBOutlet weak var twentyLabel: UILabel!
    @IBOutlet weak var fiftyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(model: IngotModel, type: IngotType) {
        filialLabel.text = "\(model.city), отделение №\(model.filialNumber)"
        var tenCost = ""
        var twentyCost = ""
        var fiftyCost = ""
        switch type {
            case .gold:
                typeLabel.textColor = .systemOrange
                tenCost = model.goldTen
                twentyCost = model.goldTwenty
                fiftyCost = model.goldFifty
            case .silver:
                typeLabel.textColor = .lightGray
                tenCost = model.silverTen
                twentyCost = model.silverTwenty
                fiftyCost = model.silverFifty
            case .platinum:
                typeLabel.textColor = .darkGray
                tenCost = model.platinumTen
                twentyCost = model.platinumTwenty
                fiftyCost = model.platinumFifty
        }
        if tenCost == "0.00" {
            tenCost = "Нет в наличиии"
        }
        if twentyCost == "0.00" {
            twentyCost = "Нет в наличиии"
        }
        if fiftyCost == "0.00" {
            fiftyCost = "Нет в наличиии"
        }
        typeLabel.text = type.rawValue
        tenLabel.text = "Цена за слиток 10г. \(tenCost)"
        twentyLabel.text = "Цена за слиток 20г. \(twentyCost)"
        fiftyLabel.text = "Цена за слиток 50г. \(fiftyCost)"
    }
    
}

enum IngotType: String {
    case silver = "Серебро"
    case gold = "Золото"
    case platinum = "Платина"
}
