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
        cityLabel.text = city
        layer.cornerRadius = 10
        layer.borderWidth = self.isSelected ? 2 : 0
    }

}
