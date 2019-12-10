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

    private let navigator: Navigator
    
    init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    func start(parameters: RoutingParamaters) {
        let screen = biographyScreenProvider.value
        screen.setRouter(self)

        navigator.push(screen.view)
    }

}
