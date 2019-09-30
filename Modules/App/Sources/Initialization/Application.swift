//
//  Application.swift
//  ApLife
//
//  Created by Alexander Ivlev on 22/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Core

// Start point
final class Application
{
    private let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }

    func setWindow(_ window: UIWindow) {
        window.rootViewController = self.router.rootViewController
    }

    func start(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.router.start(parameters: RoutingParamaters())
    }
}
