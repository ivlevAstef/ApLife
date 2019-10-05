//
//  ScrollNavigationBarController.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 05/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public final class ScrollNavigationBarController: NSObject, UIScrollViewDelegate {

    private let scrollView: UIScrollView
    private let navBar: INavigationBar

    private var height: CGFloat = 0.0

    public init(scrollView: UIScrollView, navBar: INavigationBar) {
        self.scrollView = scrollView
        self.navBar = navBar

        super.init()

        scrollView.bounces = true
        scrollView.delegate = self
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        navBar.preferredHeight = -scrollView.contentOffset.y
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //height = navBar.minAutoHeight
        //scrollView.contentInset.top = height
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // TODO: need use velocity for calculate minAutoHeight
        height = navBar.minAutoHeight
        scrollView.contentInset.top = height - scrollView.safeAreaInsets.top

        if abs(velocity.y) < 1.0e-3 {
            height = navBar.minAutoHeight
            scrollView.setContentOffset(CGPoint(x: 0.0, y: -height), animated: true)
        }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        height = navBar.minAutoHeight
        scrollView.setContentOffset(CGPoint(x: 0.0, y: -height), animated: true)
    }

//    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        scrollView.contentInset.top = height
//    }
}
