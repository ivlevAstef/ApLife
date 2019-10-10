//
//  NavCenterLabelView.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 05/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public final class NavCenterLabelView: UIView, INavigationBarCenterView
{
    public var text: String {
        set { label.text = newValue }
        get { return label.text ?? "" }
    }

    public var textColor: UIColor {
        set { label.textColor = newValue }
        get { return label.textColor ?? .clear }
    }

    private let label = UILabel(frame: .zero)

    public init() {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        addSubview(label)
    }

    public func recalculateViews(for t: CGFloat) {
        label.font = UIFont.systemFont(ofSize: 8.0 + 10.0 * t)
        label.sizeToFit()

        label.frame.origin.x = 4.0
        label.frame.origin.y = frame.height - label.frame.height
        label.frame.size.width = frame.width
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
