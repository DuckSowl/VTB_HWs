//
//  ConstraintHelpers.swift
//  VTB_HW5
//
//  Created by Anton Tolstov on 28.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

func equal<Axis, C: NSLayoutAnchor<Axis>>(_ to: KeyPath<UIView, C>,
                                            constant: CGFloat = 0) -> Constraint {
    return equal(to, to, constant: constant)
}

func equal<Axis, C: NSLayoutAnchor<Axis>>(_ from: KeyPath<UIView, C>,
                                          _ to: KeyPath<UIView, C>,
                                            constant: CGFloat = 0) -> Constraint {
    return { firstView, secondView in
        firstView[keyPath: from].constraint(equalTo: secondView[keyPath: to], constant: constant)
    }
}

func equal<C: NSLayoutDimension>(_ to: KeyPath<UIView, C>,
                                 constant: CGFloat = 0) -> Constraint {
    return { view, _ in
        view[keyPath: to].constraint(equalToConstant: constant)
    }
}

extension UIView {
    func addSubview(_ other: UIView, constraints: [Constraint]) {
        other.translatesAutoresizingMaskIntoConstraints = false
        addSubview(other)
        addConstraints(constraints.map { $0(other, self) })
    }
}

extension UIStackView {
    func addArrangedSubview(_ other: UIView, constraints: [Constraint]) {
        other.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(other)
        addConstraints(constraints.map { $0(other, self) })
    }
}
