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

    /*dependency*/var menuScreenProvider = Provider<MenuScreen>()

    private let navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func start(parameters: RoutingParamaters) {
        let screen = menuScreenProvider.value
        configure(screen)
        
        navigator.push(screen.view)
    }

    private func configure(_ screen: MenuScreen) {
        screen.setRouter(self)
        
        // TODO: Can use `getter.hasCallback()` for configure menu...
        screen.presenter.showAccount.weakJoin(listener: { (self, _) in
            self.showAccount()
        }, owner: self)
        screen.presenter.showNews.weakJoin(listener: { (self, showParams) in
            self.showScreen(use: self.newsGetter, showParams: showParams)
        }, owner: self)
        screen.presenter.showFavorites.weakJoin(listener: { (self, showParams) in
            self.showScreen(use: self.favoritesGetter, showParams: showParams)
        }, owner: self)
        screen.presenter.showBiography.weakJoin(listener: { (self, showParams) in
            self.showScreen(use: self.biographyGetter, showParams: showParams)
        }, owner: self)
        screen.presenter.showSettings.weakJoin(listener: { (self, showParams) in
            self.showScreen(use: self.settingsGetter, showParams: showParams)
        }, owner: self)
    }

    private func showAccount() {
        log.info("will show \(accountGetter)")
        guard let router = accountGetter.get(()) else {
            log.info("Not support show \(accountGetter)")
            return
        }

        router.start()
        log.info("did show \(accountGetter)")
    }

    private func showScreen(use getter: Getter<Void, IRouter>, showParams: MenuScreenPresenter.ShowParams) {
        log.info("will show \(getter)")
        guard let router = getter.get(()) else {
            log.info("Not support show \(getter)")
            return
        }

        if !showParams.preview {
            router.start()
            log.info("did show \(getter)")
        } else {
            #warning("Support preview")
            log.info("did preview \(getter)")
        }
    }
}

