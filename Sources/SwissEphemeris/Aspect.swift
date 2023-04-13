//
//  Aspect.swift
//  
//
//  29.08.20.
//

import Foundation


public enum Kind: Codable, CaseIterable {
    /// A 0° alignment.
    case conjunction
    /// A 30° alignment.
    case semisextile
    /// A 45° alignment.
    case semisquare
    /// A 60° alignment.
    case sextile
    /// A 90° alignment.
    case square
    /// A 120° alignment.
    case trine
    /// A 135° alignment.
    case sesquisquare
    /// A 150° alignment.
    case inconjunction
    /// An 180° alignment.
    case opposition
    /// A parallel alignment.
    case parallel
}

public struct CelestialAspect: Codable, Equatable, Hashable {
    public let kind: Kind
    public let body1: Coordinate
    public let body2: Coordinate
    public let angle: Double

    public var orbDelta: Double {
        switch kind {
        case .conjunction:
            return angle
        case .semisextile:
            return preciseRound(angle - 30.0, precision: .thousandths)
        case .semisquare:
            return preciseRound(angle - 45.0, precision: .thousandths)
        case .sextile:
            return preciseRound(angle - 60.0, precision: .thousandths)
        case .square:
            return preciseRound(angle - 90.0, precision: .thousandths)
        case .trine:
            return preciseRound(angle - 120.0, precision: .thousandths)
        case .sesquisquare:
            return preciseRound(angle - 135.0, precision: .thousandths)
        case .inconjunction:
            return preciseRound(angle - 150.0, precision: .thousandths)
        case .opposition:
            return preciseRound(angle - 180.0, precision: .thousandths)
       case .parallel:
            return abs(body1.declination - body2.declination)
        }
    }


    public var aspectString: String {
        return "\(body1.body) \(kind) \(body2.body) with orb: \(orbDelta)"
    }

    public init?(body1: CelestialObject, body2: CelestialObject, date: Date, orb: Double) {
        let TBody1 = Coordinate(body: body1, date: date)
        let TBody2 = Coordinate(body: body2, date: date)
        self.init(body1: TBody1, body2: TBody2, orb: orb)
    }

  public init?(body1: Coordinate, body2: Coordinate, orb: Double) {
    let longitudeDelta = abs(body1.longitude - body2.longitude)
    let declinationDelta = abs(body1.declination - body2.declination)

    if let a = Aspect(a: body1.longitude, b: body2.longitude) {
        self.body1 = body1
        self.body2 = body2

        switch a {
        case .conjunction(_):
            self.angle = 0.0 + a.remainder
            self.kind = .conjunction
        case .semisextile(_):
            self.angle = 30.0 + a.remainder
            self.kind = .semisextile
        case .semisquare(_):
            self.angle = 45.0 + a.remainder
            self.kind = .semisquare
        case .sextile(_):
            self.angle = 60.0 + a.remainder
            self.kind = .sextile
        case .square(_):
            self.angle = 90.0 + a.remainder
            self.kind = .square
        case .trine(_):
            self.angle = 120.0 + a.remainder
            self.kind = .trine
        case .sesquisquare(_):
            self.angle = 135.0 + a.remainder
            self.kind = .sesquisquare
        case .inconjunction(_):
            self.angle = 150.0 + a.remainder
            self.kind = .inconjunction
        case .opposition(_):
            self.angle = 180.0 + a.remainder
            self.kind = .opposition
        case .parallel(_):
            fatalError("Unexpected value for Aspect: parallel aspect should be caught earlier.")
        }

        return
    }

    let isParallel = declinationDelta <= orb && (body1.declination >= 0) == (body2.declination >= 0)
    let isContraParallel = declinationDelta <= orb && (body1.declination >= 0) != (body2.declination >= 0)

    if isParallel || isContraParallel {
        self.body1 = body1
        self.body2 = body2
        self.kind = .parallel
        self.angle = 0.0
        return
    }

    return nil
}

    public func shortDebug() -> String {
        let body1Name = String(describing: body1.body.formatted)
        let body2Name = String(describing: body2.body.formatted)
        let aspect = String("\(kind)")
        let body1TimeStamp = body1.date.toString(format: .cocoaDateTime)!
        let body2TimeStamp = body2.date.toString(format: .cocoaDateTime)!
        return "\(body1Name) makes \(aspect) with \(body2Name)"
    }

    public static func ==(lhs: CelestialAspect, rhs: CelestialAspect) -> Bool {
        let test1 = (lhs.body1 == rhs.body1 &&
                     lhs.body2 == rhs.body2 &&
                     lhs.kind == rhs.kind &&
                     lhs.angle == rhs.angle)
        let test2 = (lhs.body1.formatted == rhs.body2.formatted &&
                     lhs.kind == rhs.kind &&
                     lhs.angle == rhs.angle)
        let test3 = (lhs.body2.formatted == lhs.body1.formatted &&
                     lhs.kind == rhs.kind &&
                     lhs.angle == rhs.angle)
        return test1 || test2 || test3
    }

   
 public func hash(into hasher: inout Hasher) {
    hasher.combine(body1.date)
    hasher.combine(body1.latitude)
    hasher.combine(body1.longitude)
    hasher.combine(body1.declination)
    hasher.combine(body1.value)
    hasher.combine(body2.date)
    hasher.combine(body2.latitude)
    hasher.combine(body2.longitude)
    hasher.combine(body2.declination)
    hasher.combine(body2.value)
    hasher.combine(angle)
}
    }


public struct CuspAspect: Codable, Equatable, Hashable {

    public let kind: Kind
    public let body: Coordinate
    public let cusp: Cusp
    public let angle: Double

    public var orbDelta: Double {
        switch kind {
         case .conjunction:
            return angle
 	case .semisextile:
            return preciseRound(angle - 30.0, precision: .thousandths)
	case .semisquare:
            return preciseRound(angle - 45.0, precision: .thousandths)
        case .sextile:
            return preciseRound(angle - 60.0, precision: .thousandths)
	case .square:
            return preciseRound(angle - 90.0, precision: .thousandths)
        case .trine:
            return preciseRound(angle - 120.0, precision: .thousandths)
 	case . sesquisquare:
            return preciseRound(angle - 135.0, precision: .thousandths)
 	case . inconjunction:
            return preciseRound(angle - 150.0, precision: .thousandths)
        case .opposition:
            return preciseRound(angle - 180.0, precision: .thousandths)
        case .parallel:
            return body.declination - cusp.value
        }
    }


    public var aspectString: String {
        return "\(body.body) \(kind) \(cusp.name) with orb: \(orbDelta)"
    }

    public init?(body: Coordinate, cusp: Cusp, orb: Double) {
        if let a = Aspect(body: body, cusp: cusp) {
            self.body = body
            self.cusp = cusp

                       switch a {
            case .conjunction(_):
                self.angle = 0.0 + a.remainder
                self.kind = .conjunction
	    case .semisextile(_):
                self.angle = 30.0 + a.remainder
                self.kind = .semisextile
           case .semisquare(_):
                self.angle = 45.0 + a.remainder
                self.kind = .semisquare
            case .sextile(_):
                self.angle = 60.0 + a.remainder
                self.kind = .sextile
            case .square(_):
                self.angle = 90.0 + a.remainder
                self.kind = .square
            case .trine(_):
                self.angle = 120.0 + a.remainder
                self.kind = .trine
	    case . sesquisquare(_):
                self.angle = 135.0 + a.remainder
                self.kind = . sesquisquare
            case . inconjunction(_):
                self.angle = 150.0 + a.remainder
                self.kind = .inconjunction
            case .opposition(_):
                self.angle = 180.0 + a.remainder
                self.kind = .opposition
            case .parallel(_):
                self.angle = 0.0 + a.remainder
                self.kind = .parallel
            }

            return
        }

        return nil
    }

    public static func ==(lhs: CuspAspect, rhs: CuspAspect) -> Bool {
        let test1 = (lhs.body == rhs.body &&
                     lhs.cusp == rhs.cusp &&
                     lhs.kind == rhs.kind &&
                     lhs.angle == rhs.angle)
        let test2 = (lhs.body.formatted == rhs.body.formatted &&
                     lhs.kind == rhs.kind &&
                     lhs.angle == rhs.angle)
        let test3 = (lhs.cusp.name == lhs.cusp.name &&
                     lhs.cusp.value == rhs.cusp.value &&
                     lhs.kind == rhs.kind &&
                     lhs.angle == rhs.angle)
        return test1 || test2 || test3
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(body.date)
        hasher.combine(body.latitude)
        hasher.combine(body.longitude)
        hasher.combine(body.declination)
        hasher.combine(cusp.name)
        hasher.combine(cusp.value)
        hasher.combine(angle)
    }
}

/// Models a geometric aspect between two bodies.
public enum Aspect: Equatable, Hashable, Codable {

    // Possible name of struct:
    // InterestingInterBodyAngle
    //      - Angle
    //      - Planet 1
    //      - Planet 2

	/// A 0° alignment.
   	/// A 0° alignment.
    case conjunction(Double)
	/// A 30° alignment.
    case semisextile(Double)
	/// A 45° alignment.
    case semisquare(Double)
	/// A 60° alignment.
    case sextile(Double)
	/// A 90° alignment.
    case square(Double)
	/// A 120° alignment.
    case trine(Double)
	/// A 135° alignment.
    case sesquisquare(Double)
	/// A 150° alignment.
    case inconjunction(Double)
	/// An 180° alignment.
    case opposition(Double)
	///  0° declination.
    case parallel(Double)

	/// Creates an optional `Aspect`. If there is no aspect within the orb, then this initializer will return `nil`.
	/// - Parameters:
	///   - pair: The two bodies to compare.
	///   - date: The date of the alignment.
	///   - orb: The number of degrees allowed for the aspect to differ from exactness.
    public init?(pair: (a: CelestialObject, b: CelestialObject), date: Date) {
    let degreeA = Coordinate(body: pair.a, date: date)
    let degreeB = Coordinate(body: pair.b, date: date)

    self.init(a: degreeA.value, b: degreeB.value)
}

public init?(bodyA: Coordinate, bodyB: Coordinate) {
    self.init(a: bodyA.longitude, b: bodyB.longitude)
}
	/// Creates an optional `Aspect` between two degrees. If there is no aspect within the orb, then this initializer will return `nil`.
	/// - Parameters:
	///   - a: The first degree in the pair.
	///   - b: The second degree in the pair.
	///   - orb: The number of degrees allowed for the aspect to differ from exactness.
	public init?(a: Double, b: Double) {
    let aspectValue = abs(b - a) >= 180 ? abs(abs(b - a) - 360) : abs(b - a)

    switch aspectValue {
    case (0 - 15)...(0 + 15):
        self = .conjunction(round(aspectValue * 100) / 100)
    case (30 - 4)...(30 + 4):
        self = .semisextile(round((aspectValue - 30) * 100) / 100)
    case (45 - 6)...(45 + 6):
        self = .semisquare(round((aspectValue - 45) * 100) / 100)
    case (60 - 8)...(60 + 8):
        self = .sextile(round((aspectValue - 60) * 100) / 100)
    case (90 - 12)...(90 + 12):
        self = .square(round((aspectValue - 90) * 100) / 100)
    case (120 - 12)...(120 + 12):
        self = .trine(round((aspectValue - 120) * 100) / 100)
    case (135 - 6)...(135 + 6):
        self = .sesquisquare(round((aspectValue - 135) * 100) / 100)
    case (150 - 4)...(150 + 4):
        self = .inconjunction(round((aspectValue - 150) * 100) / 100)
    case (180 - 15)...(180 + 15):
        self = .opposition(round((aspectValue - 180) * 100) / 100)
    case (0 - 1)...(0 + 1):
        self = .parallel(round(aspectValue * 100) / 100)
    default:
        return nil
    }
}


    /// Creates an optional `Aspect` between two Coordinates. Useful for generalizng between different aspect configurations (usually between a Transiting Body and a Natal Body). If there is no aspect within the orb, then this initializer will return `nil`.
    /// - Parameters:
    ///   - bodyA: The first body of the aspect.
    ///   - bodyB: The second body of the aspect
    ///   - orb: The number of degrees allowed for the aspect to differ from exactness.
    public init?(bodyA: Coordinate, bodyB: Coordinate, orb: Double = 10.0) {
        self.init(a: bodyA.longitude, b: bodyB.longitude)
    }

    /// Creates an optional `Aspect` between a Coordinate and a Cusp. If there is no aspect within the orb, then this initializer will return `nil`.
    /// - Parameters:
    ///   - body: The body of the aspect.
    ///   - cusp: The cusp of the aspect
    ///   - orb: The number of degrees allowed for the aspect to differ from exactness.
    public init?(body: Coordinate, cusp: Cusp, orb: Double = 10.0) {
        self.init(a: body.longitude, b: cusp.value)
    }

	/// The symbol commonly associated with the aspect.
    public var symbol: String? {
        switch self {
        case .conjunction:
            return "prominence"
 	case .semisextile:
            return "growth"
 	case .semisquare:
            return "friction"
        case .sextile:
            return "opportunity"
        case .square:
            return "obstacle"
        case .trine:
            return "luck"
 	case .sesquisquare:
            return "agitation"
 	case .inconjunction:
            return "expansion"
        case .opposition:
            return "separation"
        case .parallel:
            return "intensity"
       
        }
    }
	
	/// The number of degrees from exactness.
	 public var remainder: Double {
		switch self {
		case .conjunction(let remainder):
			return remainder
		case .semisextile(let remainder):
			return remainder
		case .semisquare(let remainder):
			return remainder
		case .sextile(let remainder):
			return remainder
		case .square(let remainder):
			return remainder
		case .trine(let remainder):
			return remainder
		case .sesquisquare(let remainder):
			return remainder
		case .inconjunction(let remainder):
			return remainder
		case .opposition(let remainder):
			return remainder
                case .parallel(let remainder):
			return remainder
		}
	}

    var isConjunction: Bool {
        switch self {
        case .conjunction(_):
            return true
        default:
            return false
        }
    }

 var isSemisextile: Bool {
        switch self {
        case .semisextile(_):
            return true
        default:
            return false
        }
    }

 var isSemisquare: Bool {
        switch self {
        case .semisquare(_):
            return true
        default:
            return false
        }
    }

    var isSextile: Bool {
        switch self {
        case .sextile(_):
            return true
        default:
            return false
        }
    }

    var isSquare: Bool {
        switch self {
        case .square(_):
            return true
        default:
            return false
        }
    }

    var isTrine: Bool {
        switch self {
        case .trine(_):
            return true
        default:
            return false
        }
    }

 var issesquisquare: Bool {
        switch self {
        case .sesquisquare(_):
            return true
        default:
            return false
        }
    }

 var isInconjunction: Bool {
        switch self {
        case .inconjunction(_):
            return true
        default:
            return false
        }
    }

    var isOpposition: Bool {
        switch self {
        case .opposition(_):
            return true
        default:
            return false
        }
    }

  var isParallel: Bool {
        switch self {
        case .parallel(_):
            return true
        default:
            return false
        }
    }
}

extension Kind {
    func inverted() -> Kind? {
        switch self {
        case .conjunction:
            return .opposition
        case .semisextile:
            return .inconjunction
        case .semisquare:
            return .sesquisquare
        case .sextile:
            return .sextile
        case .square:
            return .square
        case .trine:
            return .trine
        case .sesquisquare:
            return .semisquare
        case .inconjunction:
            return .semisextile
        case .opposition:
            return .conjunction
        default:
            return nil
        }
    }
}

