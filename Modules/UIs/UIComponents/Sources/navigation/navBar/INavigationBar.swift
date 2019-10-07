//
//  INavigationBar.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 05/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public enum NavigationBarStartStyle {
    case hide
    case `default`
    case large
}

public enum NavigationBarResizePolicy {
    /// any time navigation bar is hide
    case hide
    /// any time navigation bar is default height
    case `default`
    /// any time navigation bar is large height
    case large
    /// can changed hide-default range
    case smallAuto
    /// can changed default-large range
    case largeAuto
    /// can changed hide-large range
    case fullyAuto
}


/// Don't change origin and size this view, but can modify subviews
public protocol INavigationBarResizableView {
    /// called if need recalculate subviews or properties
    /// - Parameter t: 0 == hide, default == 1, large == 2, more > 2
    func recalculateViews(for t: CGFloat)
}

public protocol INavigationBar: class {
    var startStyle: NavigationBarStartStyle { get set }
    var resizePolicy: NavigationBarResizePolicy { get set }
    var preferredHeight: CGFloat { get set }

    var minHeight: CGFloat { get }
    var maxHeight: CGFloat { get }

    /// before set leftItems setup items width
    var leftItems: [UIView] { get set }
    /// before set rightItems setup items width
    var rightItems: [UIView] { get set }
    var rightItemsGlueBottom: Bool { get set }

    var backgroundView: UIView? { get set }
    var centerContentView: (UIView & INavigationBarResizableView)? { get set }

    func calculatePreferredHeight(targetHeight: CGFloat) -> CGFloat

    func update(force: Bool)
}

extension INavigationBar {
    public func update() {
        update(force: false)
    }
}
