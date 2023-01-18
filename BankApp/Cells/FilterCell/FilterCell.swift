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
        backgroundColor = .systemCyan.withAlphaComponent(0.9)
        layer.borderWidth = 0
        layer.borderColor = UIColor.systemCyan.cgColor
        buttonLabel.textColor = .white
        buttonLabel.text = button.name
        layer.cornerRadius = 10
        if self.isSelected {
            self.layer.borderWidth = 2
            backgroundColor = .white.withAlphaComponent(0.9)
            buttonLabel.textColor = .systemCyan
        }
    }

}
