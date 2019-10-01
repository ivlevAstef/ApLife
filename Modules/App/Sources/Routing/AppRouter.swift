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

final class AppRouter: IRouter
{
    var rootViewController: UIViewController {
        return navController.uiController
    }

    private let navController: NavigationController
    private var isConfigured: Bool = false
    private var needAnimated: Bool { return !isConfigured }

    init(navController: NavigationController) {
        self.navController = navController

        self.subscribeOn(StartPoints.menu)
        self.subscribeOn(StartPoints.blog)
    }

    @discardableResult
    func configure(parameters: RoutingParamaters) -> IRouter {
        isConfigured = false
        defer { isConfigured = true }

        let router = StartPoints.menu.makeRouter().configure(parameters: parameters)

        let startPointsCanOpened = parameters.isEmpty
            ? []
            : StartPoints.ui.values.filter { $0.isSupportOpen(with: parameters) }

        if startPointsCanOpened.isEmpty {
            navController.push(router, animated: needAnimated)
        } else {
            navController.notStartPush(router, animated: needAnimated)
        }

        assert(startPointsCanOpened.count <= 1, "By parameters can open more start points - it's correct, or not?")
        for startPoint in startPointsCanOpened {
            let router = startPoint.makeRouter().configure(parameters: parameters)
            navController.push(router, animated: needAnimated)
        }

        return self
    }

    private func subscribeOn(_ startPoint: MenuStartPoint) {
        StartPoints.menu.showBlogNotifier.join({ [weak self] in
            if let self = self {
                let router = StartPoints.blog.makeRouter().configure()
                self.navController.push(router, animated: self.needAnimated)
            }
        })
    }

    private func subscribeOn(_ startPoint: BlogStartPoint) {

    }
}
