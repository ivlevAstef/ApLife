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
            setStartedContentInsets(scrollView: scrollView)
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
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let navBar = navBar else {
            return
        }

        let distance = calculateMoveDistance(velocity: velocity.y, decelerationRate: scrollView.decelerationRate.rawValue)

        let targetHeight = -scrollView.contentOffset.y - distance
        setContentInsets(scrollView: scrollView, targetHeight: targetHeight - scrollView.safeAreaInsets.top)

        if navBar.minHeight <= targetHeight && targetHeight <= navBar.maxHeight {
            let height = scrollView.contentInset.top + scrollView.safeAreaInsets.top
            targetContentOffset.pointee = CGPoint(x: 0.0, y: -height)
        }
    }

    private func calculateMoveDistance(velocity: CGFloat, decelerationRate: CGFloat) -> CGFloat {
        return velocity * decelerationRate / (1.0 - decelerationRate)
    }

    private func setStartedContentInsets(scrollView: UIScrollView) {
        guard let navBar = navBar else {
            return
        }

        setContentInsets(scrollView: scrollView, targetHeight: navBar.preferredHeight)
        let height = scrollView.contentInset.top + scrollView.safeAreaInsets.top
        scrollView.setContentOffset(CGPoint(x: 0, y: -height), animated: false)
    }

    private func setContentInsets(scrollView: UIScrollView, targetHeight: CGFloat) {
        guard let navBar = navBar else {
            return
        }

        let height = navBar.calculatePreferredHeight(targetHeight: targetHeight)

        let inset = height - scrollView.safeAreaInsets.top
        if scrollView.contentInset.top != inset {
            scrollView.contentInset.top = inset
        }
        if scrollView.verticalScrollIndicatorInsets.top != inset {
            scrollView.verticalScrollIndicatorInsets.top = inset
        }
    }
}
