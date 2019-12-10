//
//  NewsRouter.swift
//  News
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

final class NewsRouter: IRouter
{
    /*dependency*/var ribbonScreenProvider = Provider<RibbonScreen>()
    
    private let navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    func start(parameters: RoutingParamaters) {
        let screen = ribbonScreenProvider.value
        screen.setRouter(self)
        navigator.push(screen.view)
    }

    func start() {

    }
}
