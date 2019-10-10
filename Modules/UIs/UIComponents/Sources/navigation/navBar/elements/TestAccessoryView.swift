//
//  TestAccessoryView.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 08/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public final class TestAccessoryView: UIView, INavigationBarAccessoryView {
    public let fullyHeight: CGFloat
    public let canHidden: Bool

    private let subview: UIView = UIView(frame: .zero)

    public init(fullyHeight: CGFloat, canHidden: Bool) {
        self.fullyHeight = fullyHeight
        self.canHidden = canHidden

        super.init(frame: .zero)

        subview.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        subview.layer.cornerRadius = 12.0
        addSubview(subview)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func recalculateViews(for t: CGFloat) {
        subview.frame = CGRect(x: 12, y: 6, width: bounds.width - 24, height: bounds.height - 12)
    }
}
