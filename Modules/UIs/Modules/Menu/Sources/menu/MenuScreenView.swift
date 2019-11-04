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
    let showAccount = Notifier<Void>()
    var viewModels: [MenuViewModel]  {
        get { return tableView.viewModels }
        set { tableView.viewModels = newValue; tableView.reloadData() }
    }

    private let avatarView = NavigationAvatarView()
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

        super.viewDidLoad()

        avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnAvatar)))
        avatarView.setup(letter: "AP")
        navStatusBar.rightItems = [avatarView]
        addViewForStylizing(avatarView)

        let centerContentView = NavigationCenterTextView()
        centerContentView.text = "Alexander"
        navStatusBar.centerContentView = centerContentView
        addViewForStylizing(centerContentView)

        let searchView = NavigationSearchBarAccessoryView()
        searchView.placeholder = "Search"
        navStatusBar.accessoryItems = [searchView]
        addViewForStylizing(searchView)

        navStatusBar.initialDisplayMode = .large
        navStatusBar.displayMode = .largeAuto
        navStatusBar.rightItemsGlueBottom = true

        navStatusBar.bind(to: tableView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if !tableView.frame.size.equalTo(view.bounds.size) {
            tableView.frame = view.bounds
        }
    }

    @objc
    private func tapOnAvatar() {
        showAccount.notify(())
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
