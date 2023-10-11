//
//  CustomCell.swift
//  BookmarkCollection
//
//  Created by Erik on 10.10.2023.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    static let identifier = "CustomCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        return separator
    }()
    
    private let linkIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "link")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        return icon
    }()
    
    public func configureCell(title: String) {
        nameLabel.text = title
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
//        contentView.addSubview(separator)
        contentView.addSubview(linkIcon)
    }
    
    private func makeConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
//        separator.snp.makeConstraints { make in
//            make.bottom.equalToSuperview()
//            make.width.equalTo(contentView.frame.width)
//            make.leading.equalToSuperview().offset(10)
//            make.height.equalTo(1)
//        }
        
        linkIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

}
