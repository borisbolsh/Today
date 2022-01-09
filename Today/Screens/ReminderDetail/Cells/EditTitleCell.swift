//
//  EditTitleCell.swift
//  Today
//
//  Created by Boris Bolshakov on 8.01.22.
//

import UIKit

class EditTitleCell: UITableViewCell {
    
    static let identfier = "EditTitleCell"
    typealias TitleChangeAction = (String) -> Void
    
    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Default text"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var titleChangeAction: TitleChangeAction?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      configureLayout()
      titleTextField.delegate = self
    }
    
    private func configureLayout() {
        contentView.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
          
            contentView.topAnchor.constraint(equalTo: titleTextField.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor, constant: Padding.twenty),
            contentView.bottomAnchor.constraint(equalTo: titleTextField.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor, constant: -Padding.twenty),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) not implemented")
    }
    
    func configure(title: String, changeAction: @escaping TitleChangeAction) {
        titleTextField.text = title
        self.titleChangeAction = changeAction
    }
    
    
}

extension EditTitleCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let originalText = textField.text {
            let title = (originalText as NSString).replacingCharacters(in: range, with: string)
            titleChangeAction?(title)
        }
        return true
    }
}
