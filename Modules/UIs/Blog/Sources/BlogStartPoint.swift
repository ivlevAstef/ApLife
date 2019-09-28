//
//  BlogStartPoint.swift
//  Blog
//
//  Created by Alexander Ivlev on 23/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Core
import DITranquillity

public final class BlogStartPoint: UIStartPoint {
    public static let name: DeepLink.Name = "blog"

    public init() {

    }
    
    public func configure() {

    }

    public func reg(container: DIContainer) {

    }

    public func isSupportOpen(with parameters: RoutingParamaters) -> Bool {
        return true
    }

    public func makeRouter() -> IRouter {
        return BlogRouter()
    }

}
