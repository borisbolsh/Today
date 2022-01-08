//
//  ReminderListDataSource.swift
//  Today
//
//  Created by Boris Bolshakov on 8.01.22.
//

import UIKit

class ReminderListDataSource: NSObject {
    private lazy var dateFormatter = RelativeDateTimeFormatter()
}

extension ReminderListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Reminder.testData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identfier, for: indexPath) as! ItemTableViewCell
       
        let reminder = Reminder.testData[indexPath.row]
        
        let dateText = dateFormatter.localizedString(for: reminder.dueDate, relativeTo: Date())
        
        cell.configure(with: reminder.title, date: dateText, isComplete: reminder.isComplete){
            Reminder.testData[indexPath.row].isComplete.toggle()
            tableView.reloadRows(at: [indexPath], with: .none)
        }

        return cell
    }
    
}
