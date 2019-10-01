//
//  MenuStartPoint.swift
//  Menu
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core
import Common
import DITranquillity
import SwiftLazy

public final class MenuStartPoint: UIStartPoint
{
    public static let name: UIModuleName = .menu

    public let showAccountNotifier = Notifier<Void>()
    public let showBlogNotifier = Notifier<Void>()
    public let showBiographyNotifier = Notifier<Void>()
    public let showSettingsNotifier = Notifier<Void>()

    private var routerProvider = Provider<MenuRouter>()

    public init() {

    }

    public func configure() {

    }

    public func reg(container: DIContainer) {
        container.append(framework: MenuDependency.self)
        routerProvider = container.resolve()
    }

    public func isSupportOpen(with parameters: RoutingParamaters) -> Bool {
        return parameters.moduleName == Self.name
    }

    public func makeRouter() -> IRouter {
        let router = routerProvider.value
        router.showAccountNotifier.join(showAccountNotifier)
        router.showBlogNotifier.join(showBlogNotifier)
        router.showBiographyNotifier.join(showBiographyNotifier)
        router.showSettingsNotifier.join(showSettingsNotifier)

        return router
    }

}
