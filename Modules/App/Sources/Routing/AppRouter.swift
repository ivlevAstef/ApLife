//
//  AppRouter.swift
//  ApLife
//
//  Created by Alexander Ivlev on 22/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core

import Blog

final class AppRouter: IRouter {
    private enum Tabs {
        case blog
        case account
        case settings
    }
    
    static let name: DeepLink.Name = "app"
    
    var rootViewController: UIViewController {
        return uiTabBarController
    }
    
    private let uiTabBarController = UITabBarController(nibName: nil, bundle: nil)
    private let tabController: TabController<Tabs>
    
    init() {
        tabController = TabController(controller: uiTabBarController)
        
        tabController.addCustomization(name: .blog, tabBar: UITabBarItem(tabBarSystemItem: .featured, tag: 0))
        tabController.addCustomization(name: .account, tabBar: UITabBarItem(tabBarSystemItem: .contacts, tag: 1))
        tabController.addCustomization(name: .settings, tabBar: UITabBarItem(tabBarSystemItem: .more, tag: 2))
    }
    
    func start(parameters: RoutingParamaters) {
        let blogStartPoint = StartPoints.ui[BlogStartPoint.name]!
        
        tabController.addTab(name: .blog, vc: blogStartPoint.makeRouter().rootViewController, animated: false)
        tabController.addTab(name: .account, vc: SecondViewController(nibName: nil, bundle: nil), animated: false)
        
        tabController.selectTab(name: .blog)
    }
}
