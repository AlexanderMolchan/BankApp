//
//  EmptyView.swift
//  BankApp
//
//  Created by Александр Молчан on 26.01.23.
//

import UIKit

class EmptyView: UIView {
    
    @IBOutlet var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: EmptyView.self), owner: self)
        addSubview(containerView)
        containerView.frame = bounds
    }
    
}
