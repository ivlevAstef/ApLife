//
//  MenuStartPoint.swift
//  Menu
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core
import SwiftLazy
import DITranquillity

public final class MenuStartPoint: UIStartPoint {
    public static let name: DeepLink.Name = "menu"

    public var blogRouterProvider: Lazy<IRouter>?
    public var accountRouterProvider: Lazy<IRouter>?
    public var settingsRouterProvider: Lazy<IRouter>?

    public init() {

    }

    public func configure() {

    }

    public func reg(container: DIContainer) {

    }

    public func isSupportOpen(with parameters: RoutingParamaters) -> Bool {
        return false
    }

    public func makeRouter() -> IRouter {
        let router = MenuRouter()
        router.routerProviders = [
            .blog: blogRouterProvider,
            .account: accountRouterProvider,
            .settings: settingsRouterProvider
        ].compactMapValues { $0 }

        return router
    }

}
