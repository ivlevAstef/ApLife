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

    private let navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func start(parameters: RoutingParamaters) {
        let screen = accountScreenProvider.value
        screen.setRouter(self)

        navigator.push(screen.view)
    }
}


