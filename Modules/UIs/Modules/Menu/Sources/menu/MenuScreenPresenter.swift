//
//  MenuScreenPresenter.swift
//  Menu
//
//  Created by Alexander Ivlev on 30/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Common

protocol MenuScreenViewContract
{
}

final class MenuScreenPresenter
{
    private let view: MenuScreenViewContract

    init(view: MenuScreenViewContract) {
        self.view = view
    }

    private func subscribeOn(_ view: MenuScreenViewContract) {

    }
}
