//
//  FilterCell.swift
//  BankApp
//
//  Created by Александр Молчан on 17.01.23.
//

import UIKit

class FilterCell: UICollectionViewCell {
    static let id = String(describing: FilterCell.self)
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(button: FilterButtons) {
        buttonLabel.text = button.name
        layer.cornerRadius = 10
        layer.borderWidth = self.isSelected ? 2 : 0
    }

}
