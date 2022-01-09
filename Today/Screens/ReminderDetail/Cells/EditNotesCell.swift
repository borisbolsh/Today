//
//  EditNotesCell.swift
//  Today
//
//  Created by Boris Bolshakov on 8.01.22.
//

import UIKit

class EditNotesCell: UITableViewCell {
    
    static let identfier = "EditNotesCell"
    typealias NotesChangeAction = (String) -> Void

    var notesTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Default text"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var notesChangeAction: NotesChangeAction?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      configureLayout()
      notesTextView.delegate = self
    }
    
    private func configureLayout() {
        contentView.addSubview(notesTextView)
        
        NSLayoutConstraint.activate([
          
            contentView.topAnchor.constraint(equalTo: notesTextView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: notesTextView.trailingAnchor, constant: Padding.twenty),
            contentView.bottomAnchor.constraint(equalTo: notesTextView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: notesTextView.leadingAnchor, constant: -Padding.twenty),
            notesTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100.0),
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) not implemented")
    }
    
    func configure(notes: String?, changeAction: NotesChangeAction?) {
          notesTextView.text = notes
          self.notesChangeAction = changeAction
      }
    
    
}

extension EditNotesCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let originalText = textView.text {
            let title = (originalText as NSString).replacingCharacters(in: range, with: text)
            notesChangeAction?(title)
        }
        return true
    }
}
