//
//  BlogRouter.swift
//  Blog
//
//  Created by Alexander Ivlev on 24/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core
import Common
import SwiftLazy
import UIComponents

typealias RibbonScreen = Screen<RibbonScreenView, RibbonScreenPresenter>

final class BlogRouter: IRouter
{
    /*dependency*/var ribbonScreenProvider = Lazy<RibbonScreen>()
    
    var rootViewController: UIViewController {
        log.assert(ribbonScreenProvider.wasMade, "Please call start before get root view controller")
        return ribbonScreenProvider.value.view
    }

    private let navController: NavigationController
    
    init(navController: NavigationController) {
        self.navController = navController
    }
    
    func configure(parameters: RoutingParamaters) -> IRouter {
        configureRibbonScreen()

        return self
    }

    func start() {

    }

    private func configureRibbonScreen() {
        let screen = ribbonScreenProvider.value
        _ = screen.presenter

        log.info("configure ribbon screen success")
    }
}
