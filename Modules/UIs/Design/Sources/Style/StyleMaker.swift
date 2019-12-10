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
    public init() {
    }

    public func makeStyle(for vc: UIViewController, traitCollection: UITraitCollection? = nil, size: CGSize? = nil) -> Style {
        let traitCollection = traitCollection ?? vc.traitCollection
        let windowScene = vc.view.window?.windowScene ?? vc.navigationController?.view.window?.windowScene
        let size = size ?? vc.view.frame.size

        let colors = makeColors(traitCollection: traitCollection)
        let fonts = makeFonts(traitCollection: traitCollection)
        let animation: Style.Animation = ConstsAnimation.default
        let layout = makeLayout(vc: vc, traitCollection: traitCollection, windowScene: windowScene, size: size)

        return Style(colors: colors, fonts: fonts, animation: animation, layout: layout)
    }

    private func makeColors(traitCollection: UITraitCollection) -> Style.Colors {
       switch traitCollection.userInterfaceStyle {
       case .dark:
           return ConstColors.darkColors
       case .light:
           return ConstColors.lightColors
       default:
           return ConstColors.darkColors
       }
   }

   private func makeFonts(traitCollection: UITraitCollection) -> Style.Fonts {
       //traitCollection.preferredContentSizeCategory
       return ConstsFonts.default
   }

   private func makeLayout(vc: UIViewController,
                           traitCollection: UITraitCollection,
                           windowScene: UIWindowScene?,
                           size: CGSize) -> Style.Layout {

        let safeAreaInsets: UIEdgeInsets
        if #available(iOS 11.0, *) {
            safeAreaInsets = UIEdgeInsets(
                top: vc.view.safeAreaInsets.top + vc.additionalSafeAreaInsets.top,
                left: vc.view.safeAreaInsets.left + vc.additionalSafeAreaInsets.left,
                bottom: vc.view.safeAreaInsets.bottom + vc.additionalSafeAreaInsets.bottom,
                right: vc.view.safeAreaInsets.right + vc.additionalSafeAreaInsets.right
            )
        } else {
            safeAreaInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        }

        let canUseLarge: Bool
        if #available(iOS 13.0, *) {
            canUseLarge = !(windowScene?.interfaceOrientation.isLandscape ?? false)
        } else {
            canUseLarge = !UIApplication.shared.statusBarOrientation.isLandscape
        }

        let statusBarHeight: CGFloat
        if #available(iOS 13.0, *) {
            statusBarHeight = windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }

        return Style.Layout(
            safeAreaInsets: safeAreaInsets,
            innerInsets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0),
            cellInnerInsets: UIEdgeInsets(top: 12.0, left: 16.0, bottom: 20.0, right: 16.0),
            statusBarHeight: statusBarHeight,
            navigationBarDefaultHeight: 44.0,
            navigationBarLargeHeight: canUseLarge ? 96.0 : 0.0,
            cellShadowRadius: 10.0,
            cellShadowOffset: CGSize(width: 0, height: 10.0)
       )
   }
}
