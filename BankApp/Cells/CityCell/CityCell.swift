//
//  CityCell.swift
//  BankApp
//
//  Created by Александр Молчан on 17.01.23.
//

import UIKit

class CityCell: UICollectionViewCell {
    static let id = String(describing: CityCell.self)

    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCollectionCell(city: String) {
        backgroundColor = .systemCyan.withAlphaComponent(0.9)
        layer.borderWidth = 0
        layer.borderColor = UIColor.systemCyan.cgColor
        cityLabel.textColor = .white
        cityLabel.text = city
        layer.cornerRadius = 10
        if self.isSelected {
            backgroundColor = .white.withAlphaComponent(0.9)
            cityLabel.textColor = .systemCyan
            layer.borderWidth = 2
        }
    }

}
