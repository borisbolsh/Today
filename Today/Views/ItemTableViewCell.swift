//
//  ItemTableViewCell.swift
//  Today
//
//  Created by Boris Bolshakov on 30.12.21.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    
    static let identfier = "ItemTableViewCell"
    static let preferredHeight: CGFloat = 80
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let chechboxButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "circle")
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        button.layer.masksToBounds = true
        return button
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(chechboxButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnSize: CGFloat = contentView.height / 2
        chechboxButton.frame = CGRect(
            x: Padding.ten,
            y: (contentView.height - btnSize) / 2,
            width: btnSize,
            height: btnSize
        )
        chechboxButton.layer.cornerRadius = btnSize / 2
        chechboxButton.layer.masksToBounds = true
        
        titleLabel.frame = CGRect(
            x: chechboxButton.right + Padding.ten,
            y: Padding.ten,
            width: contentView.width - btnSize - Padding.twenty,
            height: 30
        )
        
        dateLabel.frame = CGRect(
            x: chechboxButton.right + Padding.ten,
            y: titleLabel.bottom,
            width: contentView.width - btnSize - Padding.twenty,
            height: 30
        )
        
    }
    

    func configure(with title: String, date: String) {
        titleLabel.text = title
        dateLabel.text = date
    }
    
}
