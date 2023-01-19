//
//  StonesViewController.swift
//  BankApp
//
//  Created by Александр Молчан on 19.01.23.
//

import UIKit

class StonesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var stonesArray = [StoneModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings()
        getData()
    }

    private func tableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: StoneCell.id, bundle: nil), forCellReuseIdentifier: StoneCell.id)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemCyan
        navigationItem.title = "Драгоценные камни"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemCyan, NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 40) as Any]
    }
    
    private func getData() {
        activityIndicator.startAnimating()
        GemProvider().getStonesInfo { result in
            self.stonesArray = result
            self.activityIndicator.stopAnimating()
        } failure: { error in
            self.activityIndicator.stopAnimating()
        }
    }
    
}

extension StonesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stonesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoneCell.id, for: indexPath)
        guard let stoneCell = cell as? StoneCell else { return cell }
        stoneCell.set(model: stonesArray[indexPath.row])
        return stoneCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
