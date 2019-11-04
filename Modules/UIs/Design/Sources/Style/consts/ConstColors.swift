//
//  ConstColors.swift
//  Design
//
//  Created by Alexander Ivlev on 25/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public enum ConstColors
{
    public static let darkColors = Style.Colors(
        background: color(hex24: 0x000000),
        accent: color(hex24: 0x39383e),
        separator: color(hex24: 0x000000),
        tint: color(hex24: 0xFFFFFF),
        mainText: color(hex24: 0xFFFFFF),
        notAccentText: color(hex24: 0xc3c3c3),
        contentText: color(hex24: 0xc3c3c3),
        lightText: color(hex24: 0xFFFFFF),
        darkText: color(hex24: 0x000000),
        cells: [
            .news: gradient(from: 0x3499ff, to: 0x3a3985),
            .favorites: gradient(from: 0xffe53b, to: 0xff2525),
            .biography: gradient(from: 0x00ffa9, to: 0x0d4dff),
            .settings: gradient(from: 0xd5e200, to: 0x00992c),
            .youtube: gradient(from: 0xff0000, to: 0x282828),
            .habr: gradient(from: 0x9cc2cd, to: 0x8caab5),
            .github: gradient(from: 0x24292e, to: 0x171515),
            .article: gradient(from: 0x00ffed, to: 0x00b8ba),
            .podcast: gradient(from: 0xbce56e, to: 0x3db523),
            .other: gradient(from: 0x312a6c, to: 0x852d91)
        ],
        cellShadowColor: nil,
        cellShadowOpacity: 0.0,
        frontStyle: .dark
    )

    public static let lightColors = Style.Colors(
        background: color(hex24: 0xFFFFFF),
        accent: color(hex24: 0xbdbdbd),
        separator: color(hex24: 0xFFFFFF),
        tint: color(hex24: 0xFFFFFF),
        mainText: color(hex24: 0x000000),
        notAccentText: color(hex24: 0x3c3c3c),
        contentText: color(hex24: 0x3c3c3c),
        lightText: color(hex24: 0xFFFFFF),
        darkText: color(hex24: 0x000000),
        cells: [
            .news: gradient(from: 0x6ee2f5, to: 0x6454f0),
            .favorites: gradient(from: 0xffe53b, to: 0xff2525),
            .biography: gradient(from: 0x00ffa9, to: 0x0d4dff),
            .settings: gradient(from: 0xd5e200, to: 0x00992c),
            .youtube: gradient(from: 0xff0000, to: 0x282828),
            .habr: gradient(from: 0x9cc2cd, to: 0x8caab5),
            .github: gradient(from: 0x24292e, to: 0x171515),
            .article: gradient(from: 0x00ffed, to: 0x00b8ba),
            .podcast: gradient(from: 0xbce56e, to: 0x3db523),
            .other: gradient(from: 0x312a6c, to: 0x852d91)
        ],
        cellShadowColor: color(hex24: 0x000000),
        cellShadowOpacity: 0.25,
        frontStyle: .light
    )
}
