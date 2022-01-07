//
//  ReminderListViewController.swift
//  Today
//
//  Created by Boris Bolshakov on 30.12.21.
//

import UIKit

final class ReminderListViewController: UIViewController {

    private let tableView = UITableView()
    
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

// MARK: - UITableViewDataSource

extension ReminderListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Reminder.testData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemTableViewCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identfier, for: indexPath) as! ItemTableViewCell
        
        let reminder = Reminder.testData[indexPath.row]
        
        cell.configure(with: reminder.title, date: reminder.dueDate.description, isComplete: reminder.isComplete)
        return cell
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
        self.tableView.dataSource = self
        self.tableView.delegate = self

        tableView.register(ItemTableViewCell.self,
                           forCellReuseIdentifier: ItemTableViewCell.identfier)
    }
    
}
