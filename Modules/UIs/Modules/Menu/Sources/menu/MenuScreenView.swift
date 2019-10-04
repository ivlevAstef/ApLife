//
//  MenuScreenView.swift
//  Menu
//
//  Created by Alexander Ivlev on 30/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Common
import UIComponents

final class MenuScreenView: UIViewController, MenuScreenViewContract
{
    private let navStatusBar: NavigationStatusBar = NavigationStatusBar()
    private let scrollView: UIScrollView = UIScrollView(frame: .zero)
    private let contentView: UIView = UIView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0)

        scrollView.addSubview(contentView)
        contentView.frame.origin = .zero
        contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0)
        contentView.backgroundColor = .blue

        view.addSubview(navStatusBar)
        navStatusBar.navBar.resizePolicy = .default

        let leftView1 = UIView(frame: CGRect(x: 0, y: 0, width: 45.0, height: 0.0))
        leftView1.backgroundColor = .black
        leftView1.translatesAutoresizingMaskIntoConstraints = false
        let leftView2 = UIView(frame: CGRect(x: 0, y: 0, width: 25.0, height: 0.0))
        leftView2.backgroundColor = .white
        leftView2.translatesAutoresizingMaskIntoConstraints = false
        navStatusBar.navBar.setLeftItems([leftView1, leftView2])

        let rightView1 = UIView(frame: CGRect(x: 0, y: 0, width: 45.0, height: 0.0))
        rightView1.backgroundColor = .black
        rightView1.translatesAutoresizingMaskIntoConstraints = false
        let rightView2 = UIView(frame: CGRect(x: 0, y: 0, width: 25.0, height: 0.0))
        rightView2.backgroundColor = .white
        rightView2.translatesAutoresizingMaskIntoConstraints = false
        navStatusBar.navBar.setRightItems([rightView1, rightView2])

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navStatusBar.navBar.resizePolicy = .auto
            UIView.animate(withDuration: 5.0) {
                self.navStatusBar.navBar.preferredHeight = 200.0
            }
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        scrollView.frame = view.bounds

        navStatusBar.frame.origin = .zero
    }
}

