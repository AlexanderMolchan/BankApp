//
//  HistoryController.swift
//  BankApp
//
//  Created by Александр Молчан on 24.01.23.
//

import UIKit

class HistoryController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var deleteAllButton = UIBarButtonItem()
    
    private var historyArray = RealmManager<RequestModel>().read() {
        didSet {
//            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSettings()
        tableViewSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArray()
    }

    private func navigationBarSettings() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemCyan
        navigationItem.title = "История запросов"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemCyan, NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 30) as Any]
        deleteAllButton = UIBarButtonItem(image: UIImage(systemName: "trash.circle"), style: .done, target: self, action: #selector(deleteAll))
        navigationItem.rightBarButtonItem = deleteAllButton
    }
    
    private func updateArray() {
        historyArray = RealmManager<RequestModel>().read()
        deleteAllButton.isEnabled = !historyArray.isEmpty
        tableView.reloadData()
    }
    
    @objc private func deleteAll() {
        if !historyArray.isEmpty {
            deleteAllAlert()
        }
    }
    
    private func tableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: HistoryCell.id, bundle: nil), forCellReuseIdentifier: HistoryCell.id)
    }
    
    private func deleteAllAlert() {
        let alert = UIAlertController(title: "Удалить всё?", message: "Вы уверены, что хотите удалить всю историю запросов?", preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: "Отмена", style: .cancel)
        let okBtn = UIAlertAction(title: "Подтвердить", style: .destructive) { _ in
            self.historyArray.forEach() { model in
                RealmManager<RequestModel>().delete(object: model)
                self.updateArray()
            }
        }
        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        present(alert, animated: true)
    }
    
}

extension HistoryController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.id, for: indexPath)
        guard let historyCell = cell as? HistoryCell else { return cell }
        historyCell.set(request: historyArray[indexPath.row])
        
        return historyCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = historyArray[indexPath.row]
            tableView.performBatchUpdates {
                RealmManager<RequestModel>().delete(object: model)
                self.historyArray.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
            }
        }
    }
    
}
