//
//  Screen.swift
//  Core
//
//  Created by Alexander Ivlev on 28/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Foundation
import UIKit

private /*static*/var associatedForRetainKey: UInt8 = 0

public class Screen<View: UIViewController, Presenter: AnyObject>
{	
    public let view: View
    public let presenter: Presenter

    public init(view: View, presenter: Presenter) {
        self.view = view
        self.presenter = presenter

        // yes it's not good, but optimization all code
        objc_setAssociatedObject(view, &associatedForRetainKey, presenter, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
