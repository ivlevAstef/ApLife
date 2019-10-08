//
//  NavigationBar.swift
//  Core
//
//  Created by Alexander Ivlev on 04/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Common

private enum Consts {
    // TODO: changed if change rotation
    static let defaultHeight: CGFloat = 44.0
    static let largeHeight: CGFloat = 96.0

    static let extraLargeHeightRelativeToScreenHeight: CGFloat = 0.4
}


public class NavigationBar: UIView, INavigationBar
{
    public var initialDisplayMode: NavigationBarInitialDisplayMode = .default {
        didSet { update() }
    }
    public var displayMode: NavigationBarDisplayMode = .default {
        didSet { updateHeightAnchorsAndInfinityMode(); update(force: true) }
    }

    public var preferredHeight: CGFloat {
        set { _preferredHeight = newValue; update() }
        get { return _preferredHeight }
    }

    public var minHeight: CGFloat { return getMinHeightInNormalRange() }
    public var maxHeight: CGFloat { return getMaxHeightInNormalRange() }

    public var leftItems: [UIView & INavigationBarItemView] = [] {
        didSet { configureLeftItems() }
    }
    public var rightItems: [UIView & INavigationBarItemView] = [] {
        didSet { configureRightItems() }
    }
    public var rightItemsGlueBottom: Bool = false

    public var accessoryItems: [UIView & INavigationBarAccessoryView] = [] {
        didSet { updateHeightAnchorsAndInfinityMode(); configureAccessoryItems(oldItems: oldValue) }
    }

    public var backgroundView: UIView? {
        didSet { updateBackgroundView(prev: oldValue) }
    }
    public var centerContentView: (UIView & INavigationBarCenterView)? {
        didSet { updateCenterContentView(prev: oldValue) }
    }

    private var isFullyInitialized: Bool = false
    private var _preferredHeight: CGFloat = 0.0 // need for change value without call update - else recursive call

    /// height values for attachments height to it
    private var heightAnchors: [CGFloat] = []
    private var infinityMode: Bool = true

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

        updateHeightAnchorsAndInfinityMode()
    }

    public func update(force: Bool) {
        // for improve configure speed - not need update = not need time
        if abs(frame.size.width) <= 1.0e-3 {
            return
        }

        initializePreferredHeightIfNeeded()
        updateHeightAnchorsAndInfinityMode()
        let newHeight = calculateHeightInNormalRange(for: preferredHeight)

        if !force && abs(newHeight - frame.size.height) < 0.1 {
            return
        }
        frame.size.height = newHeight

        recalculateSubviews()

        setNeedsLayout()

        isFullyInitialized = true
    }

    public func calculatePreferredHeight(targetHeight: CGFloat) -> CGFloat {
        log.assert(!heightAnchors.isEmpty, "height anchors empty - WTF? need check logic")
        let preferredHeight = heightAnchors.min(by: { abs(targetHeight - $0) < abs(targetHeight - $1) })
        return preferredHeight ?? 0
    }

    // MARK: - configure any views

    private func configureLeftItems() {
        leftView.subviews.forEach { $0.removeFromSuperview() }
        for item in leftItems {
            leftView.addSubview(item)
        }

        update(force: true)
    }

    private func configureRightItems() {
        rightView.subviews.forEach { $0.removeFromSuperview() }
        for item in rightItems.reversed() {
            rightView.addSubview(item)
        }

        update(force: true)
    }

    private func configureAccessoryItems(oldItems: [UIView]) {
        oldItems.forEach { $0.removeFromSuperview() }
        for accessoryItem in accessoryItems {
            addSubview(accessoryItem)
        }

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

    // MARK: - recalculate frames and childs

    private func recalculateSubviews() {
        let t = calculateGlobalT(for: frame.height)

        let globalAlpha = min(t, 1.0)
        leftView.alpha = globalAlpha
        centerView.alpha = globalAlpha
        rightView.alpha = globalAlpha

        recalculateAccessoryViews()
        recalculateLeftViews(for: t)
        recalculateRightViews(for: t)
        recalculateCenterContentView(for: t)

        backgroundView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }

    private func recalculateAccessoryViews() {
        let canNotHiddenAccessoryItems = accessoryItems.filter { !$0.canHidden }
        let canHiddenAccessoryItems = accessoryItems.filter { $0.canHidden }

        // originX needs only for correct calculate all accessory heights
        var originX: CGFloat = 0.0
        let lastNotAccessoryAnchorIndex = heightAnchors.count - accessoryItems.count - 1
        if lastNotAccessoryAnchorIndex > 0 {
            originX = heightAnchors[lastNotAccessoryAnchorIndex]
        } else {
            log.assert("Height anchors is too small...")
        }

        let sortedAccessoryViews = canNotHiddenAccessoryItems + canHiddenAccessoryItems
        for accessoryView in sortedAccessoryViews {
            let height = accessoryView.fullyHeight
            let normalHeight = max(0.0, min(frame.height - originX, height))
            let t = accessoryView.canHidden ? (normalHeight / height) : 1.0

            accessoryView.isHidden = (t == 0.0)
            accessoryView.frame = CGRect(x: 0, y: originX, width: frame.width, height: t * height)
            accessoryView.recalculateViews(for: t)

            originX += height
        }

        // move accessories to bottom
        originX = frame.height
        for accessoryView in sortedAccessoryViews.reversed() {
            originX -= accessoryView.frame.height
            accessoryView.frame.origin.y = originX
        }
    }

    private func recalculateLeftViews(for t: CGFloat) {
        var originX: CGFloat = 0.0
        for item in leftItems {
            item.frame = CGRect(x: originX, y: 0.0, width: item.width, height: Consts.defaultHeight)
            originX += item.width
        }

        let y = (min(t, 1.0) - 1.0) * Consts.defaultHeight
        leftView.frame = CGRect(x: 0.0, y: y, width: originX, height: Consts.defaultHeight)
    }

    private func recalculateRightViews(for t: CGFloat) {
        var originX: CGFloat = 0.0
        for item in rightItems.reversed() {
            item.frame = CGRect(x: originX, y: 0.0, width: item.width, height: Consts.defaultHeight)
            originX += item.width
        }

        let y: CGFloat
        if rightItemsGlueBottom {
            let accessoriesHeight = calculateCurrentAccessoriesHeight()
            y = (frame.height - accessoriesHeight) - Consts.defaultHeight
        } else {
            y = (min(t, 1.0) - 1.0) * Consts.defaultHeight
        }

        rightView.frame = CGRect(x: frame.width - originX, y: y, width: originX, height: Consts.defaultHeight)
    }

    private func recalculateCenterContentView(for t: CGFloat) {
        guard let centerContentView = centerContentView else {
            return
        }

        let y = max(0.0, min((t - 1.0) * Consts.defaultHeight, Consts.defaultHeight))
        let leftX = leftView.frame.origin.x + max(0.0, min(leftView.frame.width * (2.0 - t), leftView.frame.width))
        let rightX = rightView.frame.origin.x + max(0.0, min(rightView.frame.width * (t - 1.0), rightView.frame.width))
        let accessoryHeight = calculateCurrentAccessoriesHeight()
        centerView.frame = CGRect(x: leftX,
                                  y: y,
                                  width: rightX - leftX,
                                  height: frame.height - accessoryHeight - y)

        centerContentView.frame = CGRect(x: 0, y: 0, width: centerView.frame.width, height: centerView.frame.height)
        centerContentView.recalculateViews(for: t)
    }

    // MARK: - math

    private func initializePreferredHeightIfNeeded() {
        if isFullyInitialized {
            return
        }

        let minAccessoriesHeight = calculateMinAccessoriesHeight()

        switch initialDisplayMode {
        case .hide:
            _preferredHeight = minAccessoriesHeight
        case .default:
            _preferredHeight = minAccessoriesHeight + Consts.defaultHeight
        case .large:
            _preferredHeight = minAccessoriesHeight + Consts.largeHeight
        }
    }

    private func updateHeightAnchorsAndInfinityMode() {
        heightAnchors = []

        switch displayMode {
        case .hide:
            heightAnchors = [0.0]
            infinityMode = false
        case .default:
            heightAnchors = [Consts.defaultHeight]
            infinityMode = false
        case .large:
            heightAnchors = [Consts.largeHeight]
            infinityMode = false
        case .smallAuto:
            heightAnchors = [0.0, Consts.defaultHeight]
            infinityMode = false
        case .largeAuto:
            heightAnchors = [Consts.defaultHeight, Consts.largeHeight]
            infinityMode = true
        case .fullyAuto:
            heightAnchors = [0.0, Consts.defaultHeight, Consts.largeHeight]
            infinityMode = true
        }

        let minAccessoriesHeight = calculateMinAccessoriesHeight()
        heightAnchors = heightAnchors.map { $0 + minAccessoriesHeight }

        var height = heightAnchors.last!
        for accessoryItem in accessoryItems.filter({ $0.canHidden }) {
            height += accessoryItem.fullyHeight
            heightAnchors.append(height)
        }
    }

    private func getMinHeightInNormalRange() -> CGFloat {
        log.assert(!heightAnchors.isEmpty, "height anchors empty - WTF? need check logic")
        return heightAnchors.first ?? 0.0
    }

    private func getMaxHeightInNormalRange() -> CGFloat {
        log.assert(!heightAnchors.isEmpty, "height anchors empty - WTF? need check logic")

        return heightAnchors.last ?? 0.0
    }

    private func calculateHeightInNormalRange(for height: CGFloat) -> CGFloat {
        log.assert(!heightAnchors.isEmpty, "height anchors empty - WTF? need check logic")
        if infinityMode {
            return max(minHeight, height)
        }
        return max(minHeight, min(height, maxHeight))
    }

    private func calculateMinAccessoriesHeight() -> CGFloat {
        var minAccessoriesHeight: CGFloat = 0.0
        for accessoryItem in accessoryItems {
            minAccessoriesHeight += accessoryItem.canHidden ? 0.0 : accessoryItem.fullyHeight
        }
        return minAccessoriesHeight
    }

    private func calculateCurrentAccessoriesHeight() -> CGFloat {
        return accessoryItems.map { $0.frame.height }.reduce(0, +)
    }

    private func calculateGlobalT(for height: CGFloat) -> CGFloat {
        let height = height - calculateMinAccessoriesHeight()
        let extraHeight = Consts.extraLargeHeightRelativeToScreenHeight * UIScreen.main.bounds.height
        let t: CGFloat
        if height > Consts.largeHeight {
            let denominator = Consts.largeHeight + extraHeight
            t = min(3.0, 2.0 + ((height - Consts.largeHeight) / denominator))
        } else if height > Consts.defaultHeight {
            t = 1.0 + ((height - Consts.defaultHeight) / (Consts.largeHeight - Consts.defaultHeight))
        } else {
            t = height / Consts.defaultHeight
        }
        return t
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
