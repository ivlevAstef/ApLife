//
//  ApSectionTitleView.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 26/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Design
import Common

public class ApSectionTitleView: UIView
{
    public static let preferredHeight: CGFloat = 30.0
    
    private let titleLabel: UILabel = UILabel(frame: .zero)

    public init(text: String) {
        super.init(frame: .zero)

        commonInit(text: text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit(text: String) {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        titleLabel.text = text
    }
}

extension ApSectionTitleView: StylizingView
{
    public func apply(use style: Style) {
        backgroundColor = .clear

        titleLabel.font = style.fonts.title
        titleLabel.textColor = style.colors.mainText

        titleLabel.removeConstraints(titleLabel.constraints)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4.0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: style.layout.cellInnerInsets.left),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: style.layout.cellInnerInsets.right),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4.0),
        ])
    }
}
