//
//  CellView.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 27/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//


import UIKit
import Design
import Common

public class CellView: UIView {
    public var contentView: UIView {
        get { return gradientView }
    }

    public var gradient: Gradient? {
        set { gradientView.gradient = newValue }
        get { return gradientView.gradient }
    }

    public var cornerRadius: CGFloat = 48.0 {
        didSet { updateCornerRadius() }
    }

    private let gradientView: GradientView = GradientView(frame: .zero)

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        gradientView.frame = bounds
    }

    private func initialize() {
        addSubview(gradientView)

        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)

        gradientView.clipsToBounds = true
        clipsToBounds = false
    }

    private func updateCornerRadius() {
        gradientView.layer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
    }
}

extension CellView {
    public func apply(use style: Style, for type: Style.Colors.GradientCellType) {
        cornerRadius = min(style.layout.innerInsets.top, style.layout.innerInsets.left)
        gradient = style.colors.cells[type]

        layer.shadowColor = style.colors.cellShadowColor?.cgColor
        layer.shadowOpacity = style.colors.cellShadowOpacity
        layer.shadowRadius = style.layout.cellShadowRadius
        layer.shadowOffset = style.layout.cellShadowOffset
    }
}
