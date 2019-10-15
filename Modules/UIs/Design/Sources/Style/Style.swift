//
//  Style.swift
//  Design
//
//  Created by Alexander Ivlev on 14/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

/// Style - it's collection of properties with colors, fonts, layouts and animation settings
public struct Style
{
    public struct Colors {
        /// background.
        public internal(set) var background: UIColor
        /// used for cell background or accent views on background
        public internal(set) var accent: UIColor
        /// used for navigation bar buttons, or other small elements. for example icons
        public internal(set) var tint: UIColor
    }

    public struct Fonts {
        public internal(set) var title: UIFont
        public internal(set) var subtitle: UIFont
        public internal(set) var text: UIFont
    }

    public struct Animation {
        public internal(set) var transitionTime: TimeInterval
    }

    public struct Layout {
        public internal(set) var safeArea: CGRect
    }

    public internal(set) var colors: Colors
    public internal(set) var fonts: Fonts
    public internal(set) var animation: Animation
    public internal(set) var layout: Layout

    public init(colors: Colors, fonts: Fonts, animation: Animation, layout: Layout) {
        self.colors = colors
        self.fonts = fonts
        self.animation = animation
        self.layout = layout
    }
}
