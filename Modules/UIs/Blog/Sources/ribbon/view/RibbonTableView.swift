//
//  RibbonTableView.swift
//  Blog
//
//  Created by Alexander Ivlev on 29/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

final class RibbonTableView: UIView
{
    private let tableView: UITableView = UITableView(frame: .zero)

    private let refreshControl = UIRefreshControl(frame: .zero)

    private let tableController = TableController()

    private var viewModels: [RibbonElementViewModel] = []

    init() {
        super.init(frame: .zero)

        configure()
    }

    public func update(_ newViewModels: [RibbonElementViewModel]) {
        viewModels
    }

    public func add(_ newViewModels: [RibbonElementViewModel], animated: Bool) {
        viewModels
    }

    private func configure() {
        tableView.register(RibbonArticleCell.self, forCellReuseIdentifier: RibbonArticleCell.identifier)
        tableView.dataSource = tableController
        tableView.delegate = tableController

        tableView.refreshControl = refreshControl
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private class TableController: NSObject, UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError()
    }

}
