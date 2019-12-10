//
//  BiographyStartPoint.swift
//  Biography
//
//  Created by Alexander Ivlev on 23/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core
import DITranquillity
import SwiftLazy

public final class BiographyStartPoint: UIStartPoint
{
    public static let name: UIModuleName = "biography"

    public struct Subscribers {
    }
    public var subscribersFiller: (_ navigator: Navigator, _ subscribers: Subscribers) -> Void = { _, _ in }

    private var routerProvider = Provider1<BiographyRouter, Navigator>()

    public init() {

    }
    
    public func configure() {

    }

    public func reg(container: DIContainer) {
        container.append(framework: BiographyDependency.self)
        routerProvider = container.resolve()
    }

    public func initialize() {

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
