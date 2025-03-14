//
//  BodiesRequest.swift
//  
//
//  Created by Sam Krishna on 03.13.22
//

import Foundation

public enum TimeSlice: Double, CaseIterable {
    case minute
    case hour
    case day
    case month
    case siderealMonh
    case synodicMonth

    public var slice: Double {
        switch self {
        case .minute:
            return Double(60)
        case .hour:
            return Double(60 * 60)
        case .day:
            return Double(24 * 60 * 60)
        case .month:
            return Double(28 * 24 * 60 * 60)
        case .siderealMonh:
            return Double(27.321661 * 24 * 60 * 60)
        case .synodicMonth:
            return Double(29.530588 * 24 * 60 * 60)
        }
    }

    public static var typicalSlices: [TimeSlice] {
        return [ .month, .day, .hour, .minute ]
    }
}

/// A generic `BatchRequest` for a collection of `<BodyType>` `Coordinates`.
///
/// A useful way of thinking about `BodiesRequest` is to consider that it's outputting a sequence
/// of positions that show the celestial body moving through the sky. Consider that the positions are animated
/// like an old-school film strip or flip book. To see whet I'm talking about, watch this video:
///
/// https://youtu.be/ntD2qiGx-DY
final public class BodiesRequest: BatchRequest {

    /// The `BodyType` to request (usually `Planet` or `LunarNode` or `Asteroid`)
    public let body: CelestialObject
    public let datesThreshold = 478

    /// Creates an instance of `BodiesRequest of type <BodyType>`.
    /// - Parameter body: The celestial body to request.
    public init(body: CelestialObject) {
        self.body = body
    }

    public func fetch(start: Date, end: Date, interval: TimeInterval = 60.0) -> [Coordinate] {
        stride(from: start, through: end, by: interval).map {
            Coordinate(body: body, date: $0)
        }
    }
}
