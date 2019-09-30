//
//  RibbonViewModel.swift
//  Blog
//
//  Created by Alexander Ivlev on 29/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Foundation
import UIComponents

enum RibbonElementViewModel
{
    case article(ArticleViewModel)
    case habr
    case github
    case youtube
    case presentation
}

struct ArticleViewModel
{
    let title: String
    let image: ChangeableImage
    let shortDescription: String
    let date: Date

    //let author: Profile

    let likes: UInt
    let dislikes: UInt

    let numberOfReads: UInt
    let numberOfComments: UInt
}

struct HabrViewModel
{

}

struct GitHubViewModel
{

}

struct YouTubeViewModel
{

}

struct PresentationViewModel
{

}
