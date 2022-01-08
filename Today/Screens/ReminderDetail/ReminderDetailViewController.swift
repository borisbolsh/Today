//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by Boris Bolshakov on 7.01.22.
//

import UIKit

class ReminderDetailViewController: UITableViewController {
    
    private var reminder: Reminder?
    private var dataSource: UITableViewDataSource?
//    private var delegate: UITableViewDelegate?
    
    func configure(with reminder: Reminder) {
        self.reminder = reminder
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Details"
        
        setEditing(false, animated: false)
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
        
        tableView.register(EditTitleCell.self,
                           forCellReuseIdentifier: EditTitleCell.identfier)
        tableView.register(EditDateCell.self,
                           forCellReuseIdentifier: EditDateCell.identfier)
        tableView.register(EditNotesCell.self,
                           forCellReuseIdentifier: EditNotesCell.identfier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        guard let reminder = reminder else {
            fatalError("No reminder found for detail view")
        }
        if editing {
            dataSource = ReminderDetailEditDataSource(reminder: reminder)
            navigationItem.title = NSLocalizedString("Edit Reminder", comment: "edit reminder nav title")
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
        } else {
            dataSource = ReminderDetailViewDataSource(reminder: reminder)
            navigationItem.title = NSLocalizedString("View Reminder", comment: "view reminder nav title")
            navigationItem.leftBarButtonItem = nil
            editButtonItem.isEnabled = true
            
        }
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc func cancelButtonTrigger() {
        setEditing(false, animated: true)
    }

}

extension ReminderDetailViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
     }
     
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    
     }
}
