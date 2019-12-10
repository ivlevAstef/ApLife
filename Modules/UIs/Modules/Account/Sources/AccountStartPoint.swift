//
//  AccountStartPoint.swift
//  Account
//
//  Created by Alexander Ivlev on 15/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core
import DITranquillity
import Design
import SwiftLazy

public final class AccountStartPoint: UIStartPoint
{
    public static let name: UIModuleName = "account"

    public struct Subscribers {
    }
    public var subscribersFiller: (_ navigator: Navigator, _ subscribers: Subscribers) -> Void = { _, _ in }

    private var routerProvider = Provider1<AccountRouter, Navigator>()

    public init() {

    }

    public func configure() {
    }

    public func reg(container: DIContainer) {
        container.append(framework: AccountDependency.self)
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
