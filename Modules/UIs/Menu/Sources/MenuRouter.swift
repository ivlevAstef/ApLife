//
//  MenuRouter.swift
//  Menu
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//


import UIKit
import Core
import Common
import SwiftLazy


typealias MenuScreen = Screen<MenuScreenView, MenuScreenPresenter>

final class MenuRouter: IRouter
{
    let showAccountNotifier = Notifier<Void>()
    let showBlogNotifier = Notifier<Void>()
    let showBiographyNotifier = Notifier<Void>()
    let showSettingsNotifier = Notifier<Void>()

    /*dependency*/var menuScreenProvider = Lazy<MenuScreen>()
    
    var rootViewController: UIViewController {
        log.assert(menuScreenProvider.wasMade, "Please call start before get root view controller")
        return menuScreenProvider.value.view
    }

    private let navController: NavigationController

    init(navController: NavigationController) {
        self.navController = navController
    }

    func configure(parameters: RoutingParamaters) -> IRouter {
        configureMenuScreen()
        return self
    }

    func start() {
        log.info("will notify show blog")
        showBlogNotifier.notify(())
    }

    private func configureMenuScreen() {
        let screen = menuScreenProvider.value
        _ = screen.presenter

        log.info("configure menu screen success")
    }
}

