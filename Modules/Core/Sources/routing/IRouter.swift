//
//  IRouter.swift
//  Services
//
//  Created by Alexander Ivlev on 22/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

public protocol IRouter {
    var name: DeepLink.Name { get }
    
    var rootViewController: UIViewController { get }
    
    func start(parameters: RoutingParamaters)
}
