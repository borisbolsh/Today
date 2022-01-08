//
//  EditNotesCell.swift
//  Today
//
//  Created by Boris Bolshakov on 8.01.22.
//

import UIKit

class EditNotesCell: UITableViewCell {
    
    static let identfier = "EditNotesCell"

    var notesTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Default text"
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(notesTextView)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(notes: String?) {
        notesTextView.text = notes
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        notesTextView.frame = CGRect(
            x: Padding.ten,
            y: 0,
            width: contentView.width - Padding.ten,
            height: 100
        )
    }
}
