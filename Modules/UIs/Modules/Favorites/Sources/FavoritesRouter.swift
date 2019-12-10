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

    private let navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func start(parameters: RoutingParamaters) {
        let screen = favoritesScreenProvider.value
        screen.setRouter(self)

        navigator.push(screen.view)
    }
}


