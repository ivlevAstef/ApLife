//
//  StyleMaker.swift
//  Design
//
//  Created by Alexander Ivlev on 14/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Common
import UIKit

public class StyleMaker
{
    internal init() {
    }

    public func makeStyle(for vc: UIViewController) -> Style {
        let colors: Style.Colors
        switch vc.traitCollection.userInterfaceStyle {
        case .dark:
            colors = ConstColors.darkColors
        case .light:
            colors = ConstColors.lightColors
        default:
            colors = ConstColors.darkColors
        }

        //vc.traitCollection.preferredContentSizeCategory
        let fonts: Style.Fonts
        fonts = ConstsFonts.default

        let animation: Style.Animation = ConstsAnimation.default

        let safeAreaInsets = UIEdgeInsets(
            top: vc.view.safeAreaInsets.top + vc.additionalSafeAreaInsets.top,
            left: vc.view.safeAreaInsets.left + vc.additionalSafeAreaInsets.left,
            bottom: vc.view.safeAreaInsets.bottom + vc.additionalSafeAreaInsets.bottom,
            right: vc.view.safeAreaInsets.right + vc.additionalSafeAreaInsets.right)

        let layout: Style.Layout = Style.Layout(
            safeAreaInsets: safeAreaInsets,
            innerInsets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        )

        return Style(colors: colors, fonts: fonts, animation: animation, layout: layout)
    }
}
