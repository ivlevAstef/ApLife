//
//  RibbonScreenView.swift
//  Blog
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Common

final class RibbonScreenView: UIViewController, RibbonScreenViewContract
{
    let needFullRefreshNotifier = Notifier<Void>()
    let needNextPageNotifier = Notifier<Void>()

    // also search
    // also filter
    private let tableView: RibbonTableView = RibbonTableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }

    func update(_ viewModels: [RibbonElementViewModel], animated: Bool) {

    }

    func add(_ viewModels: [RibbonElementViewModel], animated: Bool) {

    }

    func showFullActivity() {

    }

    func showNextPageActivity() {

    }
}
