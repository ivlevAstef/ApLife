//
//  CoreStartPoint.swift
//  Core
//
//  Created by Alexander Ivlev on 01/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//


import UIKit
import DITranquillity

public final class CoreStartPoint: CommonStartPoint
{
    public init() {

    }

    public func configure() {

    }

    public func reg(container: DIContainer) {
        container.register {
            NavigationController(controller: UINavigationController(nibName: nil, bundle: nil))
        }.lifetime(.perContainer(.weak))
    }
}

