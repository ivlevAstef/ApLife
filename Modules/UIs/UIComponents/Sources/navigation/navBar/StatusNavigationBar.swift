//
//  StatusNavigationBar.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 05/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

private enum Consts {
    // TODO: changed if change rotation, and device model
    static let statusBarHeight: CGFloat = 44.0
}

public class StatusNavigationBar: UIView, INavigationBar
{
    public var resizePolicy: NavigationBarResizePolicy {
        set { navBar.resizePolicy = newValue; update() }
        get { return navBar.resizePolicy }
    }
    public var preferredHeight: CGFloat {
        set { navBar.preferredHeight = newValue - Consts.statusBarHeight; update() }
        get { return navBar.preferredHeight }
    }

    public var minHeight: CGFloat { return navBar.minHeight + Consts.statusBarHeight }
    public var maxHeight: CGFloat { return navBar.maxHeight + Consts.statusBarHeight }
    public var minAutoHeight: CGFloat { return navBar.minAutoHeight + Consts.statusBarHeight }

    public var leftItems: [UIView] {
        set { navBar.leftItems = newValue; update() }
        get { return navBar.leftItems }
    }
    public var rightItems: [UIView] {
       set { navBar.rightItems = newValue; update() }
       get { return navBar.rightItems }
   }

    public var backgroundView: UIView? {
        didSet { updateBackgroundView(prev: oldValue) }
    }

    public var centerContentView: (UIView & INavigationBarResizableView)? {
        set { navBar.centerContentView = newValue; update() }
        get { return navBar.centerContentView }
    }

    private let navBar: NavigationBar = NavigationBar()

    public init() {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        // I have self background view
        navBar.backgroundView = nil
        addSubview(navBar)

        update(force: true)
    }

    public func update(force: Bool) {
        // for improve configure speed - not need update = not need time
        if abs(frame.size.width) <= 1.0e-3 {
            return
        }

        navBar.frame.origin = CGPoint(x: 0.0, y: Consts.statusBarHeight)
        navBar.frame.size.width = frame.size.width

        navBar.update(force: force)

        let newHeight = Consts.statusBarHeight + navBar.frame.height
        if abs(newHeight - frame.size.height) < 0.1 {
            return
        }

        frame.size.height = newHeight
        backgroundView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: newHeight)

        setNeedsLayout()
    }

    private func updateBackgroundView(prev prevBackgroundView: UIView?) {
        if prevBackgroundView === backgroundView {
            return
        }

        prevBackgroundView?.removeFromSuperview()

        if let backgroundView = backgroundView {
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            insertSubview(backgroundView, at: 0)
        }

        update(force: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
