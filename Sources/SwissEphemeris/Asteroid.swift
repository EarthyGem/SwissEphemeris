//
//  Asteroid.swift
//  
//
//  Created by Vincent Smithers on 13.02.21.
//

import Foundation

/// Models select Asteroids available in the IPL.
public enum Asteroid: Int32 {
	case chiron = 15
	case pholus
	case ceres
	case pallas
	case juno
	case vesta

    public var formatted: String {
        switch self {
        case .chiron, .ceres, .pallas, .juno, .vesta:
            return "\(keyName) \(symbol)"
        case .pholus:
            return "\(keyName)"
        }
    }

    public var symbol: String {
        switch self {
        case .chiron:
            return "⚷"
        case .pholus:
            return ""
        case .ceres:
            return "⚳"
        case .pallas:
            return "⚴"
        case .juno:
            return "⚵"
        case .vesta:
            return "⚶"
        }
    }

    public var keyName: String {
        switch self {
        case .chiron:
            return "Chiron"
        case .pholus:
            return "Pholus"
        case .ceres:
            return "Ceres"
        case .pallas:
            return "Pallas"
        case .juno:
            return "Juno"
        case .vesta:
            return "Vesta"
        }
    }
}

// MARK: - CelestialBody Conformance

extension Asteroid: CelestialBody {
	public var value: Int32 {
		rawValue
	}

    public var celestialObject: CelestialObject {
        return .asteroid(self)
    }
}
