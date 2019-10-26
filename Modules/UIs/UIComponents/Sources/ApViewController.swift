//
//  ApViewController.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 26/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Design

open class ApViewController: UIViewController {
    public var navStatusBar: INavigationBar! {
        return _navStatusBar
    }

    public private(set) lazy var style: Style = styleMaker.makeStyle(for: self)

    private let _navStatusBar: (UIView & INavigationBar)?
    private let styleMaker: StyleMaker = StyleMaker()

    public init(navStatusBar: (UIView & INavigationBar)?) {
        self._navStatusBar = navStatusBar
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func styleDidChange(_ style: Style) {
        _navStatusBar?.update(layout: style.layout.navLayout)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        if let navStatusBar = _navStatusBar {
            view.addSubview(navStatusBar)
            navStatusBar.frame = .zero
        }

        styleDidChange(style)
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if let navStatusBar = _navStatusBar {
            view.bringSubviewToFront(navStatusBar)
            if abs(navStatusBar.frame.width - view.bounds.width) > 0.1 {
                navStatusBar.frame.size.width = view.bounds.width

                navStatusBar.update(force: true)
            }
        }
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        style = styleMaker.makeStyle(for: self)
        styleDidChange(style)
    }

    open override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        style = styleMaker.makeStyle(for: self, traitCollection: newCollection)
        styleDidChange(style)
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        style = styleMaker.makeStyle(for: self, size: size)
        styleDidChange(style)
    }
}
