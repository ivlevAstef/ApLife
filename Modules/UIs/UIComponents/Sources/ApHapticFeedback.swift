//
//  ApHapticFeedback.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 03/11/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//

import UIKit
import CoreHaptics

public enum ApFeedbackGenerator {
    case impact(UIImpactFeedbackGenerator, intensity: CGFloat)
    case notification(UINotificationFeedbackGenerator, type: UINotificationFeedbackGenerator.FeedbackType)
    case selection(UISelectionFeedbackGenerator)
}

public class AppHapticFeedback {
    private let hapticEngine: CHHapticEngine?
    private let feedback: ApFeedbackGenerator

    public static func test() {
    }

    public static func preview() -> AppHapticFeedback {
        // TODO: need use CoreHaptic for improve
        return AppHapticFeedback(hapticEngine: nil,
                                 feedback: .impact(UIImpactFeedbackGenerator(style: .heavy), intensity: 1.0))
    }

    public func noise() {
        guard let hapticEngine = hapticEngine else {
            feebackNoise()
            return
        }
        do {
            try hapticEngine.start()
        } catch {
            feebackNoise()
        }
    }

    public init(hapticEngine: CHHapticEngine?, feedback: ApFeedbackGenerator) {
        self.hapticEngine = hapticEngine
        self.feedback = feedback
    }

    private func feebackNoise() {
        switch feedback {
        case let .impact(generator, intensity):
            generator.impactOccurred(intensity: intensity)
        case let .notification(generator, type):
            generator.notificationOccurred(type)
        case let .selection(generator):
            generator.selectionChanged()
        }
    }
}
