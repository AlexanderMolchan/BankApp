//
//  PresentedNewsController.swift
//  BankApp
//
//  Created by Александр Молчан on 21.01.23.
//

import UIKit

class PresentedNewsController: UIViewController {

    @IBOutlet weak var newsLabel: UILabel!
    
    var presentedNews: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presentedNews else { return }
        newsLabel.text = presentedNews.newsText
    }

}
