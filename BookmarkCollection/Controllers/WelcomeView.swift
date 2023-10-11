//
//  WelcomeView.swift
//  BookmarkCollection
//
//  Created by Erik on 04.10.2023.
//

import UIKit
import SnapKit

class WelcomeView: UIViewController {
    
    private lazy var startButton: CustomButton = {
        let button = CustomButton(label: "Let's Start Collecting", backgroundColor: .white, foregroundColor: .black)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        imageView.addSubview(tintView)
        tintView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Save all interesting
        links in one app
        """
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backgroundView)
        view.addSubview(startButton)
        backgroundView.addSubview(welcomeLabel)
    }
    
    private func makeConstraints() {
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width - 40)
            make.height.equalTo(50)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).offset(-20)
            make.leading.equalTo(startButton)
        }
    }
    
    @objc private func startButtonTapped() {
        let vc = MainView()
        navigationController?.pushViewController(vc, animated: true)
    }
}
