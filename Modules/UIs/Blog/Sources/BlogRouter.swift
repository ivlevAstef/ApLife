//
//  BlogRouter.swift
//  Blog
//
//  Created by Alexander Ivlev on 24/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core
import SwiftLazy

typealias RibbonScreen = Screen<RibbonScreenView, RibbonScreenPresenter>

final class BlogRouter: IRouter
{
    static let name: DeepLink.Name = "blog"

    /*dependency*/var ribbonScreenProvider = Provider<RibbonScreen>()
    
    var rootViewController: UIViewController {
        return uiNavigationController
    }
    
    private let uiNavigationController = UINavigationController(nibName: nil, bundle: nil)
    private let navigationController: NavigationController
    
    init() {
        navigationController = NavigationController(controller: uiNavigationController)
    }
    
    func start(parameters: RoutingParamaters) {
        showRibbonScreen(animated: false)
    }

    func show(_ viewController: UIViewController) {
        navigationController.push(viewController, animated: true)
    }

    private func showRibbonScreen(animated: Bool) {
        let screen = ribbonScreenProvider.value

        navigationController.push(screen.view, animated: animated)
    }
}
