//
//  SettingsRouter.swift
//  Settings
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core
import UIComponents
import Common
import SwiftLazy


typealias SettingsScreen = Screen<SettingsScreenView, SettingsScreenPresenter>

final class SettingsRouter: IRouter
{
    /*dependency*/var settingsScreenProvider = Provider<SettingsScreen>()

    private let navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func start(parameters: RoutingParamaters) {
        let screen = settingsScreenProvider.value
        screen.setRouter(self)

        navigator.push(screen.view)
    }

    func start() {
    }
}


