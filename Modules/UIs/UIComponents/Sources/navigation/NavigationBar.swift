//
//  NavigationBar.swift
//  Core
//
//  Created by Alexander Ivlev on 04/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

private enum Consts {
    static let statusBarHeight: CGFloat = 44.0

    static let defaultHeight: CGFloat = 44.0
    static let largeHeight: CGFloat = 96.0
    static let superLargeHeight: CGFloat = 150.0
}

public class NavigationStatusBar: UIView
{
    // TODO: private!
    public let navBar: NavigationBar = NavigationBar()

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Consts.statusBarHeight))

        self.backgroundColor = .red

        addSubview(navBar)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let newHeight = Consts.statusBarHeight + navBar.frame.height
        if abs(newHeight - frame.size.height) < 0.1 {
            return
        }

        frame.size.height = newHeight
        navBar.frame.origin.y = Consts.statusBarHeight
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class NavigationBar: UIView
{
    public enum ResizePolicy {
        case hide
        case `default`
        case large
        case auto // without hide
        case fullyAuto // with hide
    }
    public var resizePolicy: ResizePolicy = .default {
        didSet { update() }
    }

    public var preferredHeight: CGFloat = Consts.defaultHeight {
        didSet { update() }
    }

    private let leftView: UIView = UIView(frame: .zero)
    private let centerView: UIView = UIView(frame: .zero)
    private let rightView: UIView = UIView(frame: .zero)

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Consts.defaultHeight))

        self.translatesAutoresizingMaskIntoConstraints = false
        leftView.translatesAutoresizingMaskIntoConstraints = false
        centerView.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundColor = .cyan
        centerView.backgroundColor = .yellow

        addSubview(leftView)
        addSubview(rightView)
        addSubview(centerView)

        update(force: true)
    }

    // before call setup items width
    public func setLeftItems(_ items: [UIView]) {
        leftView.subviews.forEach { $0.removeFromSuperview() }

        var originX: CGFloat = 0.0
        for item in items {
            item.frame = CGRect(x: originX, y: 0.0, width: item.frame.width, height: Consts.defaultHeight)
            originX += item.frame.width
            leftView.addSubview(item)
        }

        leftView.frame = CGRect(x: 0.0, y: 0.0, width: originX, height: Consts.defaultHeight)

        update(force: true)
    }

    // before call setup items width
    public func setRightItems(_ items: [UIView]) {
        rightView.subviews.forEach { $0.removeFromSuperview() }

        var originX: CGFloat = 0.0
        for item in items.reversed() {
            item.frame = CGRect(x: originX, y: 0.0, width: item.frame.width, height: Consts.defaultHeight)
            originX += item.frame.width
            rightView.addSubview(item)
        }

        rightView.frame = CGRect(x: frame.width - originX, y: 0.0, width: originX, height: Consts.defaultHeight)

        update(force: true)
    }

    public func update(force: Bool = false) {
        let newHeight: CGFloat

        switch resizePolicy {
        case .hide:
            newHeight = 0.0
        case .default:
            newHeight = Consts.defaultHeight
        case .large:
            newHeight = Consts.largeHeight
        case .auto:
            newHeight = max(Consts.defaultHeight, preferredHeight)
        case .fullyAuto:
            newHeight = max(0.0, preferredHeight)
        }

        if !force && abs(newHeight - frame.size.height) < 0.1 {
            return
        }
        frame.size.height = newHeight

        let t: CGFloat
        if newHeight > Consts.defaultHeight {
            t = 1.0 + ((newHeight - Consts.defaultHeight) / (Consts.largeHeight - Consts.defaultHeight))
        } else {
            t = newHeight / Consts.defaultHeight
        }

        self.recalculateSubviews(for: t)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.update()
    }

    private func recalculateSubviews(for t: CGFloat) {
        let globalAlpha = min(t, 1.0)
        self.leftView.alpha = globalAlpha
        self.centerView.alpha = globalAlpha
        self.rightView.alpha = globalAlpha

        let y = max(0.0, min((t - 1.0) * Consts.defaultHeight, Consts.defaultHeight))
        let leftX = self.leftView.frame.origin.x + max(0.0, min(self.leftView.frame.width * (2.0 - t), self.leftView.frame.width))
        let rightX = self.rightView.frame.origin.x + max(0.0, min(self.rightView.frame.width * (t - 1.0), self.rightView.frame.width))
        self.centerView.frame = CGRect(x: leftX,
                                       y: y,
                                       width: rightX - leftX,
                                       height: self.frame.height - y)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
