//
//  BlogStartPoint.swift
//  Blog
//
//  Created by Alexander Ivlev on 23/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core
import DITranquillity
import SwiftLazy

public final class BlogStartPoint: UIStartPoint {
    public static let name: DeepLink.Name = "blog"

    private var routerProvider = Provider<BlogRouter>()

    public init() {

    }
    
    public func configure() {

    }

    public func reg(container: DIContainer) {
        BlogDependency.load(container: container)
        routerProvider = container.resolve()
    }

    public func isSupportOpen(with parameters: RoutingParamaters) -> Bool {
        return true
    }

    public func makeRouter() -> IRouter {
        return routerProvider.value
    }

}
