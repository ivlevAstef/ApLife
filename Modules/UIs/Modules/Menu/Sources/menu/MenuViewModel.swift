//
//  MenuViewModel.swift
//  Menu
//
//  Created by Alexander Ivlev on 27/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Foundation

struct MenuViewModel {
    enum Style {
        case news
        case favorites
        case biography
        case settings
    }
    let style: Style

    let title: String
    let subtitle: String
}
