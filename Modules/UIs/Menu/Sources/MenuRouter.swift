//
//  MenuRouter.swift
//  Menu
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//


import UIKit
import Core
import SwiftLazy

final class MenuRouter: IRouter
{
    enum Tab {
        case blog
        case account
        case settings
    }

    /*dependency*/var routerProviders: [Tab: Lazy<IRouter>] = [:]
    
    var rootViewController: UIViewController {
        return uiTabBarController
    }

    private let tabsOrder: [Tab] = [.blog, .account, .settings]

    private let uiTabBarController = UITabBarController(nibName: nil, bundle: nil)
    private let tabController: TabController<Tab>
    
    init() {
        tabController = TabController(controller: uiTabBarController)
        
        tabController.addCustomization(name: .blog, tabBar: UITabBarItem(tabBarSystemItem: .featured, tag: 0))
        tabController.addCustomization(name: .account, tabBar: UITabBarItem(tabBarSystemItem: .contacts, tag: 1))
        tabController.addCustomization(name: .settings, tabBar: UITabBarItem(tabBarSystemItem: .more, tag: 2))
    }
    
    func start(parameters: RoutingParamaters) {
        for tab in tabsOrder {
            if let router = routerProviders[tab]?.value {
                tabController.addTab(name: tab, vc: router.rootViewController, animated: false)
                router.start(parameters: parameters)
            }
        }

        for tab in tabsOrder {
            if routerProviders.keys.contains(tab) {
                tabController.selectTab(name: tab)
            }
        }
    }

    func show(_ viewController: UIViewController) {
        guard let selectedTab = tabController.selectedTab else {
            fatalError("Can't show view controller in menu because not found selected tab")
        }

        guard let selectedRouter = routerProviders[selectedTab]?.value else {
            fatalError("Can't show view controller in menu because not found router for tab: \(selectedTab)")
        }

        selectedRouter.show(viewController)
    }
}

