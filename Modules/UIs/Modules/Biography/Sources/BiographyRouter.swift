//
//  BiographyRouter.swift
//  Biography
//
//  Created by Alexander Ivlev on 24/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core
import Common
import UIComponents
import SwiftLazy

typealias BiographyScreen = Screen<BiographyScreenView, BiographyScreenPresenter>

final class BiographyRouter: IRouter
{
    /*dependency*/var biographyScreenProvider = Provider<BiographyScreen>()
    
    var rootViewController: UIViewController {
        let screen = biographyScreenProvider.value
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

    private func configure(_ screen: BiographyScreen) {
        screen.setRouter(self)
    }
}
