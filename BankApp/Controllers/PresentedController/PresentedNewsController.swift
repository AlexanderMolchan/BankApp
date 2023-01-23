//
//  PresentedNewsController.swift
//  BankApp
//
//  Created by Александр Молчан on 21.01.23.
//

import UIKit
import SwiftSoup
import SDWebImage

class PresentedNewsController: UIViewController {

    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    var presentedNews: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurate()
    }
    
    private func parsingNews() {
        guard let presentedNews else { return }
        do {
            let doc: Document = try SwiftSoup.parse(presentedNews.newsText)
            let parseNews = try doc.text()
            self.newsLabel.text = parseNews
        } catch {
            print("Error")
        }
    }
    
    private func configurate() {
        guard let presentedNews else { return }
        newsImage.sd_setImage(with: URL(string: presentedNews.image))
        parsingNews()
    }
    
    @IBAction func openInBrowserTapped(_ sender: Any) {
        guard let urlString = presentedNews?.link,
              let url = URL(string: urlString)
        else { return }
        UIApplication.shared.open(url)
    }
    
}
