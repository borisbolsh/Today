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
    
    let segmentedControl: UISegmentedControl = UISegmentedControl(items: ["Today", "Future", "All"])
    
    private var filter: ReminderListDataSource.Filter {
        return ReminderListDataSource.Filter(rawValue: segmentedControl.selectedSegmentIndex) ?? .today
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTableView()
        setupSegmentedControl()
        setupToolbar()
        
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
        
        vc.configure(with: reminder, editAction: { reminder in
            self.reminderListDataSource?.update(reminder, at: indexPath.row)
            self.tableView.reloadData()
        })
        
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
    
    func setupSegmentedControl() {
        
        segmentedControl.sizeToFit()
        segmentedControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmentedControl
        
        segmentedControl.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
        
    }
    
    @objc func segmentControlChanged () {
        reminderListDataSource?.filter = filter
        tableView.reloadData()
    }
    
    func setupToolbar() {
        self.navigationController?.isToolbarHidden = false
        
        var items = [UIBarButtonItem]()
        
        items.append( UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTriggered)) )
        
        self.toolbarItems = items
    }
    
}

// MARK: Add new reminder
extension ReminderListViewController {
    
    @objc func addButtonTriggered() {
        addReminder()
    }
    
    private func addReminder() {
        let vc = ReminderDetailViewController()
        
        let reminder = Reminder(id: UUID().uuidString, title: "New Reminder", dueDate: Date())
        
        vc.configure(with: reminder, isNew: true, addAction: { reminder in
            if let index = self.reminderListDataSource?.add(reminder) {
                self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
            
        })
        
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
        
    }
    
}


