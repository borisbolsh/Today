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
        
        self.navigationController?.isToolbarHidden = false

        var items = [UIBarButtonItem]()

        items.append( UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTriggered)) )

        self.toolbarItems = items
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = navigationController,
           navigationController.isToolbarHidden {
            navigationController.setToolbarHidden(false, animated: animated)
        }
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
        
        let reminder = Reminder.testData[indexPath.row]
        
        vc.configure(with: reminder){ reminder in
            self.reminderListDataSource?.update(reminder, at: indexPath.row)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
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

// MARK: Add new reminder
extension ReminderListViewController {
    
    @objc func addButtonTriggered() {
        addReminder()
    }
    
    private func addReminder() {
        let vc = ReminderDetailViewController()
        
        let reminder = Reminder(title: "New Reminder", dueDate: Date(), notes: "Your note"  )
        
        vc.configure(with: reminder, isNew: true, addAction: { reminder in
            self.reminderListDataSource?.add(reminder)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)

        })

        
        let navigationController = UINavigationController(rootViewController: vc)
        
        present(navigationController, animated: true, completion: nil)
        
    }
}
