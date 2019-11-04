//
//  UIModuleName.swift
//  Core
//
//  Created by Alexander Ivlev on 30/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

public enum UIModuleName {
    case menu
    case account
    case news
    case favorites
    case biography
    case settings

    public var deeplinkName: DeepLink.Name {
        switch self {
        case .menu: return "menu"
        case .account: return "account"
        case .news: return "news"
        case .favorites: return "favorites"
        case .biography: return "biography"
        case .settings: return "settings"
        }
    }
}
