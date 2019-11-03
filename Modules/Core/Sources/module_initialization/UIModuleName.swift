//
//  UIModuleName.swift
//  Core
//
//  Created by Alexander Ivlev on 30/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

public enum UIModuleName {
    case menu
    case news
    case account
    case biography
    case settings

    public var deeplinkName: DeepLink.Name {
        switch self {
        case .menu: return "menu"
        case .news: return "news"
        case .account: return "account"
        case .biography: return "biography"
        case .settings: return "settings"
        }
    }
}
