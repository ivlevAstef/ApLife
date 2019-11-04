//
//  FavoritesRouter.swift
//  Favorites
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core
import UIComponents
import Common
import SwiftLazy


typealias FavoritesScreen = Screen<FavoritesScreenView, FavoritesScreenPresenter>

final class FavoritesRouter: IRouter
{
    /*dependency*/var favoritesScreenProvider = Provider<FavoritesScreen>()

    var rootViewController: UIViewController {
        let screen = favoritesScreenProvider.value
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

    private func configure(_ screen: FavoritesScreen) {
        screen.setRouter(self)
    }
}


