//
//  MenuCell.swift
//  VTB_HW5
//
//  Created by Anton Tolstov on 28.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

final class MenuCell: UITableViewCell {
    
    private let iconView = UIView()
    private let textView = UILabel()

    var menuItem: Menu? {
        didSet {
            if let menuItem = menuItem {
                textView.text = menuItem.title
                iconView.isHidden = !menuItem.hasIcon
                iconView.backgroundColor = menuItem.iconColor
            }
        }
    }
    
    private enum Constant {
        static let personSpriteName = "sprites-person"
        static let imageSize = CGSize(width: 27, height: 27)
        static let arrowSpriteName = "sprites-arrow-right"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageView?.image = UIImage()
        self.separatorInset = UIEdgeInsets(top: 0, left: 59, bottom: 0, right: 0)
        
        iconView.layer.cornerRadius = 5
        self.addSubview(iconView, constraints: [
            equal(\.widthAnchor, constant: Constant.imageSize.width),
            equal(\.heightAnchor, constant: Constant.imageSize.height),
            equal(\.leadingAnchor, constant: 14),
            equal(\.bottomAnchor, constant: -6)
        ])
        
        let image = UIImage(named: Constant.personSpriteName)
        let imageView = UIImageView(image: image)
        
        iconView.addSubview(imageView, constraints: [
            equal(\.widthAnchor, constant: 13.78),
            equal(\.heightAnchor, constant: 15.36),
            equal(\.centerYAnchor), equal(\.centerXAnchor)
        ])
        
        addSubview(textView, constraints: [
            equal(\.centerYAnchor),
            equal(\.leadingAnchor, constant: 57)
        ])
        
        textView.font = .systemFont(ofSize: 14)
                
        if let arrowImage = UIImage(named: Constant.arrowSpriteName) {
            let arrowView = UIImageView(image: arrowImage)
            arrowView.contentMode = .scaleAspectFill
            addSubview(arrowView, constraints: [
                equal(\.heightAnchor, constant: 13),
                equal(\.widthAnchor, constant: 7),
                equal(\.trailingAnchor, constant: -21),
                equal(\.centerYAnchor),
            ])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
