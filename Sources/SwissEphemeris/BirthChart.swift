//
//  BirthChart.swift
//  
//
//  Created by Sam Krishna on 10/12/22.
//

import Foundation

/// A Snapshot of the Birth Chart at a given moment in time and location.
/// Includes all planets at the time of birth.
public struct BirthChart {

    public let houseCusps: HouseCusps

    public let sun: Coordinate

    public let moon: Coordinate

    public let mercury: Coordinate

    public let venus: Coordinate

    public let mars: Coordinate

    public let jupiter: Coordinate

    public let saturn: Coordinate

    public let uranus: Coordinate

    public let neptune: Coordinate
    
    public let ascendant: Coordinate
 
    public let midheaven: Coordinate

    public let pluto: Coordinate

//    public let northNode: Coordinate

    public let southNode: Coordinate

    public let planets: [Coordinate]

    public let lunarNodes: [Coordinate]

    public let allBodies: [Coordinate]

    public init(date: Date,
                latitude: Double,
                longitude: Double,
                houseSystem: HouseSystem) {

        houseCusps = HouseCusps(date: date, latitude: latitude, longitude: longitude, houseSystem: houseSystem)

        sun = Coordinate(body: Planet.sun.celestialObject, date: date)
        moon = Coordinate(body: Planet.moon.celestialObject, date: date)
        mercury = Coordinate(body: Planet.mercury.celestialObject, date: date)
        venus = Coordinate(body: Planet.venus.celestialObject, date: date)
        mars = Coordinate(body: Planet.mars.celestialObject, date: date)
        jupiter = Coordinate(body: Planet.jupiter.celestialObject, date: date)
        saturn = Coordinate(body: Planet.saturn.celestialObject, date: date)
        uranus = Coordinate(body: Planet.uranus.celestialObject, date: date)
        neptune = Coordinate(body: Planet.neptune.celestialObject, date: date)
        pluto = Coordinate(body: Planet.pluto.celestialObject, date: date)
        ascendant = Coordinate(body: Planet.pluto.celestialObject, date: date)
        midheaven = Coordinate(body: Planet.pluto.celestialObject, date: date)
//        northNode = Coordinate(body: LunarNode.meanNode.celestialObject, date: date)
        southNode = Coordinate(body: LunarNode.meanSouthNode.celestialObject, date: date)

        planets = [
            sun,
            moon,
            mercury,
            venus,
            mars,
            jupiter,
            saturn,
            uranus,
            neptune,
            pluto
        ]

        lunarNodes = [
//            northNode,
            southNode
        ]

        allBodies = [
            sun,
            moon,
            mercury,
            venus,
            mars,
            jupiter,
            saturn,
            uranus,
            neptune,
            pluto,
//            northNode,
            southNode,
           
        ]
    }

    public static var allBodyCases: [CelestialObject] {
        return [
            Planet.sun.celestialObject,
            Planet.moon.celestialObject,
            Planet.mercury.celestialObject,
            Planet.venus.celestialObject,
            Planet.mars.celestialObject,
            Planet.jupiter.celestialObject,
            Planet.saturn.celestialObject,
            Planet.uranus.celestialObject,
            Planet.neptune.celestialObject,
            Planet.pluto.celestialObject,
            LunarNode.meanNode.celestialObject,
            LunarNode.meanSouthNode.celestialObject,
           
        ]
    }

    var fastBodies: [Coordinate] {
        return [
            self.sun,
            self.moon,
            self.mercury,
            self.venus,
            self.mars
        ]
    }

    var astroDeinstPlanetOrbs: Dictionary<Kind, Double> {
        // Astrodeinst's orbs
        return [
            .conjunction : 15.0,
            .semisextile : 4.0,
            .semisquare : 6.0,
            .sextile : 8.0,
            .square : 12.0,
            .trine : 12.0,
	    .sesquisquare : 3.0,
	    .inconjunction : 4.0,
            .opposition : 15.0,
// .parallel : 1.0
        ]
    }

    var stevensFastOrbs: Dictionary<Kind, Double> {
        return [
            .conjunction : 5.0,
            .sextile : 3.0,
            .square : 4.0,
            .trine : 3.0,
            .opposition : 4.0
        ]
    }

    var notFastOrb: Double {
        return 0.0 // Astrodeinst orb
        // return 1.0 // Steven's orb
    }

public var allAspects: [CelestialAspect]? {
    var aspects = [CelestialAspect]()
    var checkedPairs = [String: [Kind]]()

    for (i, aBody) in self.allBodies.enumerated() {
        for fp in self.allBodies.suffix(from: i+1) {
            var foundAspects = [CelestialAspect]()
            for aspect in Kind.allCases {
                let orb = astroDeinstPlanetOrbs[aspect]
                var hasAspect = true
                var angle: Double = 0.0

                if let a = CelestialAspect(body1: aBody, body2: fp, orb: orb!) {
                    if a.kind == aspect {
                        let pairKey = "\(aBody.body.formatted)-\(fp.body.formatted)"
                        if let existingKinds = checkedPairs[pairKey] {
                            if !existingKinds.contains(aspect) {
                                foundAspects.append(a)
                                checkedPairs[pairKey]?.append(aspect)
                                angle = a.angle
                            }
                        } else {
                            foundAspects.append(a)
                            checkedPairs[pairKey] = [aspect]
                            angle = a.angle
                        }
                    } else {
                        hasAspect = false
                    }
                } else {
                    hasAspect = false
                }

                if hasAspect {
                    // Handle any other cases here
                }
            }

          //  print("Found aspects \(checkedPairs)")

            // Add all found aspects to the main aspects array
            aspects.append(contentsOf: foundAspects)
        }
    }

    return aspects.isEmpty ? nil : aspects
}

    public func snapshotOfTransitingBodies(for date: Date) -> [Coordinate] {
        return [
            Coordinate(body: Planet.sun.celestialObject, date: date),
            Coordinate(body: Planet.moon.celestialObject, date: date),
            Coordinate(body: Planet.mercury.celestialObject, date: date),
            Coordinate(body: Planet.venus.celestialObject, date: date),
            Coordinate(body: Planet.mars.celestialObject, date: date),
            Coordinate(body: Planet.jupiter.celestialObject, date: date),
            Coordinate(body: Planet.saturn.celestialObject, date: date),
            Coordinate(body: Planet.uranus.celestialObject, date: date),
            Coordinate(body: Planet.neptune.celestialObject, date: date),
            Coordinate(body: Planet.pluto.celestialObject, date: date),
            Coordinate(body: LunarNode.meanNode.celestialObject, date: date),
            Coordinate(body: LunarNode.meanSouthNode.celestialObject, date: date),
          
        ]
    }
    
    public func snapshotOfProgressedBodies(for date: Date) -> [Coordinate] {
        return [
            Coordinate(body: Planet.sun.celestialObject, date: date),
            Coordinate(body: Planet.moon.celestialObject, date: date),
            Coordinate(body: Planet.mercury.celestialObject, date: date),
            Coordinate(body: Planet.venus.celestialObject, date: date),
            Coordinate(body: Planet.mars.celestialObject, date: date),
            Coordinate(body: Planet.jupiter.celestialObject, date: date),
            Coordinate(body: Planet.saturn.celestialObject, date: date),
            Coordinate(body: Planet.uranus.celestialObject, date: date),
            Coordinate(body: Planet.neptune.celestialObject, date: date),
            Coordinate(body: Planet.pluto.celestialObject, date: date),
            Coordinate(body: LunarNode.meanNode.celestialObject, date: date),
            Coordinate(body: LunarNode.meanSouthNode.celestialObject, date: date),
          
        ]
    }

    public func snapshotOfPlanets(for date: Date) -> [Coordinate] {
        return [
            Coordinate(body: Planet.sun.celestialObject, date: date),
            Coordinate(body: Planet.moon.celestialObject, date: date),
            Coordinate(body: Planet.mercury.celestialObject, date: date),
            Coordinate(body: Planet.venus.celestialObject, date: date),
            Coordinate(body: Planet.mars.celestialObject, date: date),
            Coordinate(body: Planet.jupiter.celestialObject, date: date),
            Coordinate(body: Planet.saturn.celestialObject, date: date),
            Coordinate(body: Planet.uranus.celestialObject, date: date),
            Coordinate(body: Planet.neptune.celestialObject, date: date),
            Coordinate(body: Planet.pluto.celestialObject, date: date),
        ]
    }

 
    public func snapshotOfNodes(for date: Date) -> [Coordinate] {
        return [
            Coordinate(body: LunarNode.meanNode.celestialObject, date: date),
            Coordinate(body: LunarNode.meanSouthNode.celestialObject, date: date)
        ]
    }

    public func aspects(for natalBody: Coordinate, on date: Date, with orb: Double = 2.0) -> [CelestialAspect]? {
        let bodies = snapshotOfTransitingBodies(for: date)
        var aspects = [CelestialAspect]()

        for Tbody in bodies {
            if let ca = CelestialAspect(body1: Tbody, body2: natalBody, orb: orb) {
                aspects.append(ca)
            }
        }

        return aspects.count > 0 ? aspects : nil
    }

    public func transitType(for Tbody: CelestialObject, with natalBody: Coordinate, on date: Date, orb: Double = 2.0) -> Kind? {
        let bodyCoordinate = Coordinate(body: Tbody, date: date)
        if let a = CelestialAspect(body1: bodyCoordinate, body2: natalBody, orb: orb) {
            return a.kind
        }

        return nil
    }

public enum TransitKind {
    case conjunction
    case sextile
    case square
    case trine
    case opposition
    case semisextile
    case semisquare
    case sesquisquare
    case inconjunction
    case parallel(ParallelKind)

    public enum ParallelKind {
        case parallel
        case contraParallel
    }
}

   public func transitType(for Tbody: CelestialObject, with cusp: Cusp, on date: Date, orb: Double = 2.0) -> TransitKind? {
    let bodyCoordinate = Coordinate(body: Tbody, date: date)
    if let a = Aspect(a: bodyCoordinate.longitude, b: cusp.value) {
        switch a {
        case .conjunction(_):
            return .conjunction
        case .sextile(_):
            return .sextile
        case .semisextile(_):
            return .semisextile
        case .semisquare(_):
            return .semisquare
        case .square(_):
            return .square
        case .trine(_):
            return .trine
        case .sesquisquare(_):
            return .sesquisquare
        case .inconjunction(_):
            return .inconjunction
        case .opposition(_):
            return .opposition
        case .parallel(_):
            return .parallel(.parallel) // replace .conjunction with the appropriate value
        }
    }

    return nil
}

 

    public func transitToTransitCoordinates(for TBody1: CelestialObject, with TBody2: CelestialObject, on date: Date, orb: Double = 6.0) -> (first: Coordinate, last: Coordinate)? {
        precondition(TBody1 != TBody2, "Celestial Objects cannot be the same")
        precondition(TBody1 != .all, "All is not allowed")
        precondition(TBody2 != .all, "All is not allowed")
        precondition(TBody1 != .noBody, "No Body is not allowed")
        precondition(TBody2 != .noBody, "No Body is not allowed")

        guard let a = CelestialAspect(body1: TBody1, body2: TBody2, date: date, orb: orb) else {
            return nil;
        }

        var yesterday: CelestialAspect? = a
        var tomorrow: CelestialAspect? = a
        var dayBefore = date
        var dayAfter = date

        while yesterday != nil {
            dayBefore = dayBefore.offset(.day, value: -1)!
            let yesterdayTBody = Coordinate(body: TBody1, date: dayBefore)
            let yesterdayOTBody = Coordinate(body: TBody2, date: dayBefore)
            yesterday = CelestialAspect(body1: yesterdayTBody, body2: yesterdayOTBody, orb: orb)
        }

        while tomorrow != nil {
            dayAfter = dayAfter.offset(.day, value: 1)!
            let tomorrowTBody = Coordinate(body: TBody1, date: dayAfter)
            let tomorrowOTBody = Coordinate(body: TBody2, date: dayAfter)
            tomorrow = CelestialAspect(body1: tomorrowTBody, body2: tomorrowOTBody, orb: orb)
        }

        let beforeFirstDay = dayBefore
        let firstDay = dayBefore.offset(.day, value: 1)!

        var TBodyPositions = BodiesRequest(body: TBody1).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        var OTBodyPositions = BodiesRequest(body: TBody2).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        let starting = zip(TBodyPositions, OTBodyPositions)
            .first { (TBodyNow, OTBodyNow) in
                let a = CelestialAspect(body1: TBodyNow, body2: OTBodyNow, orb: orb)
                return a != nil
            }

        let afterLastDay = dayAfter
        let lastDay = dayAfter.offset(.day, value: -1)!
        TBodyPositions = BodiesRequest(body: TBody1).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        OTBodyPositions = BodiesRequest(body: TBody2).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        let ending = Array(zip(TBodyPositions, OTBodyPositions))
            .last { (TBodyNow, OTBodyNow) in
                let a = CelestialAspect(body1: TBodyNow, body2: OTBodyNow, orb: orb)
                return a != nil
            }

        let TBodyStart = starting!.0
        let TBodyEnd = ending!.0
        return (TBodyStart, TBodyEnd)
    }


    public func transitingCoordinates(for transitingBody: CelestialObject, with natalBody: Coordinate, on date: Date, orb: Double = 2.0) -> (first: Coordinate, last: Coordinate)? {
        precondition(transitingBody != .all, "All is not allowed")
        precondition(transitingBody != .noBody, "No Body is not allowed")

        let TBody = Coordinate(body: transitingBody, date: date)
        guard let a = CelestialAspect(body1: TBody, body2: natalBody, orb: orb) else {
            return nil
        }

        var yesterday: CelestialAspect? = a
        var tomorrow: CelestialAspect? = a
        var dayBefore = date
        var dayAfter = date

        while yesterday != nil {
            dayBefore = dayBefore.offset(.day, value: -1)!
            let yesterdayTBody = Coordinate(body: TBody.body, date: dayBefore)
            yesterday = CelestialAspect(body1: yesterdayTBody, body2: natalBody, orb: orb)
        }

        while tomorrow != nil {
            dayAfter = dayAfter.offset(.day, value: 1)!
            let tomorrowTBody = Coordinate(body: TBody.body, date: dayAfter)
            tomorrow = CelestialAspect(body1: tomorrowTBody, body2: natalBody, orb: orb)
        }

        let beforeFirstDay = dayBefore
        let firstDay = dayBefore.offset(.day, value: 1)!
        let afterLastDay = dayAfter
        let lastDay = dayAfter.offset(.day, value: -1)!

        var positions = BodiesRequest(body: TBody.body).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        let starting = positions.first { now in
            let a = Aspect(bodyA: now, bodyB: natalBody, orb: orb)
            return a != nil
        }

        positions = BodiesRequest(body: TBody.body).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        let ending = positions.last { now in
            let a = Aspect(bodyA: now, bodyB: natalBody, orb: orb)
            return a != nil
        }

        return (starting, ending) as? (first: Coordinate, last: Coordinate)
    }

    public func transitingCoordinates(for transitingBody: CelestialObject, with cusp: Cusp, on date: Date, orb: Double = 2.0) -> (first: Coordinate, last: Coordinate)? {
        precondition(transitingBody != .all, "All is not allowed")
        precondition(transitingBody != .noBody, "No Body is not allowed")
        let TBody = Coordinate(body: transitingBody, date: date)
        guard let a = Aspect(body: TBody, cusp: cusp, orb: orb) else {
            return nil
        }

        var yesterday: Aspect? = a
        var tomorrow: Aspect? = a
        var dayBefore = date
        var dayAfter = date

        while yesterday != nil {
            dayBefore = dayBefore.offset(.day, value: -1)!
            let yesterdayTBody = Coordinate(body: TBody.body, date: dayBefore)
            yesterday = Aspect(body: yesterdayTBody, cusp: cusp, orb: orb)
        }

        while tomorrow != nil {
            dayAfter = dayAfter.offset(.day, value: 1)!
            let tomorrowTBody = Coordinate(body: TBody.body, date: dayAfter)
            tomorrow = Aspect(body: tomorrowTBody, cusp: cusp, orb: orb)
        }

        let beforeFirstDay = dayBefore
        let firstDay = dayBefore.offset(.day, value: 1)!
        let afterLastDay = dayAfter
        let lastDay = dayAfter.offset(.day, value: -1)!

        var positions = BodiesRequest(body: TBody.body).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        let starting = positions.first { now in
            let a = CuspAspect(body: now, cusp: cusp, orb: orb)
            return a != nil
        }

        positions = BodiesRequest(body: TBody.body).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        let ending = positions.last { now in
            let a = CuspAspect(body: now, cusp: cusp, orb: orb)
            return a != nil
        }

        return (starting, ending) as? (first: Coordinate, last: Coordinate)
    }

    public func findNextAspect(for body: CelestialObject, with natal: Coordinate, on date: Date, with orb: Double = 2.0) -> (aspect: CelestialAspect, start: Coordinate, end: Coordinate) {
        let TBody = Coordinate(body: body, date: date)
        if let a = CelestialAspect(body1: TBody, body2: natal, orb: orb) {
            let tuple = self.transitingCoordinates(for: body, with: natal, on: date, orb: orb)
            return (a, tuple!.first, tuple!.last)
        }

        var aspect: CelestialAspect?
        var tomorrow = date

        while aspect == nil {
            tomorrow = tomorrow.offset(.day, value: 1)!
            let tomorrowTBody = Coordinate(body: TBody.body, date: tomorrow)
            aspect = CelestialAspect(body1: tomorrowTBody, body2: natal, orb: orb)
        }

        let tuple = self.transitingCoordinates(for: body, with: natal, on: tomorrow, orb: orb)
        return (aspect!, tuple!.first, tuple!.last)
    }

    public func findNextAspect(for body: CelestialObject, with cusp: Cusp, on date: Date, with orb: Double = 2.0) -> (aspect: CuspAspect, start: Coordinate, end: Coordinate) {
        let TBody = Coordinate(body: body, date: date)
        if let a = CuspAspect(body: TBody, cusp: cusp, orb: orb) {
            let tuple = self.transitingCoordinates(for: body, with: cusp, on: date, orb: orb)
            return (a, tuple!.first, tuple!.last)
        }

        var aspect: CuspAspect?
        var tomorrow = date

        while aspect == nil {
            tomorrow = tomorrow.offset(.day, value: 1)!
            let tomorrowTBody = Coordinate(body: TBody.body, date: tomorrow)
            aspect = CuspAspect(body: tomorrowTBody, cusp: cusp, orb: orb)
        }

        let tuple = self.transitingCoordinates(for: body, with: cusp, on: tomorrow, orb: orb)
        return (aspect!, tuple!.first, tuple!.last)
    }
}


extension BirthChart {
    public func signOnEachCusp() -> [Zodiac] {
        return houseCusps.houses.map { signForCusp($0) }
    }
    
    public func interceptedSignsInEachHouse() -> [[Zodiac]] {
        return (1...12).map { interceptedSignsForHouse($0) }
    }
    
    private func signForCusp(_ cusp: Cusp) -> Zodiac {
        let normalizedValue = (cusp.value.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
        let zodiacIndex = Int(normalizedValue / 30)
        return Zodiac(rawValue: zodiacIndex)!
    }
    
    private func interceptedSignsForHouse(_ house: Int) -> [Zodiac] {
        let cusp1 = houseCusps.houses[(house - 1) % 12] // Using modulo to wrap around at the end
        let cusp2 = houseCusps.houses[house % 12]
        
        let sign1 = signForCusp(cusp1)
        let sign2 = signForCusp(cusp2)
        
        // Calculate the difference between signs. If it's 2 or more, there's an intercepted sign.
        var signDifference = sign2.rawValue - sign1.rawValue
        if signDifference < 0 {
            signDifference += 12 // Add 12 if the result is negative to correct for wrap-around.
        }
        
        if signDifference >= 2 {
            // If there's an intercepted sign, return an array with the sign after `sign1` (wrap-around corrected)
            return [(Zodiac(rawValue: (sign1.rawValue + 1) % 12))!]
        } else {
            // If there's no intercepted sign, return an empty array
            return []
        }
    }
    
    public func progressedAspects(for natalBody: Coordinate, on date: Date, with orb: Double = 1.0) -> [CelestialAspect]? {
        let bodies = snapshotOfProgressedBodies(for: date)
        var aspects = [CelestialAspect]()

        for Pbody in bodies {
            if let ca = CelestialAspect(body1: Pbody, body2: natalBody, orb: orb) {
                aspects.append(ca)
            }
        }

        return aspects.count > 0 ? aspects : nil
    }

    public func progressionType(for Pbody: CelestialObject, with natalBody: Coordinate, on date: Date, orb: Double = 1.0) -> Kind? {
        let bodyCoordinate = Coordinate(body: Pbody, date: date)
        if let a = CelestialAspect(body1: bodyCoordinate, body2: natalBody, orb: orb) {
            return a.kind
        }

        return nil
    }

public enum ProgressionKind {
    case conjunction
    case sextile
    case square
    case trine
    case opposition
    case semisextile
    case semisquare
    case sesquisquare
    case inconjunction
    case parallel(ParallelKind)

    public enum ParallelKind {
        case parallel
        case contraParallel
    }
}

   public func progressionType(for Pbody: CelestialObject, with cusp: Cusp, on date: Date, orb: Double = 1.0) -> TransitKind? {
    let bodyCoordinate = Coordinate(body: Pbody, date: date)
    if let a = Aspect(a: bodyCoordinate.longitude, b: cusp.value) {
        switch a {
        case .conjunction(_):
            return .conjunction
        case .sextile(_):
            return .sextile
        case .semisextile(_):
            return .semisextile
        case .semisquare(_):
            return .semisquare
        case .square(_):
            return .square
        case .trine(_):
            return .trine
        case .sesquisquare(_):
            return .sesquisquare
        case .inconjunction(_):
            return .inconjunction
        case .opposition(_):
            return .opposition
        case .parallel(_):
            return .parallel(.parallel) // replace .conjunction with the appropriate value
        }
    }

    return nil
}

 

    public func transitToProgressionCoordinates(for TBody1: CelestialObject, with PBody: CelestialObject, on date: Date, orb: Double = 1.0) -> (first: Coordinate, last: Coordinate)? {
        precondition(TBody1 != PBody, "Celestial Objects cannot be the same")
        precondition(TBody1 != .all, "All is not allowed")
        precondition(PBody != .all, "All is not allowed")
        precondition(TBody1 != .noBody, "No Body is not allowed")
        precondition(PBody != .noBody, "No Body is not allowed")

        guard let a = CelestialAspect(body1: TBody1, body2: PBody, date: date, orb: orb) else {
            return nil;
        }

        var yesterday: CelestialAspect? = a
        var tomorrow: CelestialAspect? = a
        var dayBefore = date
        var dayAfter = date

        while yesterday != nil {
            dayBefore = dayBefore.offset(.day, value: -1)!
            let yesterdayTBody = Coordinate(body: TBody1, date: dayBefore)
            let yesterdayOTBody = Coordinate(body: PBody, date: dayBefore)
            yesterday = CelestialAspect(body1: yesterdayTBody, body2: yesterdayOTBody, orb: orb)
        }

        while tomorrow != nil {
            dayAfter = dayAfter.offset(.day, value: 1)!
            let tomorrowTBody = Coordinate(body: TBody1, date: dayAfter)
            let tomorrowOTBody = Coordinate(body: PBody, date: dayAfter)
            tomorrow = CelestialAspect(body1: tomorrowTBody, body2: tomorrowOTBody, orb: orb)
        }

        let beforeFirstDay = dayBefore
        let firstDay = dayBefore.offset(.day, value: 1)!

        var TBodyPositions = BodiesRequest(body: TBody1).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        var OTBodyPositions = BodiesRequest(body: PBody).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        let starting = zip(TBodyPositions, OTBodyPositions)
            .first { (TBodyNow, OTBodyNow) in
                let a = CelestialAspect(body1: TBodyNow, body2: OTBodyNow, orb: orb)
                return a != nil
            }

        let afterLastDay = dayAfter
        let lastDay = dayAfter.offset(.day, value: -1)!
        TBodyPositions = BodiesRequest(body: TBody1).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        OTBodyPositions = BodiesRequest(body: PBody).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        let ending = Array(zip(TBodyPositions, OTBodyPositions))
            .last { (TBodyNow, OTBodyNow) in
                let a = CelestialAspect(body1: TBodyNow, body2: OTBodyNow, orb: orb)
                return a != nil
            }

        let TBodyStart = starting!.0
        let TBodyEnd = ending!.0
        return (TBodyStart, TBodyEnd)
    }

    
    public func progressionToProgressionCoordinates(for PBody1: CelestialObject, with PBody2: CelestialObject, on date: Date, orb: Double = 1.0) -> (first: Coordinate, last: Coordinate)? {
        precondition(PBody1 != PBody2, "Celestial Objects cannot be the same")
        precondition(PBody1 != .all, "All is not allowed")
        precondition(PBody2 != .all, "All is not allowed")
        precondition(PBody1 != .noBody, "No Body is not allowed")
        precondition(PBody2 != .noBody, "No Body is not allowed")

        guard let a = CelestialAspect(body1: PBody1, body2: PBody2, date: date, orb: orb) else {
            return nil;
        }

        var yesterday: CelestialAspect? = a
        var tomorrow: CelestialAspect? = a
        var dayBefore = date
        var dayAfter = date

        while yesterday != nil {
            dayBefore = dayBefore.offset(.day, value: -1)!
            let yesterdayPBody = Coordinate(body: PBody1, date: dayBefore)
            let yesterdayOPBody = Coordinate(body: PBody2, date: dayBefore)
            yesterday = CelestialAspect(body1: yesterdayPBody, body2: yesterdayOPBody, orb: orb)
        }

        while tomorrow != nil {
            dayAfter = dayAfter.offset(.day, value: 1)!
            let tomorrowPBody = Coordinate(body: PBody1, date: dayAfter)
            let tomorrowOPBody = Coordinate(body: PBody2, date: dayAfter)
            tomorrow = CelestialAspect(body1: tomorrowPBody, body2: tomorrowOPBody, orb: orb)
        }

        let beforeFirstDay = dayBefore
        let firstDay = dayBefore.offset(.day, value: 1)!

        var PBodyPositions = BodiesRequest(body: PBody1).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        var OPBodyPositions = BodiesRequest(body: PBody2).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        let starting = zip(PBodyPositions, OPBodyPositions)
            .first { (PBodyNow, OPBodyNow) in
                let a = CelestialAspect(body1: PBodyNow, body2: OPBodyNow, orb: orb)
                return a != nil
            }

        let afterLastDay = dayAfter
        let lastDay = dayAfter.offset(.day, value: -1)!
        PBodyPositions = BodiesRequest(body: PBody1).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        OPBodyPositions = BodiesRequest(body: PBody2).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        let ending = Array(zip(PBodyPositions, OPBodyPositions))
            .last { (PBodyNow, OPBodyNow) in
                let a = CelestialAspect(body1: PBodyNow, body2: OPBodyNow, orb: orb)
                return a != nil
            }

        let PBodyStart = starting!.0
        let PBodyEnd = ending!.0
        return (PBodyStart, PBodyEnd)
    }


    public func progressedCoordinates(for progressedBody: CelestialObject, with natalBody: Coordinate, on date: Date, orb: Double = 1.0) -> (first: Coordinate, last: Coordinate)? {
        precondition(progressedBody != .all, "All is not allowed")
        precondition(progressedBody != .noBody, "No Body is not allowed")

        let TBody = Coordinate(body: progressedBody, date: date)
        guard let a = CelestialAspect(body1: TBody, body2: natalBody, orb: orb) else {
            return nil
        }

        var yesterday: CelestialAspect? = a
        var tomorrow: CelestialAspect? = a
        var dayBefore = date
        var dayAfter = date

        while yesterday != nil {
            dayBefore = dayBefore.offset(.day, value: -1)!
            let yesterdayTBody = Coordinate(body: TBody.body, date: dayBefore)
            yesterday = CelestialAspect(body1: yesterdayTBody, body2: natalBody, orb: orb)
        }

        while tomorrow != nil {
            dayAfter = dayAfter.offset(.day, value: 1)!
            let tomorrowTBody = Coordinate(body: TBody.body, date: dayAfter)
            tomorrow = CelestialAspect(body1: tomorrowTBody, body2: natalBody, orb: orb)
        }

        let beforeFirstDay = dayBefore
        let firstDay = dayBefore.offset(.day, value: 1)!
        let afterLastDay = dayAfter
        let lastDay = dayAfter.offset(.day, value: -1)!

        var positions = BodiesRequest(body: TBody.body).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        let starting = positions.first { now in
            let a = Aspect(bodyA: now, bodyB: natalBody, orb: orb)
            return a != nil
        }

        positions = BodiesRequest(body: TBody.body).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        let ending = positions.last { now in
            let a = Aspect(bodyA: now, bodyB: natalBody, orb: orb)
            return a != nil
        }

        return (starting, ending) as? (first: Coordinate, last: Coordinate)
    }

    public func progressedCoordinates(for progressedBody: CelestialObject, with cusp: Cusp, on date: Date, orb: Double = 1.0) -> (first: Coordinate, last: Coordinate)? {
        precondition(progressedBody != .all, "All is not allowed")
        precondition(progressedBody != .noBody, "No Body is not allowed")
        let PBody = Coordinate(body: progressedBody, date: date)
        guard let a = Aspect(body: PBody, cusp: cusp, orb: orb) else {
            return nil
        }

        var yesterday: Aspect? = a
        var tomorrow: Aspect? = a
        var dayBefore = date
        var dayAfter = date

        while yesterday != nil {
            dayBefore = dayBefore.offset(.day, value: -1)!
            let yesterdayPBody = Coordinate(body: PBody.body, date: dayBefore)
            yesterday = Aspect(body: yesterdayPBody, cusp: cusp, orb: orb)
        }

        while tomorrow != nil {
            dayAfter = dayAfter.offset(.day, value: 1)!
            let tomorrowBBody = Coordinate(body: PBody.body, date: dayAfter)
            tomorrow = Aspect(body: tomorrowBBody, cusp: cusp, orb: orb)
        }

        let beforeFirstDay = dayBefore
        let firstDay = dayBefore.offset(.day, value: 1)!
        let afterLastDay = dayAfter
        let lastDay = dayAfter.offset(.day, value: -1)!

        var positions = BodiesRequest(body: PBody.body).fetch(start: beforeFirstDay, end: firstDay, interval: TimeSlice.minute.slice)
        let starting = positions.first { now in
            let a = CuspAspect(body: now, cusp: cusp, orb: orb)
            return a != nil
        }

        positions = BodiesRequest(body: PBody.body).fetch(start: lastDay, end: afterLastDay, interval: TimeSlice.minute.slice)
        let ending = positions.last { now in
            let a = CuspAspect(body: now, cusp: cusp, orb: orb)
            return a != nil
        }

        return (starting, ending) as? (first: Coordinate, last: Coordinate)
    }

    public func findNextProgressedAspect(for body: CelestialObject, with natal: Coordinate, on date: Date, with orb: Double = 1.0) -> (aspect: CelestialAspect, start: Coordinate, end: Coordinate) {
        let PBody = Coordinate(body: body, date: date)
        if let a = CelestialAspect(body1: PBody, body2: natal, orb: orb) {
            let tuple = self.transitingCoordinates(for: body, with: natal, on: date, orb: orb)
            return (a, tuple!.first, tuple!.last)
        }

        var aspect: CelestialAspect?
        var tomorrow = date

        while aspect == nil {
            tomorrow = tomorrow.offset(.day, value: 1)!
            let tomorrowPBody = Coordinate(body: PBody.body, date: tomorrow)
            aspect = CelestialAspect(body1: tomorrowPBody, body2: natal, orb: orb)
        }

        let tuple = self.transitingCoordinates(for: body, with: natal, on: tomorrow, orb: orb)
        return (aspect!, tuple!.first, tuple!.last)
    }

    public func findProgressedNextAspect(for body: CelestialObject, with cusp: Cusp, on date: Date, with orb: Double = 1.0) -> (aspect: CuspAspect, start: Coordinate, end: Coordinate) {
        let PBody = Coordinate(body: body, date: date)
        if let a = CuspAspect(body: PBody, cusp: cusp, orb: orb) {
            let tuple = self.progressedCoordinates(for: body, with: cusp, on: date, orb: orb)
            return (a, tuple!.first, tuple!.last)
        }

        var aspect: CuspAspect?
        var tomorrow = date

        while aspect == nil {
            tomorrow = tomorrow.offset(.day, value: 1)!
            let tomorrowPBody = Coordinate(body: PBody.body, date: tomorrow)
            aspect = CuspAspect(body: tomorrowPBody, cusp: cusp, orb: orb)
        }

        let tuple = self.progressedCoordinates(for: body, with: cusp, on: tomorrow, orb: orb)
        return (aspect!, tuple!.first, tuple!.last)
    }
}




/*
extension BirthChart {
    public static var aspectTransits: [CelestialObject : (dateType: Date.DateComponentType, amount: Int)] {
        let d: [ CelestialObject : (dateType: Date.DateComponentType, amount: Int) ] = [
            Planet.sun.celestialObject : (.day, 40),
            Planet.mercury.celestialObject : (.day, 70),
            Planet.venus.celestialObject : (.day, 75),
            Planet.mars.celestialObject : (.month, 8),
            Planet.jupiter.celestialObject : (.month, 24),
            Planet.saturn.celestialObject : (.month, Int(2.8 * 12)),
            Planet.uranus.celestialObject : (.month, Int(8 * 12)),
            Planet.neptune.celestialObject : (.month, Int(15 * 12)),
            Planet.pluto.celestialObject : (.month, Int(32 * 12)),
            LunarNode.meanNode.celestialObject : (.month, Int(1.55 * 12)),
            LunarNode.meanSouthNode.celestialObject : (.month, Int(1.55 * 12)),
           
        ]

        return d
    }

    public func findPeakCoordinate(for transitingBody: CelestialObject, with natalBody: Coordinate, on date: Date, orb: Double = 2.0) -> Coordinate? {
        let TBody = Coordinate(body: transitingBody, date: date)
        guard let a = CelestialAspect(body1: TBody, body2: natalBody, orb: orb) else {
            return nil
        }

        if a.angle == 0.0 {
            return TBody
        }

        let kind = a.kind

        func getBestPosition(for start: Date, end: Date, slice: TimeInterval) -> Coordinate? {
            let positions = BodiesRequest(body: transitingBody).fetch(start: start, end: end, interval: slice)
            let range = -1.0...1.0
            let outcome = positions.min { lhs, rhs in
                guard let aspect = CelestialAspect(body1: lhs, body2: natalBody, orb: orb) else {
                    return false
                }

                return kind == aspect.kind && range.contains(abs(aspect.angle))
            }

            return outcome
        }

        // OK so now the trick will be to get the "best minute" of a position
        // that has as close to a ZERO degree for the remainder for a particular aspect
        guard let tuple = BirthChart.aspectTransits[transitingBody] else { return nil }
        var yesterdayStart = date.offset(tuple.dateType, value: (-1 * tuple.amount))!
        var tomorrowEnd = date.offset(tuple.dateType, value: tuple.amount)!
        let slices = TimeSlice.typicalSlices

        for i in stride(from: 1, to: TimeSlice.typicalSlices.endIndex, by: 1) {
            let window = slices[i]
            let best = getBestPosition(for: yesterdayStart, end: tomorrowEnd, slice: window.slice)

        }

        return nil
    }
}
*/
