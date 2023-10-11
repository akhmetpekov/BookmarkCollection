//
//  MainView.swift
//  BookmarkCollection
//
//  Created by Erik on 04.10.2023.
//

import UIKit
import SnapKit

class MainView: UIViewController, NewBookmarkActionSheetDelegate {
    
    private var linkManager = LinkManager.shared
    
    private lazy var addBookmarkButton: CustomButton = {
        let button = CustomButton(label: "Add bookmark", backgroundColor: .black, foregroundColor: .white)
        button.addTarget(self, action: #selector(addBookmarkTapped), for: .touchUpInside)
        return button
    }()
    
    private let firstBookmarkLabel: UILabel = {
        let label = UILabel()
        label.text = "Save your first\nbookmark"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        observeBookmarkChanges()
        updateView()
    }
    
    private func updateView() {
        if linkManager.getLinks().isEmpty {
            setupUI()
            makeConstraints()
        } else {
            setupSecondUI()
            makeSecondConstraints()
        }
    }

    
    private func setupSecondUI() {
        title = "List"
        view.backgroundColor = .white
        view.addSubview(addBookmarkButton)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func makeSecondConstraints() {
        addBookmarkButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width - 40)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(addBookmarkButton.snp.top).offset(-20)
        }
    }
    
    private func setupUI() {
        title = "Bookmark App"
        view.backgroundColor = .white
        view.addSubview(addBookmarkButton)
        view.addSubview(firstBookmarkLabel)
    }
    
    private func makeConstraints() {
        addBookmarkButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width - 40)
            make.height.equalTo(50)
        }
        
        firstBookmarkLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func observeBookmarkChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleBookmark), name: NSNotification.Name("NewBookmarkAdded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleBookmark), name: NSNotification.Name("BookmarkDeleted"), object: nil)
    }
    
    @objc private func addBookmarkTapped() {
        let vc = NewBookmarkActionSheet()
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(vc, animated: true) {
            self.updateView()
        }
    }
    
    @objc private func handleBookmark() {
        updateView()
    }

    
    func bookmarkSaved() {
        if !linkManager.getLinks().isEmpty {
            updateView()
        }
        tableView.reloadData()
    }
    
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linkManager.getLinks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { fatalError() }
        let links = linkManager.getLinks()
        cell.configureCell(title: links[indexPath.row].title!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let links = linkManager.getLinks()
        let linkURL = links[indexPath.row].url!
        if let url = URL(string: linkURL) {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            linkManager.deleteLink(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateView()
        }
    }
}
