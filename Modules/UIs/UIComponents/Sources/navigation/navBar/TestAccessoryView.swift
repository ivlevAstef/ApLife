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

    public init(fullyHeight: CGFloat, canHidden: Bool) {
        self.fullyHeight = fullyHeight
        self.canHidden = canHidden

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func recalculateViews(for t: CGFloat) {
        
    }
}
