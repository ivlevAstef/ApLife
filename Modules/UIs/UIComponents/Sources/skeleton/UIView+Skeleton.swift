//
//  UIView+Skeleton.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 23/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit

extension UIView {
    public var skeletonView: SkeletonView {
        let skeletons = subviews.compactMap { $0 as? SkeletonView}
        if let skeleton = skeletons.last {
            skeletons.forEach { bringSubviewToFront($0) }
            return skeleton
        }

        let skeleton = SkeletonView()
        skeleton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(skeleton)

        NSLayoutConstraint.activate([
            skeleton.topAnchor.constraint(equalTo: topAnchor),
            skeleton.leftAnchor.constraint(equalTo: leftAnchor),
            skeleton.rightAnchor.constraint(equalTo: rightAnchor),
            skeleton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        return skeleton
    }

    public func startSkeleton() {
        if isHidden {
            return
        }

        let skeletonViews = subviews.compactMap { $0 as? SkeletonView }
        UIView.animate(withDuration: 0.15, animations: {
            for subview in skeletonViews {
                subview.start()
            }
        })
    }

    public func endSkeleton() {
        let skeletonViews = subviews.compactMap { $0 as? SkeletonView }
        UIView.animate(withDuration: 0.15, animations: {
            for subview in skeletonViews {
                subview.end()
            }
        })
    }

    public func failedSkeleton() {
        let skeletonViews = subviews.compactMap { $0 as? SkeletonView }
        UIView.animate(withDuration: 0.25, animations: {
            for subview in skeletonViews {
                subview.failed()
            }
        })
    }

    public func endSkeleton(success: Bool) {
        if success {
            endSkeleton()
        } else {
            failedSkeleton()
        }
    }

}
