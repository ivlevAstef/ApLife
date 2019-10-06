//
//  ScrollNavigationBarController.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 05/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public final class ScrollNavigationBarController: NSObject, UIScrollViewDelegate {

    private weak var scrollView: UIScrollView?
    private weak var navBar: INavigationBar?

    public init(scrollView: UIScrollView, navBar: INavigationBar) {
        self.scrollView = scrollView
        self.navBar = navBar

        super.init()

        scrollView.bounces = true
        scrollView.delegate = self
    }

    public func update() {
        if let scrollView = scrollView {
            setContentInsets(scrollView: scrollView, changeContentOffset: true, animated: false)
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navBar = navBar else {
            return
        }

        navBar.preferredHeight = -scrollView.contentOffset.y

        if -scrollView.contentOffset.y > navBar.minHeight {
            scrollView.verticalScrollIndicatorInsets.top = -scrollView.contentOffset.y - scrollView.safeAreaInsets.top
        }
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // TODO: need remove by begin touch - not dragging :(
        scrollView.layer.removeAllAnimations()
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        setContentInsets(velocity: -velocity.y, scrollView: scrollView, changeContentOffset: abs(velocity.y) < 1.0e-3)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setContentInsets(scrollView: scrollView, changeContentOffset: true)
    }

    private func setContentInsets(velocity: CGFloat = 0.0,
                                  scrollView: UIScrollView,
                                  changeContentOffset: Bool,
                                  animated: Bool = true) {
        guard let navBar = navBar else {
            return
        }

        let height = navBar.calculatePreferredHeight(velocity: velocity)

        let inset = height - scrollView.safeAreaInsets.top
        if scrollView.contentInset.top != inset {
            scrollView.contentInset.top = inset
        }
        if scrollView.verticalScrollIndicatorInsets.top != inset {
            scrollView.verticalScrollIndicatorInsets.top = inset
        }

        if scrollView.contentOffset.y <= -navBar.minHeight && changeContentOffset {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: -height), animated: animated)
        }
    }
}
