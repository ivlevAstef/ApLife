//
//  StyleComponent.swift
//  Design
//
//  Created by Alexander Ivlev on 14/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Common

public struct StyleComponent: OptionSet
{
    public let rawValue: Int

    public static let colors = StyleComponent(private: 1 << 0)
    public static let fonts = StyleComponent(private: 1 << 1)
    public static let animation = StyleComponent(private: 1 << 2)
    public static let layout = StyleComponent(private: 1 << 3)

    public init(rawValue: Int) {
        log.assert(rawValue == Self.colors.rawValue
            || rawValue == Self.fonts.rawValue
            || rawValue == Self.animation.rawValue
            || rawValue == Self.layout.rawValue
        , "Init StyleComponent with incorrect raw value")
        self.rawValue = rawValue
    }

    private init(private rawValue: Int) {
        self.rawValue = rawValue
    }
}
