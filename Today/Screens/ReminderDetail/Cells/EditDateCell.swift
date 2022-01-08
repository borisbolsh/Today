//
//  EditDateCell.swift
//  Today
//
//  Created by Boris Bolshakov on 8.01.22.
//

import UIKit

class EditDateCell: UITableViewCell {
    
    static let identfier = "EditDateCell"
    
    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        return datePicker
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(datePicker)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(date: Date) {
        datePicker.date = date
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        datePicker.frame = CGRect(
            x: Padding.ten,
            y: 0,
            width: contentView.width - Padding.ten,
            height: 100
        )
    }
}
