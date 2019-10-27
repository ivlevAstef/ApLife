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
    private lazy var tableView = MenuTable(parent: self)
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
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.viewModels = [
            MenuViewModel(style: .news, title: "News", subtitle: "youtube, podcasts, articles"),
            MenuViewModel(style: .favorites, title: "Favorites", subtitle: "you choice"),
            MenuViewModel(style: .biography, title: "Biography", subtitle: "about author"),
            MenuViewModel(style: .settings, title: "Settings", subtitle: "custumize yourself")
        ]

        super.viewDidLoad()

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

        navStatusBar.accessoryItems = [SearchBarAccessoryView()]

        navStatusBar.initialDisplayMode = .large
        navStatusBar.displayMode = .fullyAuto
        navStatusBar.rightItemsGlueBottom = true

        navStatusBar.bind(to: tableView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if !tableView.frame.size.equalTo(view.bounds.size) {
            tableView.frame = view.bounds
        }
    }
}

private class MenuTable: UITableView, UITableViewDataSource, UITableViewDelegate {
    var viewModels: [MenuViewModel] = []

    private unowned var parent: MenuScreenView

    init(parent: MenuScreenView) {
        self.parent = parent
        super.init(frame: .zero, style: .plain)

        register(MenuCell.self, forCellReuseIdentifier: MenuCell.identifier)

        dataSource = self
        delegate = self

        tableFooterView = UIView(frame: .zero)
        separatorStyle = .none
        allowsSelection = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier) as? MenuCell else {
            log.fatal("reusable cell it's invalid")
        }

        cell.setup(viewModels[indexPath.row])
        parent.addViewForStylizing(cell)

        return cell
    }
}
