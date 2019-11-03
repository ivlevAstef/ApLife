//
//  MenuRouter.swift
//  Menu
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//


import UIKit
import Core
import UIComponents
import Common
import SwiftLazy


typealias MenuScreen = Screen<MenuScreenView, MenuScreenPresenter>

final class MenuRouter: IRouter
{
    let accountGetter = Getter<Void, IRouter>()
    let newsGetter = Getter<Void, IRouter>()
    let favoritesGetter = Getter<Void, IRouter>()
    let biographyGetter = Getter<Void, IRouter>()
    let settingsGetter = Getter<Void, IRouter>()

    // TODO: change on provider because current implementation have memory leaks
    /*dependency*/var menuScreenProvider = Lazy<MenuScreen>()
    
    var rootViewController: UIViewController {
        log.assert(menuScreenProvider.wasMade, "Please call start before get root view controller")
        return menuScreenProvider.value.view
    }

    private let navController: NavigationController

    init(navController: NavigationController) {
        self.navController = navController
    }

    func configure(parameters: RoutingParamaters) -> IRouter {
        configureMenuScreen()
        return self
    }

    func start() {
//        log.info("will show blog")
//        if let blogRouter = blogGetter.get(()) {
//            navController.push(blogRouter, animated: false)
//            log.info("did show blog")
//        }
    }

    private func configureMenuScreen() {
        let screen = menuScreenProvider.value
        // TODO: Can use `getter.hasCallback()` for configure menu...
        screen.presenter.showAccount.join(listener: { [self] (showParams) -> Void in
            self.showScreen(use: self.accountGetter, showParams: showParams)
        })
        screen.presenter.showNews.join(listener: { [self] showParams in
            self.showScreen(use: self.newsGetter, showParams: showParams)
        })
        screen.presenter.showFavorites.join(listener: { [self] showParams in
            self.showScreen(use: self.favoritesGetter, showParams: showParams)
        })
        screen.presenter.showBiography.join(listener: { [self] showParams in
            self.showScreen(use: self.biographyGetter, showParams: showParams)
        })
        screen.presenter.showSettings.join(listener: { [self] showParams in
            self.showScreen(use: self.settingsGetter, showParams: showParams)
        })

        log.info("configure menu screen success")
    }

    private func showScreen(use getter: Getter<Void, IRouter>, showParams: MenuScreenPresenter.ShowParams) {
        log.info("will show \(getter)")
        guard let router = getter.get(()) else {
            log.info("Not support show \(getter)")
            return
        }

        if !showParams.preview {
            navController.push(router, animated: true)
            log.info("did show \(getter)")
        } else {
            #warning("Support preview")
            log.info("did preview \(getter)")
        }

    }
}

