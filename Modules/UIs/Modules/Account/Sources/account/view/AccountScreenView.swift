//
//  AccountScreenView.swift
//  Account
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Common

final class AccountScreenView: UIViewController, AccountScreenViewContract
{

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "LaunchScreen22", bundle: nil)
        let bColor = storyboard.instantiateInitialViewController()?.view.backgroundColor

        //view.backgroundColor = .yellow
        view.backgroundColor = bColor
    }
}
