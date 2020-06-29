//
//  AccountViewController.swift
//  VTB_HW5
//
//  Created by Anton Tolstov on 26.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

final class AccountViewController: UIViewController {
    
    private let headerView = UIView()
    private let tableViewManager = AccountTableViewManager()
    
    private(set) var person: Person
    
    // MARK: - Initializers
    
    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear
        
        constructHeaderView()
        constructTableView()
        constructBottomMunuView()
        
        // Example layout comparison
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "example-layout")
//        backgroundImage.contentMode = .scaleAspectFill
//        backgroundImage.alpha = 0.4
//        self.view.addSubview(backgroundImage)
    }
}



extension AccountViewController {
    
    // MARK: - Constants
    
    private enum ColorScheme {
        static let backgroundColor = UIColor(red: 0.929, green: 0.937, blue: 0.949, alpha: 1)
        static let borderColor = UIColor(red: 0.812, green: 0.808, blue: 0.824, alpha: 1)
        static let mailColor = UIColor(red: 0.646, green: 0.646, blue: 0.646, alpha: 1)
    }
    
    private enum Constant {
        static let headerHeight = CGFloat(109)
        static let bottomMenuHeight = CGFloat(57)
        static let accountImageSize = CGSize(width: 49, height: 49)
        static let largeFontSize = CGFloat(16)
        static let mailFontSize = CGFloat(10)
        static let iconNames = [Asset.bulletList, .checkList, .wallet, .person].map { $0.name }
        static let iconSizes = [(26, 19), (27, 27), (24, 24), (24, 24)].map {
            CGSize(width: $0, height: $1)
        }
    }
    
    private enum Asset: String, RawRepresentable {
        var name: String { "sprites-\(rawValue)" }
        
        case coins
        case wallet
        case arrow = "arrow-right"
        case bulletList = "list-bullet"
        case checkList = "list-check"
        case person = "person-circle"
    }
    
    // MARK: - View Construction
    
    private func constructHeaderView() {
        headerView.backgroundColor = .white
        view.addSubview(headerView, constraints: [
            equal(\.topAnchor, constant: 0),
            equal(\.leadingAnchor, constant: 0), equal(\.trailingAnchor, constant: 0),
            equal(\.heightAnchor, constant: Constant.headerHeight)
        ])
        
        constructAccountInfoView()
        constructCoinView()
    }
    
    private func constructAccountInfoView() {
        let accountInfo = UIStackView()
        accountInfo.spacing = 13.0
        accountInfo.alignment = .center
        
        let accountImageView = UIImageView(image: person.image)
        accountImageView.layer.cornerRadius = Constant.accountImageSize.width / 2
        accountImageView.layer.masksToBounds = true
        accountInfo.addArrangedSubview(accountImageView, constraints: [
            equal(\.widthAnchor, constant: Constant.accountImageSize.width),
            equal(\.heightAnchor, constant: Constant.accountImageSize.height)
        ])
        
        let nameLabel = UILabel()
        nameLabel.text = "\(person.firstName) \(person.lastName)"
        nameLabel.font = .boldSystemFont(ofSize: Constant.largeFontSize)
        
        let mailLabel = UILabel()
        mailLabel.text = person.mail
        mailLabel.font = .boldSystemFont(ofSize: Constant.mailFontSize)
        mailLabel.textColor = ColorScheme.mailColor
        
        let labels = UIStackView(arrangedSubviews: [nameLabel, mailLabel])
        labels.axis = .vertical
        labels.spacing = 0.0
        accountInfo.addArrangedSubview(labels)
        
        headerView.addSubview(accountInfo, constraints: [
            equal(\.topAnchor, constant: 47),
            equal(\.leadingAnchor, constant: 19),
        ])
    }
    
    private func constructCoinView() {
        let coinView = UIStackView()
        coinView.spacing = 2.6
        
        let coinLabel = UILabel()
        coinLabel.text = "\(person.money)"
        coinLabel.font = .boldSystemFont(ofSize: Constant.largeFontSize)
        coinView.addArrangedSubview(coinLabel)
        
        if let coinImage = UIImage(named: Asset.coins.name) {
            let coinImageView = UIImageView(image: coinImage)
            coinImageView.contentMode = .scaleAspectFill
            coinView.addArrangedSubview(coinImageView, constraints: [
                equal(\.widthAnchor, constant: 19),
                equal(\.heightAnchor, constant: 17)
            ])
        }
        
        headerView.addSubview(coinView, constraints: [
            equal(\.topAnchor, constant: 64),
            equal(\.trailingAnchor, constant: -36),
        ])
        
        if let arrowImage = UIImage(named: Asset.arrow.name) {
            let arrowView = UIImageView(image: arrowImage)
            arrowView.contentMode = .scaleAspectFill
            headerView.addSubview(arrowView, constraints: [
                equal(\.heightAnchor, constant: 13),
                equal(\.widthAnchor, constant: 7),
                equal(\.trailingAnchor, constant: -21),
                equal(\.topAnchor, constant: 67),
            ])
        }
    }
    
    private func constructTableView() {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        view.addSubview(tableView, constraints: [
            equal(\.topAnchor, constant: 109),
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.bottomAnchor)
        ])
        
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
        tableView.register(MenuCell.self, forCellReuseIdentifier: tableViewManager.cellID)
    }
    
    private func constructBottomMunuView() {
        let bottomMenuView = UIStackView()
        bottomMenuView.distribution = .equalSpacing
        bottomMenuView.alignment = .center

        zip(Constant.iconNames, Constant.iconSizes).forEach { iconName, iconSize in
            if let iconImage = UIImage(named: iconName) {
                let iconView = UIImageView(image: iconImage)
                bottomMenuView.addArrangedSubview(iconView, constraints: [
                    equal(\.widthAnchor, constant: iconSize.width),
                    equal(\.heightAnchor, constant: iconSize.height)
                ])
            }
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10
        backgroundView.addSubview(bottomMenuView, constraints: [
            equal(\.leadingAnchor, constant: 35),
            equal(\.trailingAnchor, constant: -36),
            equal(\.centerYAnchor)
            
        ])
        
        view.addSubview(backgroundView, constraints: [
            equal(\.leadingAnchor, constant: 33),
            equal(\.trailingAnchor, constant: -31),
            equal(\.bottomAnchor, constant: -34),
            equal(\.heightAnchor, constant: Constant.bottomMenuHeight)
        ])
    }
}
