//
//  NewsViewController.swift
//  BankApp
//
//  Created by Александр Молчан on 21.01.23.
//

import UIKit
import SwiftSoup

class NewsViewController: UIViewController, NewsDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var newsArray = [NewsModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSettings()
        tableViewSettingas()
        getNewsData()
    }
    
    private func tableViewSettingas() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NewsCell.id, bundle: nil), forCellReuseIdentifier: NewsCell.id)
    }
    
    private func navigationBarSettings() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemCyan
        navigationItem.title = "Новости"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemCyan, NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 30) as Any]
    }
    
    private func getNewsData() {
        activityIndicator.startAnimating()
        NewsProvider().getNews { result in
            self.newsArray = result
            self.activityIndicator.stopAnimating()
        } failure: { _ in
            self.activityIndicator.stopAnimating()
        }
    }

}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.id, for: indexPath)
        guard let newsCell = cell as? NewsCell else { return cell }
        newsCell.set(news: newsArray[indexPath.row], delegate: self)
        
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func present(news: NewsModel) {
        let presentedVc = PresentedNewsController(nibName: String(describing: PresentedNewsController.self), bundle: nil)
            presentedVc.presentedNews = news
            present(presentedVc, animated: true)
        }
    
    }

    

