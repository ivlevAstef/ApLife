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
        accent: color(hex24: 0x000000),
        separator: color(hex24: 0x000000),
        tint: color(hex24: 0x000000),
        mainText: color(hex24: 0x000000),
        notAccentText: color(hex24: 0x000000),
        contentText: color(hex24: 0x000000),
        lightText: color(hex24: 0x000000),
        darkText: color(hex24: 0x000000),
        cells: [
            .news: gradient(from: 0x000000, to: 0x000000),
            .favorites: gradient(from: 0x000000, to: 0x000000),
            .biography: gradient(from: 0x000000, to: 0x000000),
            .settings: gradient(from: 0x000000, to: 0x000000),
            .youtube: gradient(from: 0x000000, to: 0x000000),
            .habr: gradient(from: 0x000000, to: 0x000000),
            .github: gradient(from: 0x000000, to: 0x000000),
            .article: gradient(from: 0x000000, to: 0x000000),
            .podcast: gradient(from: 0x000000, to: 0x000000),
            .other: gradient(from: 0x000000, to: 0x000000)
        ],
        frontStyle: .dark
    )

    public static let lightColors = Style.Colors(
        background: color(hex24: 0xFFFFFF),
        accent: color(hex24: 0x000000),
        separator: color(hex24: 0x000000),
        tint: color(hex24: 0x000000),
        mainText: color(hex24: 0x000000),
        notAccentText: color(hex24: 0x000000),
        contentText: color(hex24: 0x000000),
        lightText: color(hex24: 0x000000),
        darkText: color(hex24: 0x000000),
        cells: [
            .news: gradient(from: 0x000000, to: 0x000000),
            .favorites: gradient(from: 0x000000, to: 0x000000),
            .biography: gradient(from: 0x000000, to: 0x000000),
            .settings: gradient(from: 0x000000, to: 0x000000),
            .youtube: gradient(from: 0x000000, to: 0x000000),
            .habr: gradient(from: 0x000000, to: 0x000000),
            .github: gradient(from: 0x000000, to: 0x000000),
            .article: gradient(from: 0x000000, to: 0x000000),
            .podcast: gradient(from: 0x000000, to: 0x000000),
            .other: gradient(from: 0x000000, to: 0x000000)
        ],
        frontStyle: .light
    )
}
