//
//  AccountTableViewManager.swift
//  VTB_HW5
//
//  Created by Anton Tolstov on 29.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

final class AccountTableViewManager: NSObject {
    let cellID = "AccountCell"
    
    private enum ColorScheme {
        static let menuIconColor = UIColor(red: 0.384, green: 0.482, blue: 0.992, alpha: 1)
        static let menuIconMyDataColor = UIColor(red: 0.349, green: 0.655, blue: 0.843, alpha: 1)
    }
    
    private enum Constant {
        static let heightForHeaderInSection = CGFloat(15.5)
        static let heightForFooterInSection = CGFloat(24)
    }
    
    private let menuItems = [Menu(title: "Мои данные", iconColor: ColorScheme.menuIconMyDataColor),
                             Menu(title: "Связанные соц.сети", iconColor: ColorScheme.menuIconColor),
                             Menu(title: "Уведомления", iconColor: ColorScheme.menuIconColor),
                             Menu(title: "Языки", iconColor: ColorScheme.menuIconColor)]
    
    private let contactMenuItems = [Menu(title: "Обратная связь", hasIcon: false),
                                    Menu(title: "Вопросы о Followme", hasIcon: false)]
}

// MARK: - UITableViewDelegate

extension AccountTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.headerView(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.heightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.footerView(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constant.heightForFooterInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        // Weird calculations because of the design
        return (0...1).contains(heightForRowAt.row) ? 44 : 42
    }
}

// MARK: - UITableViewDataSource

extension AccountTableViewManager: UITableViewDataSource {
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
