//
//  IngotViewController.swift
//  BankApp
//
//  Created by Александр Молчан on 19.01.23.
//

import UIKit

class IngotViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyContainerView: UIView!
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    private var ingotType: IngotType = .gold
    private var ingotArray = [IngotModel]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

    private func tableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: IngotCell.id, bundle: nil), forCellReuseIdentifier: IngotCell.id)
        
        emptyContainerView.alpha = 0.8
        emptyContainerView.isHidden = true
        segmentOutlet.isHidden = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemCyan
        navigationItem.title = "Драгоценные металлы"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemCyan, NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 30) as Any]
    }
    
    private func getData() {
        activityIndicator.startAnimating()
        GemProvider().getIngotsInfo { result in
            result.forEach { model in
                if model.goldTen != "0.00" || model.silverTen != "0.00" || model.platinumTen != "0.00" {
                    self.ingotArray.append(model)
                }
                self.tableView.reloadData()
                self.emptyImageSet()
            }
            self.activityIndicator.stopAnimating()
        } failure: { error in
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func emptyImageSet() {
        tableView.reloadData()
        if ingotArray.isEmpty {
            emptyContainerView.isHidden = false
            tableView.isHidden = true
            segmentOutlet.isHidden = true
        } else {
            emptyContainerView.isHidden = true
            tableView.isHidden = false
            segmentOutlet.isHidden = false
        }
    }
    
    @IBAction func segmentChangeValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            ingotType = .gold
        } else if sender.selectedSegmentIndex == 1 {
            ingotType = .silver
        } else {
            ingotType = .platinum
        }
        tableView.reloadData()
    }

}

extension IngotViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingotArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngotCell.id, for: indexPath)
        guard let ingotCell = cell as? IngotCell else { return cell }
        
        ingotCell.set(model: ingotArray[indexPath.row], type: ingotType)
        return ingotCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
