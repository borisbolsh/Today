//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by Boris Bolshakov on 7.01.22.
//

import UIKit

class ReminderDetailViewController: UITableViewController {
    
    enum ReminderRow: Int, CaseIterable {
        case title
        case date
        case time
        case notes
        
        func displayText(for reminder: Reminder?) -> String? {
            switch self {
            case .title:
                return reminder?.title
            case .date:
                return reminder?.dueDate.description
            case .time:
                return reminder?.dueDate.description
            case .notes:
                return reminder?.notes
            }
        }
        
        var cellImage: UIImage? {
            switch self {
            case .title:
                return nil
            case .date:
                return UIImage(systemName: "calendar.circle")
            case .time:
                return UIImage(systemName: "clock")
            case .notes:
                return UIImage(systemName: "square.and.pencil")
            }
        }
    }
    
    var reminder: Reminder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTableView()
        title = "Details"
    }
    
    func configure(with reminder: Reminder) {
        self.reminder = reminder
    }
    
}

// MARK: - Setup UI

private extension ReminderDetailViewController {
    func setupTableView() {

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(ReminderDetailCell.self,
                           forCellReuseIdentifier: ItemTableViewCell.identfier)
    }
    
}

// MARK: - Table view data source
extension ReminderDetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderRow.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ReminderDetailCell.identfier, for: indexPath) as! ReminderDetailCell
        let cell = UITableViewCell()
        let row = ReminderRow(rawValue: indexPath.row)
        cell.textLabel?.text = row?.displayText(for: reminder)
        cell.imageView?.image = row?.cellImage
        return cell
    }
    
    
}
