//
//  MenuCell.swift
//  Menu
//
//  Created by Alexander Ivlev on 27/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import UIComponents
import Design
import Common

private enum Consts {
    static let newsHeight: CGFloat = 320.0
    static let favoritesHeight: CGFloat = 256.0
    static let biographyHeight: CGFloat = 224.0
    static let settingsHeight: CGFloat = 202.0

    static let frontHeight: CGFloat = 80.0
    static let titleHeight: CGFloat = 40.0
    static let subTitleHeight: CGFloat = 20.0
}

class MenuCell: UITableViewCell {
    static let identifier = "\(MenuCell.self)"

    private let background = CellView()
    private let front = UIVisualEffectView(frame: .zero)
    private let title = UILabel(frame: .zero)
    private let subtitle = UILabel(frame: .zero)

    private var heightConstraint: NSLayoutConstraint?
    private var backgroundEdgesConstraint: [NSLayoutConstraint] = []
    private var viewModel: MenuViewModel?

    private let longTapFeedback = AppHapticFeedback.preview()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ viewModel: MenuViewModel) {
        self.viewModel = viewModel

        heightConstraint?.constant = preferredHeight(for: viewModel)
        setNeedsUpdateConstraints()

        title.text = viewModel.title
        subtitle.text = viewModel.subtitle
    }

    @objc
    private func tapOnCell() {
        viewModel?.show.notify(())
    }

    @objc
    private func longTapOnCell(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            longTapFeedback.noise()
        case .ended:
            viewModel?.preview.notify(())
        default:
            break
        }
    }

    private func preferredHeight(for viewModel: MenuViewModel) -> CGFloat {
        switch viewModel.style {
        case .news:
            return Consts.newsHeight
        case .favorites:
            return Consts.favoritesHeight
        case .biography:
            return Consts.biographyHeight
        case .settings:
            return Consts.settingsHeight
        }
    }

    private func initialize() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnCell))
        tapGesture.delegate = self
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTapOnCell(_:)))
        longTapGesture.delegate = self

        tapGesture.require(toFail: longTapGesture)

        contentView.addGestureRecognizer(tapGesture)
        contentView.addGestureRecognizer(longTapGesture)

        background.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(background)

        front.translatesAutoresizingMaskIntoConstraints = false
        background.contentView.addSubview(front)
        title.translatesAutoresizingMaskIntoConstraints = false
        front.contentView.addSubview(title)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        front.contentView.addSubview(subtitle)

        title.numberOfLines = 1
        subtitle.numberOfLines = 1

        heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 256.0)
        heightConstraint?.isActive = true

        let backgroundConstraints = [
            background.topAnchor.constraint(equalTo: contentView.topAnchor),
            background.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            background.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(backgroundConstraints)
        backgroundEdgesConstraint = backgroundConstraints

        NSLayoutConstraint.activate([
            front.contentView.bottomAnchor.constraint(equalTo: background.contentView.bottomAnchor),
            front.contentView.leftAnchor.constraint(equalTo: background.contentView.leftAnchor),
            front.contentView.rightAnchor.constraint(equalTo: background.contentView.rightAnchor),

            title.topAnchor.constraint(equalTo: front.contentView.topAnchor, constant: 4.0),
            title.leftAnchor.constraint(equalTo: front.contentView.leftAnchor, constant: 16.0),
            title.rightAnchor.constraint(equalTo: front.contentView.rightAnchor, constant: -16.0),

            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: 2.0),

            subtitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: title.rightAnchor),
            subtitle.bottomAnchor.constraint(equalTo: front.contentView.bottomAnchor, constant: -8.0)
        ])
    }
}

extension MenuCell {
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension MenuCell: StylizingView {
    func apply(use style: Style) {
        switch viewModel?.style {
        case .news:
            background.apply(use: style, for: .news)
        case .favorites:
            background.apply(use: style, for: .favorites)
        case .biography:
            background.apply(use: style, for: .biography)
        case .settings:
            background.apply(use: style, for: .settings)
        case .none:
            log.assert("Your don't setup view model...")
        }

        front.effect = UIBlurEffect(style: style.colors.frontStyle)

        title.font = style.fonts.large
        title.textColor = style.colors.mainText

        subtitle.font = style.fonts.subtitle
        subtitle.textColor = style.colors.notAccentText

        log.assert(backgroundEdgesConstraint.count == 4, "Not initialized background edges constrains - hmm...")

        backgroundEdgesConstraint[0].constant = style.layout.cellInnerInsets.top
        backgroundEdgesConstraint[1].constant = style.layout.cellInnerInsets.left
        backgroundEdgesConstraint[2].constant = -style.layout.cellInnerInsets.right
        backgroundEdgesConstraint[3].constant = -style.layout.cellInnerInsets.bottom

        setNeedsUpdateConstraints()
        setNeedsLayout()
    }
}
