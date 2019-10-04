//
//  StartPoints.swift
//  ApLife
//
//  Created by Alexander Ivlev on 24/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core
import UIComponents

import Menu
import Blog
import Biography

enum StartPoints
{
    static let menu = MenuStartPoint()
    static let blog = BlogStartPoint()
    static let biography = BiographyStartPoint()

    static let common: [CommonStartPoint] = [
        CoreStartPoint(),
        UIComponentsStartPoint()
    ]

    static let ui: [UIModuleName: UIStartPoint] = [
        MenuStartPoint.name: menu,
        BlogStartPoint.name: blog,
        BiographyStartPoint.name: biography
    ]
}
