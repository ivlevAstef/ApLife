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

public final class BlogStartPoint: UIStartPoint
{
    public static let name: UIModuleName = .blog

    private var routerProvider = Provider<BlogRouter>()

    public init() {

    }
    
    public func configure() {

    }

    public func reg(container: DIContainer) {
        container.append(framework: BlogDependency.self)
        routerProvider = container.resolve()
    }

    public func isSupportOpen(with parameters: RoutingParamaters) -> Bool {
        return parameters.moduleName == Self.name
    }

    public func makeRouter() -> IRouter {
        return routerProvider.value
    }

}
