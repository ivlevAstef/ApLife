//
//  AccountScreenPresenter.swift
//  Account
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//


import Common

protocol AccountScreenViewContract
{
}

final class AccountScreenPresenter
{
    private let view: AccountScreenViewContract

    init(view: AccountScreenViewContract) {
        self.view = view
    }
}

