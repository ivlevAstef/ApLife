//
//  TabController.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 22/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public final class TabController<EnumType: Hashable> {

    public var selectedTab: EnumType? {
        return getSelectedTab()
    }

    private let uiController: UITabBarController

    private var tabsCustomization: [EnumType: UITabBarItem] = [:]
    private var tabs: [EnumType: UIViewController] = [:]

    public init(controller: UITabBarController) {
        self.uiController = controller
    }

    public func addCustomization(name: EnumType, tabBar: UITabBarItem) {
        tabsCustomization[name] = tabBar
    }

    public func addTab(name: EnumType, vc: UIViewController, animated: Bool = true) {
        assert(!tabs.keys.contains(name))
        assert(tabsCustomization.keys.contains(name))

        vc.tabBarItem = tabsCustomization[name]

        let viewControllers = (uiController.viewControllers ?? []) + [vc]
        uiController.setViewControllers(viewControllers, animated: animated)

        tabs[name] = vc
    }

    public func removeTab(name: EnumType, animated: Bool = true) {
        assert(tabs.keys.contains(name))

        if let vc = tabs[name] {
            var viewControllers = uiController.viewControllers ?? []
            viewControllers.removeAll(where: { $0 === vc })
            uiController.setViewControllers(viewControllers, animated: animated)
        }

        tabs.removeValue(forKey: name)
    }

    public func selectTab(name: EnumType, animated: Bool = true) {
        assert(tabs.keys.contains(name))

        if let vc = tabs[name], let index = (uiController.viewControllers ?? []).firstIndex(of: vc) {
            if uiController.selectedIndex != index {
                uiController.selectedIndex = index
            }
        }
    }

    public func containsTab(name: EnumType) -> Bool {
        return tabs.keys.contains(name)
    }

    public func removeAllTab() {
        uiController.setViewControllers([], animated: false)
        tabs.removeAll()
    }

    private func getSelectedTab() -> EnumType? {
        let viewControllers = uiController.viewControllers ?? []
        let selectedIndex = uiController.selectedIndex

        if 0 <= selectedIndex && selectedIndex < viewControllers.count {
            let viewController = viewControllers[selectedIndex]

            return tabs.first(where: { $1 === viewController })?.key
        }

        return nil
    }

}
