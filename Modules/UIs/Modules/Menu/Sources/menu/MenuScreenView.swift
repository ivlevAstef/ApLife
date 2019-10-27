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
import Design

final class MenuScreenView: ApViewController, MenuScreenViewContract
{
    private let scrollView: UIScrollView = UIScrollView(frame: .zero)
    private let contentView: UIView = UIView(frame: .zero)

    public init() {
        super.init(navStatusBar: StatusNavigationBar())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func styleDidChange(_ style: Style) {
        super.styleDidChange(style)
    }

    override func viewDidLoad() {

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0)

        super.viewDidLoad()

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

        let leftView1 = TestNavItemView(width: 45.0)
        leftView1.backgroundColor = .black
        let leftView2 = TestNavItemView(width: 25.0)
        leftView2.backgroundColor = .white
        navStatusBar.leftItems = [leftView1, leftView2]

        let rightView1 = TestNavItemView(width: 45.0)
        rightView1.backgroundColor = .black
        navStatusBar.rightItems = [rightView1]

        let centerContentView = NavCenterLabelView()
        centerContentView.text = "Alexander"
        navStatusBar.centerContentView = centerContentView
        addViewForStylizing(centerContentView)

        let accessoryView1 = TestAccessoryView(fullyHeight: 50.0, canHidden: false)
        navStatusBar.accessoryItems = [accessoryView1, SearchBarAccessoryView()]

        navStatusBar.initialDisplayMode = .large
        navStatusBar.displayMode = .fullyAuto
        navStatusBar.rightItemsGlueBottom = true

        navStatusBar.bind(to: scrollView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if !scrollView.frame.size.equalTo(view.bounds.size) {
            scrollView.frame = view.bounds
        }
    }
}

