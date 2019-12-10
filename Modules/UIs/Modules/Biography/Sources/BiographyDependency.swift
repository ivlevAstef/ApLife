//
//  BiographyDependency.swift
//  Biography
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import DITranquillity

final class BiographyDependency: DIFramework
{
    static func load(container: DIContainer) {
        container.register { BiographyRouter(navigator: arg($0)) }
            .injection(\.biographyScreenProvider)
            .lifetime(.objectGraph)

        container.register(BiographyScreen.init)
            .lifetime(.prototype)
        container.register { BiographyScreenView(nibName: nil, bundle: nil) }
            .as(BiographyScreenViewContract.self)
            .lifetime(.objectGraph)
        container.register(BiographyScreenPresenter.init)
            .lifetime(.objectGraph)
    }
}
