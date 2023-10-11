//
//  NewBookmarkActionSheet.swift
//  BookmarkCollection
//
//  Created by Erik on 05.10.2023.
//

import UIKit
import SnapKit

protocol NewBookmarkActionSheetDelegate: AnyObject {
    func bookmarkSaved()
}

class NewBookmarkActionSheet: UIViewController {
    private let linkManager = LinkManager.shared
    weak var delegate: NewBookmarkActionSheetDelegate?
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let titleTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Bookmark title")
        textField.autocapitalizationType = .sentences
        return textField
    }()
    
    private let linkLabel: UILabel = {
        let label = UILabel()
        label.text = "Link"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let linkTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Bookmark link (URL)")
        textField.autocapitalizationType = .none
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return textField
    }()
    
    private lazy var saveButton: CustomButton = {
        let button = CustomButton(label: "Save", backgroundColor: .black, foregroundColor: .white)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(dismissButton)
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(linkLabel)
        stackView.addArrangedSubview(linkTextField)
        view.addSubview(saveButton)
    }
    
    private func makeConstraints() {
        dismissButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width - 40)
            make.height.equalTo(40)
        }
        
        linkTextField.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width - 40)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width - 40)
            make.height.equalTo(view.frame.height / 5 - 10)
            make.centerX.equalToSuperview()
            make.top.equalTo(dismissButton.snp.bottom).offset(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width - 40)
            make.height.equalTo(50)
        }
    }
    
    @objc private func saveButtonTapped() {
        let linkTitle = titleTextField.text ?? ""
        let linkURL = linkTextField.text ?? ""
        let isURLValid = verifyUrl(urlString: linkURL)
        switch (linkURL, linkTitle, isURLValid) {
        case ("","", _):
            showAlert(title: "Empty Title And URL", message: "Your title and URL is Empty")
        case (_, "", _):
            showAlert(title: "Empty Title", message: "Your title is Empty")
        case ("", _, _):
            showAlert(title: "Empty URL", message: "Your URL is Empty")
        case (_, _, false):
            showAlert(title: "Invalid URL", message: "Your URL is not Valid")
        default:
            break
        }
        if titleTextField.text != "" && linkTextField.text != ""  && isURLValid {
            linkManager.addLink(title: linkTitle, url: linkURL)
            delegate?.bookmarkSaved()
            dismiss(animated: true)
        }
    }
    
    @objc private func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func handleKeyboardNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            if let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let bottomInset = view.frame.maxY - saveButton.frame.maxY
                let offset = keyboardSize.height - bottomInset
                if offset > 0 {
                    saveButton.transform = CGAffineTransform(translationX: 0, y: -offset)
                }
            }
        } else if notification.name == UIResponder.keyboardWillHideNotification {
            saveButton.transform = .identity
        }
    }

    
    func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
