//
//  CustomButton.swift
//  BookmarkCollection
//
//  Created by Erik on 04.10.2023.
//

import UIKit
import SnapKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(label: String, backgroundColor: UIColor, foregroundColor: UIColor) {
        super.init(frame: .zero)
        configuration = .filled()
        configuration?.title = label
        configuration?.baseBackgroundColor = backgroundColor
        configuration?.baseForegroundColor = foregroundColor
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        let attributedTitle = NSAttributedString(string: label, attributes: titleAttributes)
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = frame.height / 3
    }
}
