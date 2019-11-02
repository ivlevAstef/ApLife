//
//  MenuViewModel.swift
//  Menu
//
//  Created by Alexander Ivlev on 27/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Common

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

    let show: Notifier<Void>
    let preview: Notifier<Void>
}
