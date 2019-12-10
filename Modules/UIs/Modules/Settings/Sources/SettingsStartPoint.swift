//
//  SettingsStartPoint.swift
//  Settings
//
//  Created by Alexander Ivlev on 15/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core
import DITranquillity
import Design
import SwiftLazy

public final class SettingsStartPoint: UIStartPoint
{
    public static let name: UIModuleName = "settings"

    public struct Subscribers {
    }
    public var subscribersFiller: (_ navigator: Navigator, _ subscribers: Subscribers) -> Void = { _, _ in }

    private var routerProvider = Provider1<SettingsRouter, Navigator>()

    public init() {

    }

    public func configure() {
    }

    public func reg(container: DIContainer) {
        container.append(framework: SettingsDependency.self)
        routerProvider = container.resolve()
    }

    public func initialize() {
        // TODO: setup style
    }

    public func isSupportOpen(with parameters: RoutingParamaters) -> Bool {
       return parameters.moduleName == Self.name
   }

    public func makeRouter(use navigator: Navigator) -> IRouter {
        let router = routerProvider.value(navigator)
        subscribersFiller(navigator, Subscribers())

        return router
   }

}
