//
//  NavigationAvatarView.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 28/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Design

private enum Consts {
    static let size: CGFloat = 40.0
}

public class NavigationAvatarView: UIView, INavigationBarItemView {
    public let width: CGFloat = Consts.size

    private let avatarView = AvatarView(size: Consts.size)

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: Consts.size, height: Consts.size))
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setup(letter: String) {
        avatarView.setup(letter: letter)
    }

    public func setup(_ image: UIImage?) {
        avatarView.setup(image)
    }

    public func setup(_ image: ChangeableImage) {
        avatarView.setup(image)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        avatarView.size = min(frame.width, frame.height)
        avatarView.frame.origin = CGPoint(x: 0, y: (frame.height - avatarView.size) * 0.5)

        avatarView.setNeedsLayout()
    }

    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarView)
    }
}

extension NavigationAvatarView: StylizingView
{
    public func apply(use style: Style) {
        avatarView.apply(use: style)
    }
}
