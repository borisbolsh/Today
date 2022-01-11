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
    var headerView = ReminderListHeader(frame: .zero)
    
    let segmentedControl: UISegmentedControl = UISegmentedControl(items: ["Today", "Future", "All"])
    
    private var filter: ReminderListDataSource.Filter {
        return ReminderListDataSource.Filter(rawValue: segmentedControl.selectedSegmentIndex) ?? .today
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTableView()
        setupTableHeaderView()
        setupSegmentedControl()
        setupToolbar()
        self.refreshProgressView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let radius = view.bounds.size.width * 0.5 * 0.7
        headerView.progressContainerView.layer.cornerRadius = radius
        headerView.progressContainerView.layer.masksToBounds = true
        self.refreshProgressView()
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
            self.refreshProgressView()
        })
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - Setup UI
private extension ReminderListViewController {
    func setupTableView() {
        view.addSubview(self.tableView)
        
        reminderListDataSource = ReminderListDataSource(reminderCompletedAction: { reminderIndex in
            self.tableView.reloadRows(at: [IndexPath(row: reminderIndex, section: 0)], with: .automatic)
            self.refreshProgressView()
        }, reminderDeletedAction: {
            self.refreshProgressView()
        })
        tableView.dataSource = reminderListDataSource
        
        self.tableView.delegate = self
        
        tableView.register(ItemTableViewCell.self,
                           forCellReuseIdentifier: ItemTableViewCell.identfier)
        
        tableView.rowHeight = ItemTableViewCell.preferredHeight
    }
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
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
        self.refreshProgressView()
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
                self.refreshProgressView()
            }
            
        })
        
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
        
    }
    
    
    private func refreshProgressView() {
        guard let percentComplete = reminderListDataSource?.percentComplete else {
            return
        }
        let totalHeight = headerView.progressContainerView.bounds.size.height
        headerView.heightConstraint?.constant = totalHeight * CGFloat(percentComplete)
        UIView.animate(withDuration: 0.2) {
            self.headerView.layoutIfNeeded()
        }
    }
}


