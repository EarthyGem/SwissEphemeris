////
////  File 3.swift
////  
////
////  Created by Errick Williams on 6/26/23.
////
//
//import Foundation
//
//import CSwissEphemeris
//
///// Models a `CelestialBody` point in the sky.
//public struct CompCoordinate: Equatable, Hashable {
//    
//    /// The type of `CelestialBody`.
//    public let body: CelestialObject
//    /// The coordinate's longitude.
//    public let longitude: Double
//    /// The coordinate's latitude.
//    public let latitude: Double
//    /// The computed angle between the celestial body and the heavenly equator.
//    public let declination: Double
//    /// The distance in AU.
//    public let distance: Double
//    /// The speed in longitude (deg/day).
//    public let speedLongitude: Double
//    /// The speed in latitude (deg/day).
//    public let speedLatitude: Double
//    /// The speed in distance (AU/day).
//    public let speedDistance: Double
//    /// The pointer that holds all values.
//    private var pointer = UnsafeMutablePointer<Double>.allocate(capacity: 60)
//    /// The pointer for the fixed star name.
//    private var charPointer = UnsafeMutablePointer<CChar>.allocate(capacity: 60)
//
//    public static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
//        return (lhs.body == rhs.body &&
//                lhs.longitude == rhs.longitude &&
//                lhs.latitude == rhs.latitude &&
//                lhs.declination == rhs.declination &&
//                lhs.distance == rhs.distance &&
//                lhs.speedLongitude == rhs.speedLongitude &&
//                lhs.speedDistance == rhs.speedDistance)
//    }
//
//    public static func !=(lhs: Coordinate, rhs: Coordinate) -> Bool {
//        return (lhs.body != rhs.body ||
//                lhs.longitude != rhs.longitude ||
//                lhs.latitude != rhs.latitude ||
//                lhs.declination != rhs.declination ||
//                lhs.distance != rhs.distance ||
//                lhs.speedLongitude != rhs.speedLongitude ||
//                lhs.speedDistance != rhs.speedDistance)
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(body)
//        hasher.combine(longitude)
//        hasher.combine(latitude)
//        hasher.combine(declination)
//        hasher.combine(distance)
//        hasher.combine(speedLongitude)
//        hasher.combine(speedDistance)
//    }
//
//    /// Creates a `Coordinate`.
//    /// - Parameters:
//    ///   - body: The `CelestialBody` for the placement.
//    ///   - longitude: The coordinate's longitude.
//    ///   - latitude: The coordinate's latitude.
//    public init(body: CelestialObject, longitude: Double, latitude: Double) {
//        self.body = body
//        self.longitude = longitude
//        self.latitude = latitude
//        self.declination = Coordinate.calculateDeclination(latitude, longitude)
//        self.distance = 0.0
//        self.speedLongitude = 0.0
//        self.speedLatitude = 0.0
//        self.speedDistance = 0.0
//    }
//
//    private static func calculateDeclination(_ lat: Double, _ lng: Double) -> Double {
//        // Formula: sin D = (cos B x sin L x sin E) + (sin B x cos E)
//        // Where:
//        // D = Declination (what we are solving for)
//        // E = The oblique angle of the ecliptic (Epsilon or ~23.447 degrees)
//        // L = Longitude measured from 0 degrees Aries
//        // B = Latitude
//
//        let epsilon = 23.437101628
//        func deg2rad(_ number: Double) -> Double { return number * .pi / 180 }
//        func rad2deg(_ number: Double) -> Double { return number * 180 / .pi }
//        let B = deg2rad(lat)
//        let L = deg2rad(lng)
//        let E = deg2rad(epsilon)
//        let lhs = cos(B) * sin(L) * sin(E)
//        let rhs = sin(B) * cos(E)
//        let sum = lhs + rhs
//        let dec = rad2deg(asin(sum))
//        return dec
//    }
//
//    public func declinationString() -> String {
//        let degree = Int(declination)
//        let arcminute = Int((declination - Double(degree)) * 60)
//        let arcsecond = Int(declination - Double(degree) - Double(arcminute / 60) * 3600)
//        return "\(degree)°\(arcminute)\'\(arcsecond)\""
//    }
//}
//
//// MARK: - ZodiacCoordinate Conformance
//
//extension Coordinate: ZodiacCoordinate {
//    public var value: Double { longitude }
//}
//
//// MARK: - Codable Conformance
//
//extension Coordinate: Codable {
//    
//    public enum CodingKeys: String, CodingKey {
//        case body
//        case longitude
//        case latitude
//        case declination
//        case distance
//        case speedLongitude
//        case speedLatitude
//        case speedDistance
//    }
//    
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        body = try container.decode(CelestialObject.self, forKey: .body)
//        longitude = try container.decode(Double.self, forKey: .longitude)
//        latitude = try container.decode(Double.self, forKey: .latitude)
//        declination = try container.decode(Double.self, forKey: .declination)
//        distance = try container.decode(Double.self, forKey: .distance)
//        speedLongitude = try container.decode(Double.self, forKey: .speedLongitude)
//        speedLatitude = try container.decode(Double.self, forKey: .speedLatitude)
//        speedDistance = try container.decode(Double.self, forKey: .speedDistance)
//    }
//    
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(body, forKey: .body)
//        try container.encode(longitude, forKey: .longitude)
//        try container.encode(latitude, forKey: .latitude)
//        try container.encode(declination, forKey: .declination)
//        try container.encode(distance, forKey: .distance)
//        try container.encode(speedLongitude, forKey: .speedLongitude)
//        try container.encode(speedLatitude, forKey: .speedLatitude)
//        try container.encode(speedDistance, forKey: .speedDistance)
//    }
//
//    public func longitudeDelta(other: Coordinate) -> Double {
//        return abs(longitude - other.longitude)
//    }
//}
