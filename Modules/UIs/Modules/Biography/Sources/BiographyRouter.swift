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

    /*dependency*/var biographyScreenProvider = Lazy<BiographyScreen>()
    
    var rootViewController: UIViewController {
        log.assert(biographyScreenProvider.wasMade, "Please call start before get root view controller")
        return biographyScreenProvider.value.view
    }

    private let navController: NavigationController
    
    init(navController: NavigationController) {
        self.navController = navController
    }
    
    func configure(parameters: RoutingParamaters) -> IRouter {
        configureBiographyScreen()

        return self
    }

    func start() {

    }

    private func configureBiographyScreen() {
        let screen = biographyScreenProvider.value
        _ = screen.presenter

        log.info("configure biography screen success")
    }
}
