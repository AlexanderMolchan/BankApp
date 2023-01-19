//
//  StoneCell.swift
//  BankApp
//
//  Created by Александр Молчан on 19.01.23.
//

import UIKit

class StoneCell: UITableViewCell {
    static let id = String(describing: StoneCell.self)
    
    @IBOutlet weak var filialLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(model: StoneModel) {
        filialLabel.text = "\(model.city), отделение №\(model.filialNumber)"
        infoLabel.text = "Аттестат №\(model.attestat), \(model.form) \(model.facets) граней, \(model.color), цена \(model.cost) рублей. Вес \(model.weight)г."
    }
    
}
