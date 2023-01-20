//
//  NewsCell.swift
//  BankApp
//
//  Created by Александр Молчан on 21.01.23.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    static let id = String(describing: NewsCell.self)
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var fullNewsOutlet: UIButton!
    
    weak var delegate: NewsDelegate?
    private var currentNews: NewsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(news: NewsModel, delegate: NewsDelegate?) {
        self.delegate = delegate
        self.currentNews = news
        newsLabel.text = news.name
        newsImage.sd_setImage(with: URL(string: news.image))
    }
    
    @IBAction func fullNewsTapped(_ sender: UIButton) {
        guard let currentNews else { return }
        delegate?.present(news: currentNews)
    }

}

protocol NewsDelegate: AnyObject {
    func present(news: NewsModel)
}
