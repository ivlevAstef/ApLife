//
//  ChangeableImage.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 29/09/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import Common

public final class ChangeableImage
{
    public let changeImageNotifier = Notifier<UIImage?>()

    public var image: UIImage? {
        return self.currentImage ?? self.placeholder
    }

    private let placeholder: UIImage?
    private var currentImage: UIImage?

    public init(placeholder: UIImage? = nil, image: UIImage? = nil) {
        self.placeholder = placeholder
        self.currentImage = image
    }

    public func updateImage(image newImage: UIImage?) {
        DispatchQueue.mainSync {
            currentImage = newImage
            changeImageNotifier.notify(image)
        }
    }
}

public extension ChangeableImage
{
    func join(imageView: UIImageView) {
        imageView.image = image
        changeImageNotifier.join({ [weak imageView] image in
            imageView?.image = image
        })
    }
}