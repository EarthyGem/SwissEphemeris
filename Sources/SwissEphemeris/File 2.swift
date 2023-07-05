////
////  File 2.swift
////  
////
////  Created by Errick Williams on 6/26/23.
////
//
//import CSwissEphemeris
//import Foundation
//
///// Models a house system with a `Cusp` for each house, ascendant, and midheaven.
//public struct CompHouseCusps {
//    /// The latitude of the house system.
//    public let latitude: Double
//    /// The longitude of the house system.
//    public let longitude: Double
//    /// The pointer passed into `swe_houses` to receive the ascendant.
//    private let ascendantPointer = UnsafeMutablePointer<Double>.allocate(capacity: 1)
//    /// The pointer passed into `swe_houses` to receive the cusps.
//    private let cuspPointer = UnsafeMutablePointer<Double>.allocate(capacity: 13)
//
//    /// Point of the ascendant.
//    public let ascendant: Cusp
//    /// Point of the midheaven.
//    public let midheaven: Cusp
//    /// Cusp between the twelfth and first house.
//    public let cusp1: Cusp
//    /// Cusp between the first and second house.
//    public let cusp2: Cusp
//    /// Cusp between the second and third house.
//    public let cusp3: Cusp
//    /// Cusp between the third and fourth house.
//    public let cusp4: Cusp
//    /// Cusp between the fourth and fifth house.
//    public let cusp5: Cusp
//    /// Cusp between the fifth and sixth house.
//    public let cusp6: Cusp
//    /// Cusp between the sixth and seventh house.
//    public let cusp7: Cusp
//    /// Cusp between the seventh and eighth house.
//    public let cusp8: Cusp
//    /// Cusp between the eighth and ninth house.
//    public let cusp9: Cusp
//    /// Cusp between the ninth and tenth house.
//    public let cusp10: Cusp
//    /// Cusp between the tenth and eleventh house.
//    public let cusp11: Cusp
//    /// Cusp between the eleventh and twelfth house.
//    public let cusp12: Cusp
//
//    /// Array of house cusps, by numerical order.
//    public let cusps: [Cusp]
//
//    /// The preferred initializer.
//    /// - Parameters:
//    ///   - latitude: The location latitude for the house system.
//    ///   - longitude: The location longitude for the house system.
//    ///   - houseSystem: The type of `HouseSystem`.
//    public init(latitude: Double,
//                longitude: Double,
//                houseSystem: HouseSystem) {
//        defer {
//            cuspPointer.deallocate()
//            ascendantPointer.deallocate()
//        }
//        self.latitude = latitude
//        self.longitude = longitude
//        swe_houses(0.0, latitude, longitude, houseSystem.rawValue, cuspPointer, ascendantPointer);
//        ascendant = Cusp(value: ascendantPointer[0], name: "ascendant", number: 1)
//        midheaven = Cusp(value: ascendantPointer[1], name: "midheaven", number: 10)
//        cusp1 = Cusp(value: cuspPointer[1], name: "first", number: 1)
//        cusp2 = Cusp(value: cuspPointer[2], name: "second", number: 2)
//        cusp3 = Cusp(value: cuspPointer[3], name: "third", number: 3)
//        cusp4 = Cusp(value: cuspPointer[4], name: "fourth", number: 4)
//        cusp5 = Cusp(value: cuspPointer[5], name: "fifth", number: 5)
//        cusp6 = Cusp(value: cuspPointer[6], name: "sixth", number: 6)
//        cusp7 = Cusp(value: cuspPointer[7], name: "seventh", number: 7)
//        cusp8 = Cusp(value: cuspPointer[8], name: "eighth", number: 8)
//        cusp9 = Cusp(value: cuspPointer[9], name: "ninth", number: 9)
//        cusp10 = Cusp(value: cuspPointer[10], name: "tenth", number: 10)
//        cusp11 = Cusp(value: cuspPointer[11], name: "eleventh", number: 11)
//        cusp12 = Cusp(value: cuspPointer[12], name: "twelfth", number: 12)
//
//        cusps = [cusp1, cusp2, cusp3, cusp4, cusp5, cusp6, cusp7, cusp8, cusp9, cusp10, cusp11, cusp12]
//    }
//}
