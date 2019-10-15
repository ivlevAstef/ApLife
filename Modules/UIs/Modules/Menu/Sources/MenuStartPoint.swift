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

    public let accountGetter = Getter<Void, IRouter>()
    public let blogGetter = Getter<Void, IRouter>()
    public let favoritesGetter = Getter<Void, IRouter>()
    public let biographyGetter = Getter<Void, IRouter>()
    public let settingsGetter = Getter<Void, IRouter>()

    private var routerProvider = Provider<MenuRouter>()

    public init() {

    }

    public func configure() {

    }

    public func reg(container: DIContainer) {
        container.append(framework: MenuDependency.self)
        routerProvider = container.resolve()
    }

    public func initialize() {

    }

    public func isSupportOpen(with parameters: RoutingParamaters) -> Bool {
        return parameters.moduleName == Self.name
    }

    public func makeRouter() -> IRouter {
        let router = routerProvider.value
        router.accountGetter.take(from: accountGetter)
        router.blogGetter.take(from: blogGetter)
        router.favoritesGetter.take(from: favoritesGetter)
        router.biographyGetter.take(from: biographyGetter)
        router.settingsGetter.take(from: settingsGetter)

        return router
    }

}
