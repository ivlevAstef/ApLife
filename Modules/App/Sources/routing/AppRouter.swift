//
//  AppRouter.swift
//  ApLife
//
//  Created by Alexander Ivlev on 22/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core
import Common
import UIComponents

import Menu
import News
import Biography

final class AppRouter: IRouter
{
    var rootViewController: UIViewController {
        return navigator.controller
    }

    private let navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator

        StartPoints.menu.subscribersFiller = subscriberFiller
    }

    func start(parameters: RoutingParamaters) {
        navigator.reset()

        let router = StartPoints.menu.makeRouter(use: navigator)

        let startPointsCanOpened = parameters.isEmpty
            ? []
            : StartPoints.ui.filter { $0.isSupportOpen(with: parameters) }

        if startPointsCanOpened.isEmpty {
            router.start()
        }

        log.assert(startPointsCanOpened.count <= 1, "By parameters can open more start points - it's correct, or not?")
        for startPoint in startPointsCanOpened {
            let router = startPoint.makeRouter(use: navigator)
            router.start(parameters: parameters)
        }
    }

    private func subscriberFiller(_ navigator: Navigator, subscribers: MenuStartPoint.Subscribers) {
        subscribers.accountGetter.take(use: {
            return StartPoints.account.makeRouter(use: navigator)
        })

        subscribers.newsGetter.take(use: {
            return StartPoints.news.makeRouter(use: navigator)
        })
        subscribers.favoritesGetter.take(use: {
            return StartPoints.favorites.makeRouter(use: navigator)
        })
        subscribers.biographyGetter.take(use: {
            return StartPoints.biography.makeRouter(use: navigator)
        })
        subscribers.settingsGetter.take(use: {
            return StartPoints.settings.makeRouter(use: navigator)
        })
    }
}
