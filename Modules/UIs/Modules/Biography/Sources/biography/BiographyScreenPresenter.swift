//
//  BiographyScreenPresenter.swift
//  Biography
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Common

protocol BiographyScreenViewContract
{
}

final class BiographyScreenPresenter
{
    private let view: BiographyScreenViewContract

    init(view: BiographyScreenViewContract) {
        self.view = view
    }

    private func subscribeOn(_ view: BiographyScreenViewContract) {

    }
}
