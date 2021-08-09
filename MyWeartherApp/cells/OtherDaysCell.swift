//
//  OtherDaysCell.swift
//  APIExample
//
//  Created by Aleksei Elin on 15.07.21.
//

import UIKit

final class OtherDaysCell: UITableViewCell {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: [OtherDayModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 38
        tableView.register(cellType: OtherDayCell.self)
    }
    
    func setupWith(model: [OtherDayModel]) {
        dataSource = model
        tableView.reloadData()
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension OtherDaysCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: OtherDayCell.self, for: indexPath)
        cell.setupWith(model: dataSource[indexPath.row])
        cell.backgroundColor = UIColor.clear
    
        return cell
    }
}
