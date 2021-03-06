//
//  SettingsDependency.swift
//  Settings
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import DITranquillity

final class SettingsDependency: DIFramework
{
    static func load(container: DIContainer) {
        container.register { SettingsRouter(navigator: arg($0)) }
            .injection(\.settingsScreenProvider)
            .lifetime(.objectGraph)

        container.register(SettingsScreen.init)
            .lifetime(.prototype)
        container.register { SettingsScreenView() }
            .as(SettingsScreenViewContract.self)
            .lifetime(.objectGraph)
        container.register(SettingsScreenPresenter.init)
            .lifetime(.objectGraph)
    }
}
