//
//  ReminderListViewController.swift
//  Today
//
//  Created by Boris Bolshakov on 30.12.21.
//

import UIKit

final class ReminderListViewController: UIViewController {

    private let tableView = UITableView()
    private var reminderListDataSource: ReminderListDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTableView()
        title = "TodayApp"
    }

    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       
       tableView.frame = view.bounds
   }

}

// MARK: - UITableViewDelegate
extension ReminderListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ReminderDetailViewController()
        vc.configure(with: Reminder.testData[indexPath.row])
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - Setup UI
private extension ReminderListViewController {
    func setupTableView() {
        view.addSubview(self.tableView)
        
        reminderListDataSource = ReminderListDataSource()
        tableView.dataSource = reminderListDataSource
        
        self.tableView.delegate = self

        tableView.register(ItemTableViewCell.self,
                           forCellReuseIdentifier: ItemTableViewCell.identfier)
        
        tableView.rowHeight = ItemTableViewCell.preferredHeight
    }
    
}
