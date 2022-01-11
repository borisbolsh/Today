//
//  ReminderListDataSource.swift
//  Today
//
//  Created by Boris Bolshakov on 8.01.22.
//

import UIKit

class ReminderListDataSource: NSObject {
    
    typealias ReminderCompletedAction = (Int) -> Void
    typealias ReminderDeletedAction = () -> Void
    private lazy var dateFormatter = RelativeDateTimeFormatter()
    
    enum Filter: Int {
        case today
        case future
        case all
        
        func shouldInclude(date: Date) -> Bool {
            let isInToday = Locale.current.calendar.isDateInToday(date)
            switch self {
            case .today:
                return isInToday
            case .future:
                return (date > Date()) && !isInToday
            case .all:
                return true
            }
        }
    }
    
    var filter: Filter = .today
    
    var filteredReminders: [Reminder] {
        return Reminder.testData.filter { filter.shouldInclude(date: $0.dueDate) }.sorted { $0.dueDate < $1.dueDate }
    }
    
    var percentComplete: Double {
        guard filteredReminders.count > 0 else {
            return 1
        }
        let numComplete: Double = filteredReminders.reduce(0) { $0 + ($1.isComplete ? 1 : 0) }
        return numComplete / Double(filteredReminders.count)
    }
    
    private var reminderCompletedAction: ReminderCompletedAction?
    private var reminderDeletedAction: ReminderDeletedAction?
       
   init(reminderCompletedAction: @escaping ReminderCompletedAction, reminderDeletedAction: @escaping ReminderDeletedAction) {
       self.reminderCompletedAction = reminderCompletedAction
       self.reminderDeletedAction = reminderDeletedAction
       super.init()
   }
    
    func update(_ reminder: Reminder, at row: Int) {
        let index = self.index(for: row)
        Reminder.testData[index] = reminder
    }
    
    func delete(at row: Int) {
        let index = self.index(for: row)
        Reminder.testData.remove(at: index)
    }
    
    func reminder(at row: Int) -> Reminder {
        return filteredReminders[row]
    }
    
    func add(_ reminder: Reminder) -> Int? {
        Reminder.testData.insert(reminder, at: 0)
        return filteredReminders.firstIndex(where: { $0.id == reminder.id })
    }
    
    func index(for filteredIndex: Int) -> Int {
        let filteredReminder = filteredReminders[filteredIndex]
        guard let index = Reminder.testData.firstIndex(where: { $0.id == filteredReminder.id }) else {
            fatalError("Couldn't retrieve index in source array")
        }
        return index
    }
}

extension ReminderListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredReminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identfier, for: indexPath) as! ItemTableViewCell
        
        let currentReminder = reminder(at: indexPath.row)
        let dateText = currentReminder.dueDateTimeText(for: filter)
        
        cell.configure(with: currentReminder.title, date: dateText, isComplete: currentReminder.isComplete) {
            var modifiedReminder = currentReminder
            modifiedReminder.isComplete.toggle()
            self.update(modifiedReminder, at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .none)
            self.reminderCompletedAction?(indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        delete(at: indexPath.row)
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }) { (_) in
            tableView.reloadData()
        }
        reminderDeletedAction?()
    }
    
}


extension Reminder {
    
    static let timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter
    }()
    
    static let futureDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    static let todayDateFormatter: DateFormatter = {
        let format = NSLocalizedString("'Today at '%@", comment: "format string for dates occurring today")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = String(format: format, "hh:mm a")
        return dateFormatter
    }()
    
    
    func dueDateTimeText(for filter: ReminderListDataSource.Filter) -> String {
        let isInToday = Locale.current.calendar.isDateInToday(dueDate)
        switch filter {
        case .today:
            return Self.timeFormatter.string(from: dueDate)
        case .future:
            return Self.futureDateFormatter.string(from: dueDate)
        case .all:
            if isInToday {
                return Self.todayDateFormatter.string(from: dueDate)
            } else {
                return Self.futureDateFormatter.string(from: dueDate)
            }
        }
    }
    
    
    
}
