//
//  AccountViewController.swift
//  VTB_HW5
//
//  Created by Anton Tolstov on 26.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    // Bad place to store constants. Looking for a better solution...
    private static let menuIconColor = UIColor(red: 0.384, green: 0.482, blue: 0.992, alpha: 1)
    private static let menuIconMyDataColor = UIColor(red: 0.349, green: 0.655, blue: 0.843, alpha: 1)
    private static let backgroundColor = UIColor(red: 0.929, green: 0.937, blue: 0.949, alpha: 1)
    private static let borderColor = UIColor(red: 0.812, green: 0.808, blue: 0.824, alpha: 1)
    private static let mailColor = UIColor(red: 0.646, green: 0.646, blue: 0.646, alpha: 1)
    
    private let menuItems = [Menu(title: "Мои данные", iconColor: menuIconMyDataColor),
                             Menu(title: "Связанные соц.сети", iconColor: menuIconColor),
                             Menu(title: "Уведомления", iconColor: menuIconColor),
                             Menu(title: "Языки", iconColor: menuIconColor)]
    
    private let contactMenuItems = [Menu(title: "Обратная связь", hasIcon: false),
                                    Menu(title: "Вопросы о Followme", hasIcon: false)]
    
    private let cellID = "cell"
    private let headerView = UIView()
    
    private(set) var person: Person
    
    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Example layout comparison
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "example-layout")
//        backgroundImage.contentMode = .scaleAspectFill
//        backgroundImage.alpha = 0.4
//        self.view.addSubview(backgroundImage)
    }
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear
        
        constructHeaderView()
        constructTableView()
        constructBottomMunuView()
    }
    
    private func constructHeaderView() {
        headerView.backgroundColor = .white
        view.addSubview(headerView, constraints: [
            equal(\.topAnchor, constant: 0),
            equal(\.leadingAnchor, constant: 0), equal(\.trailingAnchor, constant: 0),
            equal(\.heightAnchor, constant: 109)
        ])
        
        constructAccountInfoView()
        constructCoinView()
    }
    
    private func constructAccountInfoView() {
        let accountInfo = UIStackView()
        accountInfo.spacing = 13.0
        accountInfo.alignment = .center

        let accountImageView = UIImageView(image: person.image)
        accountImageView.layer.cornerRadius = 49.0 / 2
        accountImageView.layer.masksToBounds = true
        accountInfo.addArrangedSubview(accountImageView, constraints: [
            equal(\.widthAnchor, constant: 49),
            equal(\.heightAnchor, constant: 49)
        ])

        let nameLabel = UILabel()
        nameLabel.text = "\(person.firstName) \(person.lastName)"
        nameLabel.font = .boldSystemFont(ofSize: 16)

        let mailLabel = UILabel()
        mailLabel.text = person.mail
        mailLabel.font = .boldSystemFont(ofSize: 10)
        mailLabel.textColor = Self.mailColor

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
        coinLabel.font = .boldSystemFont(ofSize: 16)
        coinView.addArrangedSubview(coinLabel)

        if let coinImage = UIImage(named: "sprites-coins") {
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
        
        if let arrowImage = UIImage(named: "sprites-arrow-right") {
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

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuCell.self, forCellReuseIdentifier: cellID)
    }
    
    private func constructBottomMunuView() {
        let bottomMenuView = UIStackView()
        bottomMenuView.distribution = .equalSpacing
        bottomMenuView.alignment = .center
        
        let iconNames = ["list-bullet", "list-check", "wallet",  "person-circle"]
        let iconSizes = [(26, 19), (27, 27), (24, 24), (24, 24)].map {
            CGSize(width: $0, height: $1)
        }
        
        zip(iconNames, iconSizes).forEach { iconName, size in
            if let iconImage = UIImage(named: "sprites-\(iconName)") {
                let iconView = UIImageView(image: iconImage)
                bottomMenuView.addArrangedSubview(iconView, constraints: [
                    equal(\.widthAnchor, constant: size.width),
                    equal(\.heightAnchor, constant: size.height)
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
            equal(\.heightAnchor, constant: 57)
        ])
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.headerView(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.footerView(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return (0...1).contains(heightForRowAt.row) ? 44 : 42
    }
}

extension AccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? menuItems.count : contactMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? MenuCell
        
        let row = indexPath.row
        let menuItem = indexPath.section == 0 ? menuItems[row]: contactMenuItems[row]
        cell?.menuItem = menuItem
        
        return cell!
    }
}
