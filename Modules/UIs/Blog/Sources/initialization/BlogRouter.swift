//
//  BlogRouter.swift
//  Blog
//
//  Created by Alexander Ivlev on 24/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core

final class BlogRouter: IRouter {
    static let name: DeepLink.Name = "blog"
    
    var rootViewController: UIViewController {
        return uiNavigationController
    }
    
    private let uiNavigationController = UINavigationController(nibName: nil, bundle: nil)
    private let navigationController: NavigationController
    
    init() {
        navigationController = NavigationController(controller: uiNavigationController)
    }
    
    func start(parameters: RoutingParamaters) {
        navigationController.push(FirstViewController(nibName: nil, bundle: nil))
    }
}
