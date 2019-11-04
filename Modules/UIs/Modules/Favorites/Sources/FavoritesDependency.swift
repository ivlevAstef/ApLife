//
//  FavoritesDependency.swift
//  Favorites
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import DITranquillity

final class FavoritesDependency: DIFramework
{
    static func load(container: DIContainer) {
        container.register(FavoritesRouter.init)
            .injection(\.favoritesScreenProvider)
            .lifetime(.objectGraph)

        container.register(FavoritesScreen.init)
            .lifetime(.prototype)
        container.register { FavoritesScreenView() }
            .as(FavoritesScreenViewContract.self)
            .lifetime(.objectGraph)
        container.register(FavoritesScreenPresenter.init)
            .lifetime(.objectGraph)
    }
}
