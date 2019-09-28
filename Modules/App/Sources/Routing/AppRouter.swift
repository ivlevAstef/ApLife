//
//  AppRouter.swift
//  ApLife
//
//  Created by Alexander Ivlev on 22/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core
import SwiftLazy

import Menu
import Blog

final class AppRouter: IRouter {
    var rootViewController: UIViewController {
        return menuRouter.rootViewController
    }
    
    private lazy var menuRouter: IRouter = {
        return StartPoints.menu.makeRouter()
    }()
    
    init() {
        self.subscribeOn(StartPoints.menu)
        self.subscribeOn(StartPoints.blog)
    }
    
    func start(parameters: RoutingParamaters) {
        menuRouter.start(parameters: parameters)

        if !parameters.isEmpty {
            for startPoint in StartPoints.ui.values {
                if startPoint.isSupportOpen(with: parameters) {
                    show(startPoint.makeRouter().rootViewController)
                    break
                }
            }
        }

        show(SecondViewController(nibName: nil, bundle: nil))
    }

    func show(_ viewController: UIViewController) {
        menuRouter.show(viewController)
    }

    private func subscribeOn(_ startPoint: MenuStartPoint) {
        StartPoints.menu.blogRouterProvider = Lazy {
            return StartPoints.blog.makeRouter()
        }
    }

    private func subscribeOn(_ startPoint: BlogStartPoint) {

    }
}
