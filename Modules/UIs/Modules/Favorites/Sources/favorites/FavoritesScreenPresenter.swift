//
//  FavoritesScreenPresenter.swift
//  Favorites
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//


import Common

protocol FavoritesScreenViewContract
{
}

final class FavoritesScreenPresenter
{
    private let view: FavoritesScreenViewContract

    init(view: FavoritesScreenViewContract) {
        self.view = view
    }
}

