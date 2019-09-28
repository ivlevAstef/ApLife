//
//  RibbonScreenPresenter.swift
//  Blog
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

protocol RibbonScreenViewContract {

}

final class RibbonScreenPresenter {
    private let view: RibbonScreenViewContract

    init(view: RibbonScreenViewContract) {
        self.view = view
    }
}
