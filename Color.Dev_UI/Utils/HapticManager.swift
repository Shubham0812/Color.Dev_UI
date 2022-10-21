//
//  HapticManager.swift
//  Color.Dev_UI
//
//  Created by Marshall  on 10/20/22.
//

import CoreHaptics

class HapticManager {
    
    static let shared = HapticManager()
    
    private let hapticEngine: CHHapticEngine
    
    init?() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        guard hapticCapability.supportsHaptics else {
            return nil
        }
        
        do {
            hapticEngine = try CHHapticEngine()
        } catch let error {
            print("Haptic engine error: \(error)")
            return nil
        }
    }
    
    func playHaptic(type: Feedback) {
        do {
            let pattern = try notification(type: type)
            try hapticEngine.start()
            let player = try hapticEngine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
            hapticEngine.notifyWhenPlayersFinished { _ in
                return .stopEngine
            }
        } catch {
            print("Failed to play haptic: \(error)")
        }
        
        hapticEngine.isAutoShutdownEnabled = true
    }
    
    private func notification(type: Feedback) throws -> CHHapticPattern {
        return try CHHapticPattern(events: type.event, parameters: [])
    }
    
    enum Feedback {
        case heavy
        case light
        case medium
        case rigid
        case error
        case success
        case warning
        case custom(intensity: Float, sharpness: Float, duration: Double)
        
        var event: [CHHapticEvent] {
            switch self {
            case .heavy:
                return [event(eventType: .hapticContinuous, intensity: 1.0, sharpness: 0.1, duration: 0.01)]
            case .light:
                return [event(eventType: .hapticTransient, intensity: 0.2, sharpness: 0.1, duration: 0.1)]
            case .medium:
                return [event(eventType: .hapticTransient, intensity: 0.7, sharpness: 0.5, duration: 0.01)]
            case .rigid:
                return [event(eventType: .hapticTransient, intensity: 0.9, sharpness: 1.0, duration: 0.1)]
            case .error:
                return [event(eventType: .hapticContinuous, intensity: 0.5, sharpness: 0.3, duration: 0.3)]
            case .success:
                return [
                    event(eventType: .hapticTransient, intensity: 1.0, sharpness: 1.0, duration: 0.1, relativeTime: 0.2),
                    event(eventType: .hapticTransient, intensity: 1.0, sharpness: 1.0, duration: 0.2)
                ]
            case .warning:
                return [event(eventType: .hapticContinuous, intensity: 1.0, sharpness: 0.1, duration: 0.5)]
                    case .custom(let intensity, let sharpness, let duration):
                      return [event(intensity: intensity, sharpness: sharpness, duration: duration)]
            }
        }
        
        private func event(eventType: CHHapticEvent.EventType = .hapticContinuous, intensity: Float, sharpness: Float, duration: Double, relativeTime: TimeInterval = 0) -> CHHapticEvent {
            return CHHapticEvent(
                eventType: eventType,
                parameters:
                    [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
                    ],
                relativeTime: relativeTime,
                duration: duration)
        }
    }
}
