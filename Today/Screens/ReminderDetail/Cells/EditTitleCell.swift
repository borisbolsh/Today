//
//  EditTitleCell.swift
//  Today
//
//  Created by Boris Bolshakov on 8.01.22.
//

import UIKit

class EditTitleCell: UITableViewCell {
    
    static let identfier = "EditTitleCell"
    
    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Default text"
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleTextField)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(title: String) {
        titleTextField.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleTextField.frame = CGRect(
            x: Padding.ten,
            y: 0,
            width: contentView.width - Padding.ten,
            height: 50
        )
    }
}
