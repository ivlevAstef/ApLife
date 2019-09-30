//
//  StartPoints.swift
//  ApLife
//
//  Created by Alexander Ivlev on 24/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core

import Menu
import Blog

enum StartPoints
{
    static let menu = MenuStartPoint()
    static let blog = BlogStartPoint()

    static let common: [CommonStartPoint] = [
    ]

    static let ui: [DeepLink.Name: UIStartPoint] = [
        MenuStartPoint.name: menu,
        BlogStartPoint.name: blog
    ]
}
