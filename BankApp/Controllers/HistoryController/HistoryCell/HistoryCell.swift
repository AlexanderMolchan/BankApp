//
//  HistoryCell.swift
//  BankApp
//
//  Created by Александр Молчан on 24.01.23.
//

import UIKit

class HistoryCell: UITableViewCell {
    static let id = String(describing: HistoryCell.self)
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var statusCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(request: RequestModel) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let formatedTime = formatter.string(from: request.date)
        timeLabel.text = formatedTime
        requestLabel.text = "Запрос \"\(request.enumType.name)\" выполнен."
        statusCodeLabel.text = "Код ответа: \(request.statusCode)"
    }

}
