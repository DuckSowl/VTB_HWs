//
//  ViewController.swift
//  VTB_HW6
//
//  Created by Anton Tolstov on 09.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    let user: User
    
    // MARK: - Initializers
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        setupLabel()
    }
    
    // MARK: - View Setup
    
    private func setupLabel() {
        let loginLabel = UILabel()
        loginLabel.text = Constant.welcomeText(forName: user.login)
        loginLabel.font = .systemFont(ofSize: Constant.fontSize)
        loginLabel.textAlignment = .center
        
        view.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Constant.sideAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -Constant.sideAnchor)
        ])
    }
    
    // MARK: - Constants
    
    private enum Constant {
        static func welcomeText(forName name: String) -> String { "Hello, \(name)!" }
        static let fontSize = CGFloat(40)
        static let sideAnchor = CGFloat(20)
    }
}

