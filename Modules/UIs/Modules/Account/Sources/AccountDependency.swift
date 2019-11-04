//
//  AccountDependency.swift
//  Account
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import DITranquillity

final class AccountDependency: DIFramework
{
    static func load(container: DIContainer) {
        container.register(AccountRouter.init)
            .injection(\.accountScreenProvider)
            .lifetime(.objectGraph)

        container.register(AccountScreen.init)
            .lifetime(.prototype)
        container.register { AccountScreenView() }
            .as(AccountScreenViewContract.self)
            .lifetime(.objectGraph)
        container.register(AccountScreenPresenter.init)
            .lifetime(.objectGraph)
    }
}
