//
//  TestNavItemView.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 08/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public final class TestNavItemView: UIView, INavigationBarItemView {
    public let width: CGFloat

    public init(width: CGFloat) {
        self.width = width

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
