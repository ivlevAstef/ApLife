//
//  NavigationBar.swift
//  Core
//
//  Created by Alexander Ivlev on 04/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

private enum Consts {
    // TODO: changed if change rotation
    static let defaultHeight: CGFloat = 44.0
    static let largeHeight: CGFloat = 96.0
    static let superLargeHeight: CGFloat = 150.0

    static let velocityHeightFactor: CGFloat = 250.0 // 250 miliseconds
}


public class NavigationBar: UIView, INavigationBar
{
    public var startStyle: NavigationBarStartStyle = .default {
        didSet { update() }
    }
    public var resizePolicy: NavigationBarResizePolicy = .default {
        didSet { update(force: true) }
    }

    public var preferredHeight: CGFloat {
        set { _preferredHeight = newValue; update() }
        get { return _preferredHeight }
    }

    public var minHeight: CGFloat { return calculateHeightTakingInResizePolicy(for: 0.0) }
    public var maxHeight: CGFloat { return calculateHeightTakingInResizePolicy(for: UIScreen.main.bounds.height) }

    public var leftItems: [UIView] = [] {
        didSet { configureLeftItems() }
    }
    public var rightItems: [UIView] = [] {
        didSet { configureRightItems() }
    }
    public var rightItemsGlueBottom: Bool = false

    public var backgroundView: UIView? {
        didSet { updateBackgroundView(prev: oldValue) }
    }
    public var centerContentView: (UIView & INavigationBarResizableView)? {
        didSet { updateCenterContentView(prev: oldValue) }
    }

    private var isFullyInitialized: Bool = false
    private var _preferredHeight: CGFloat = 0.0 // need for change value without call update - else recursive call

    private let leftView: UIView = UIView(frame: .zero)
    private let centerView: UIView = UIView(frame: .zero)
    private let rightView: UIView = UIView(frame: .zero)

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: -1.0/*for first update without force*/))

        translatesAutoresizingMaskIntoConstraints = false
        leftView.translatesAutoresizingMaskIntoConstraints = false
        centerView.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .clear
        leftView.backgroundColor = .clear
        centerView.backgroundColor = .clear
        rightView.backgroundColor = .clear

        addSubview(leftView)
        addSubview(rightView)
        addSubview(centerView)
    }

    public func update(force: Bool) {
        // for improve configure speed - not need update = not need time
        if abs(frame.size.width) <= 1.0e-3 {
            return
        }

        initializePreferredHeightIfNeeded()
        let newHeight = calculateHeightTakingInResizePolicy(for: preferredHeight)

        if !force && abs(newHeight - frame.size.height) < 0.1 {
            return
        }
        frame.size.height = newHeight

        let t: CGFloat
        if newHeight > Consts.largeHeight {
            t = 2.0 + ((newHeight - Consts.largeHeight) / (UIScreen.main.bounds.height - Consts.largeHeight))
        } else if newHeight > Consts.defaultHeight {
            t = 1.0 + ((newHeight - Consts.defaultHeight) / (Consts.largeHeight - Consts.defaultHeight))
        } else {
            t = newHeight / Consts.defaultHeight
        }

        recalculateSubviews(for: t)

        setNeedsLayout()

        isFullyInitialized = true
    }

    private func initializePreferredHeightIfNeeded() {
        if isFullyInitialized {
            return
        }

        switch startStyle {
        case .hide:
            _preferredHeight = 0.0
        case .default:
            _preferredHeight = Consts.defaultHeight
        case .large:
            _preferredHeight = Consts.largeHeight
        }
    }

    private func configureLeftItems() {
        leftView.subviews.forEach { $0.removeFromSuperview() }

        var originX: CGFloat = 0.0
        for item in leftItems {
            item.frame = CGRect(x: originX, y: 0.0, width: item.frame.width, height: Consts.defaultHeight)
            originX += item.frame.width
            leftView.addSubview(item)
        }

        leftView.frame = CGRect(x: 0.0, y: 0.0, width: originX, height: Consts.defaultHeight)

        update(force: true)
    }

    private func configureRightItems() {
        rightView.subviews.forEach { $0.removeFromSuperview() }

        var originX: CGFloat = 0.0
        for item in rightItems.reversed() {
            item.frame = CGRect(x: originX, y: 0.0, width: item.frame.width, height: Consts.defaultHeight)
            originX += item.frame.width
            rightView.addSubview(item)
        }

        rightView.frame = CGRect(x: frame.width - originX, y: 0.0, width: originX, height: Consts.defaultHeight)

        update(force: true)
    }

    private func updateBackgroundView(prev prevBackgroundView: UIView?) {
        if prevBackgroundView === backgroundView {
            return
        }

        prevBackgroundView?.removeFromSuperview()

        if let backgroundView = backgroundView {
            addSubview(backgroundView)
        }

        update(force: true)
    }

    private func updateCenterContentView(prev prevCenterContentView: UIView?) {
        if prevCenterContentView === centerContentView {
            return
        }

        prevCenterContentView?.removeFromSuperview()

        if let centerContentView = centerContentView {
            centerView.addSubview(centerContentView)
        }

        update(force: true)
    }

    private func calculateHeightTakingInResizePolicy(for height: CGFloat) -> CGFloat {
        switch resizePolicy {
        case .hide:
            return 0.0
        case .default:
            return Consts.defaultHeight
        case .large:
            return Consts.largeHeight
        case .smallAuto:
            return max(0.0, min(height, Consts.defaultHeight))
        case .largeAuto:
            return max(Consts.defaultHeight, height)
        case .fullyAuto:
            return max(0.0, height)
        }
    }

    public func calculatePreferredHeight(velocity: CGFloat) -> CGFloat {
        let finalHeight = velocity * Consts.velocityHeightFactor + preferredHeight
        let normalHeight = calculateHeightTakingInResizePolicy(for: finalHeight)

        switch resizePolicy {
        case .hide:
            return 0.0
        case .default:
            return Consts.defaultHeight
        case .large:
            return Consts.largeHeight
        case .smallAuto:
            if normalHeight < Consts.defaultHeight - normalHeight {
                return 0.0
            }
            return Consts.defaultHeight
        case .largeAuto:
            if normalHeight - Consts.defaultHeight < (Consts.largeHeight - Consts.defaultHeight) * 0.5 {
                return Consts.defaultHeight
            }
            return Consts.largeHeight
        case .fullyAuto:
            if normalHeight < Consts.defaultHeight - normalHeight {
                return 0.0
            }
            if normalHeight - Consts.defaultHeight < (Consts.largeHeight - Consts.defaultHeight) * 0.5 {
                return Consts.defaultHeight
            }
            return Consts.largeHeight
        }
    }

    private func recalculateSubviews(for t: CGFloat) {
        leftView.frame.origin = .zero
        rightView.frame.origin = CGPoint(x: frame.width - rightView.frame.width, y: 0.0)

        let globalAlpha = min(t, 1.0)
        leftView.alpha = globalAlpha
        centerView.alpha = globalAlpha
        rightView.alpha = globalAlpha

        leftView.frame.origin.y = (min(t, 1.0) - 1.0) * Consts.defaultHeight
        if rightItemsGlueBottom {
            rightView.frame.origin.y = frame.height - rightView.frame.height
        } else {
            rightView.frame.origin.y = (min(t, 1.0) - 1.0) * Consts.defaultHeight
        }

        let y = max(0.0, min((t - 1.0) * Consts.defaultHeight, Consts.defaultHeight))
        let leftX = leftView.frame.origin.x + max(0.0, min(leftView.frame.width * (2.0 - t), leftView.frame.width))
        let rightX = rightView.frame.origin.x + max(0.0, min(rightView.frame.width * (t - 1.0), rightView.frame.width))
        centerView.frame = CGRect(x: leftX,
                                  y: y,
                                  width: rightX - leftX,
                                  height: frame.height - y)

        backgroundView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

        centerContentView?.frame = CGRect(x: 0, y: 0, width: centerView.frame.width, height: centerView.frame.height)
        centerContentView?.recalculateViews(for: t)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
