//
//  MenuScreenPresenter.swift
//  Menu
//
//  Created by Alexander Ivlev on 30/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Common

protocol MenuScreenViewContract: class
{
    var showAccount: Notifier<Void> { get }

    var viewModels: [MenuViewModel] { get set }
}

final class MenuScreenPresenter
{
    struct ShowParams {
        let preview: Bool
    }
    let showAccount = Notifier<Void>()
    let showNews = Notifier<ShowParams>()
    let showFavorites = Notifier<ShowParams>()
    let showBiography = Notifier<ShowParams>()
    let showSettings = Notifier<ShowParams>()

    private let view: MenuScreenViewContract

    init(view: MenuScreenViewContract) {
        self.view = view

        configure()
    }

    private func configure() {
        view.showAccount.join(showAccount)

        view.viewModels = [
            MenuViewModel(
                style: .news,
                title: "News",
                subtitle: "youtube, podcasts, articles",
                show: Notifier(showNews, map: { ShowParams(preview: false) }),
                preview: Notifier(showNews, map: { ShowParams(preview: true) })
            ),
            MenuViewModel(
                style: .favorites,
                title: "Favorites",
                subtitle: "you choice",
                show: Notifier(showFavorites, map: { ShowParams(preview: false) }),
                preview: Notifier(showFavorites, map: { ShowParams(preview: true) })
            ),
            MenuViewModel(
                style: .biography,
                title: "Biography",
                subtitle: "about author",
                show: Notifier(showBiography, map: { ShowParams(preview: false) }),
                preview: Notifier(showBiography, map: { ShowParams(preview: true) })
            ),
            MenuViewModel(
                style: .settings,
                title: "Settings",
                subtitle: "custumize yourself",
                show: Notifier(showSettings, map: { ShowParams(preview: false) }),
                preview: Notifier(showSettings, map: { ShowParams(preview: true) })
            )
        ]
    }
}
