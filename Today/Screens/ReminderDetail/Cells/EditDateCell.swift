//
//  EditDateCell.swift
//  Today
//
//  Created by Boris Bolshakov on 8.01.22.
//

import UIKit

class EditDateCell: UITableViewCell {
    
    static let identfier = "EditDateCell"
    typealias DateChangeAction = (Date) -> Void

    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }

        
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        return datePicker
    }()

    private var dateChangeAction: DateChangeAction?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      configureLayout()
        
      datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    private func configureLayout() {
        contentView.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
          
            contentView.topAnchor.constraint(equalTo: datePicker.topAnchor),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: datePicker.trailingAnchor, constant: Padding.twenty),
            contentView.bottomAnchor.constraint(equalTo: datePicker.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: -Padding.twenty),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) not implemented")
    }
    
    func configure(date: Date, changeAction: @escaping DateChangeAction) {
          datePicker.date = date
          self.dateChangeAction = changeAction
      }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
          dateChangeAction?(sender.date)
      }
}
