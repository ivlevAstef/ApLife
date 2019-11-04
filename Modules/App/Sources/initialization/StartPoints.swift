//
//  StartPoints.swift
//  ApLife
//
//  Created by Alexander Ivlev on 24/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core
import Design
import UIComponents

import Menu
import Account
import News
import Favorites
import Biography
import Settings

enum StartPoints
{
    static let menu = MenuStartPoint()
    static let account = AccountStartPoint()
    static let news = NewsStartPoint()
    static let favorites = FavoritesStartPoint()
    static let biography = BiographyStartPoint()
    static let settings = SettingsStartPoint()

    static let common: [CommonStartPoint] = [
        CoreStartPoint(),
        DesignStartPoint(),
        UIComponentsStartPoint()
    ]

    static let ui: [UIModuleName: UIStartPoint] = [
        MenuStartPoint.name: menu,
        AccountStartPoint.name: account,
        NewsStartPoint.name: news,
        FavoritesStartPoint.name: favorites,
        BiographyStartPoint.name: biography,
        SettingsStartPoint.name: settings,
    ]
}
