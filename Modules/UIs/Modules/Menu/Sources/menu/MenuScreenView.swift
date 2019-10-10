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
    private let navStatusBar: StatusNavigationBar = StatusNavigationBar()
    private let scrollView: UIScrollView = UIScrollView(frame: .zero)
    private let contentView: UIView = UIView(frame: .zero)

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        view.addSubview(UIImageView(image: UIImage(named: "background")))

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0)

        scrollView.addSubview(contentView)
        contentView.frame.origin = .zero
        contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0)
        contentView.backgroundColor = .lightGray
        contentView.addSubview(UIImageView(image: UIImage(named: "background")))
        contentView.clipsToBounds = true
        for i in 0..<75 {
            let label = UILabel(frame: .zero)
            label.text = "\(i)"
            label.font = UIFont.systemFont(ofSize: 20.0)
            label.frame = CGRect(x: 100, y: i * 30, width: 100, height: 20)
            contentView.addSubview(label)
        }

        view.addSubview(navStatusBar)

        let leftView1 = TestNavItemView(width: 45.0)
        leftView1.backgroundColor = .black
        let leftView2 = TestNavItemView(width: 25.0)
        leftView2.backgroundColor = .white
        navStatusBar.leftItems = [leftView1, leftView2]

        let rightView1 = TestNavItemView(width: 45.0)
        rightView1.backgroundColor = .black
        navStatusBar.rightItems = [rightView1]

        let centerContentView = NavCenterLabelView()
        navStatusBar.centerContentView = centerContentView
        centerContentView.text = "Alexander"
        centerContentView.textColor = .black

        let accessoryView1 = TestAccessoryView(fullyHeight: 50.0, canHidden: false)
        navStatusBar.accessoryItems = [accessoryView1, SearchBarAccessoryView()]

        navStatusBar.backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

        navStatusBar.initialDisplayMode = .large
        navStatusBar.displayMode = .fullyAuto
        navStatusBar.rightItemsGlueBottom = true

        navStatusBar.frame.origin = .zero
        navStatusBar.bind(to: scrollView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if !scrollView.frame.size.equalTo(view.bounds.size) {
            scrollView.frame = view.bounds
        }

        if abs(navStatusBar.frame.width - view.bounds.width) > 0.1 {
            navStatusBar.frame.size.width = view.bounds.width

            navStatusBar.update(force: true)
        }
    }
}

