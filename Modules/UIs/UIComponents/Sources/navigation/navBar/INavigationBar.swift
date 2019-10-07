//
//  INavigationBar.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 05/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public enum NavigationBarInitialDisplayMode {
    case hide
    case `default`
    case large
}

public enum NavigationBarDisplayMode {
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
    var initialDisplayMode: NavigationBarInitialDisplayMode { get set }
    var displayMode: NavigationBarDisplayMode { get set }
    /// preferred height - use this height for calculate real height taking display mode
    var preferredHeight: CGFloat { get set }

    /// min navigation bar height. Calculated use display mode
    var minHeight: CGFloat { get }
    /// max navigation bar height. Calculated use display mode
    var maxHeight: CGFloat { get }

    /// left items. Before set items setup his width.
    var leftItems: [UIView] { get set }
    /// right items. Before set items setup his width.
    var rightItems: [UIView] { get set }
    /// `true` if needs right items glue to bottom. it's Actually only with large display mode. Default - `false`
    var rightItemsGlueBottom: Bool { get set }

    /// additional views under navigation bar. Before set items setup his height.
    var accessoryItems: [UIView & INavigationBarResizableView] { get set }

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
