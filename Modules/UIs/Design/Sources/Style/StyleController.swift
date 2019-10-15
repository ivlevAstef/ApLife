//
//  StyleController.swift
//  Design
//
//  Created by Alexander Ivlev on 14/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import Common

public protocol StyleChangesObserver: class {
    func styleDidChanged(on style: Style, in components: StyleComponent)
}

public class StyleController
{
    public private(set) var style: Style {
        get {
            guard let style = _style else {
                log.fatal("Please set style from your app use `initialize` method")
            }
            return style
        }
        set {
            _style = newValue
        }
    }

    private var _style: Style!

    private var observers = WeakArray<StyleChangesObserver>()

    public init() {
    }

    public func initialize(style: Style) {
        log.assert(_style == nil, "call initialize once")
        self.style = style
    }

    public func subscribe(_ observer: StyleChangesObserver) {
        observers.append(observer)
    }

    public func unsubscribe(_ observer: StyleChangesObserver) {
        observers.remove(observer)
    }

    public func update(colors: Style.Colors? = nil,
                       fonts: Style.Fonts? = nil,
                       animation: Style.Animation? = nil,
                       layout: Style.Layout? = nil) {
        var components: StyleComponent = []
        if let colors = colors {
            style.colors = colors
            components.insert(.colors)
        }
        if let fonts = fonts {
            style.fonts = fonts
            components.insert(.fonts)
        }
        if let animation = animation {
            style.animation = animation
            components.insert(.animation)
        }
        if let layout = layout {
            style.layout = layout
            components.insert(.layout)
        }

        notifyAboutChangeStyle(in: components)
    }

    private func notifyAboutChangeStyle(in changedComponents: StyleComponent) {
        let style = self.style
        for observer in observers {
            observer.styleDidChanged(on: style, in: changedComponents)
        }
    }
}
