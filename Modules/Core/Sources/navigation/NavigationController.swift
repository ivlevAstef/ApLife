//
//  NavigationController.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 22/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public final class NavigationController
{
    private let uiController: UINavigationController

    public init(controller: UINavigationController) {
        self.uiController = controller
    }

    public func push(_ vc: UIViewController, animated: Bool = true) {
        if self.uiController.viewControllers.isEmpty {
            self.uiController.setViewControllers([vc], animated: animated)
        } else {
            self.uiController.pushViewController(vc, animated: animated)
        }
    }

    public func pop(animated: Bool = true) {
        self.uiController.popViewController(animated: animated)
    }
}
