//
//  AccountRouter.swift
//  Account
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core
import UIComponents
import Common
import SwiftLazy


typealias AccountScreen = Screen<AccountScreenView, AccountScreenPresenter>

final class AccountRouter: IRouter
{
    /*dependency*/var accountScreenProvider = Provider<AccountScreen>()

    var rootViewController: UIViewController {
        let screen = accountScreenProvider.value
        configure(screen)
        return screen.view
    }

    private let navController: NavigationController

    init(navController: NavigationController) {
        self.navController = navController
    }

    func configure(parameters: RoutingParamaters) -> IRouter {
        return self
    }

    func start() {
    }

    private func configure(_ screen: AccountScreen) {
        screen.setRouter(self)
    }
}


