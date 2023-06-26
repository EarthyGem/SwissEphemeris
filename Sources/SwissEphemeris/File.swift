//
//  File.swift
//  
//
//  Created by Errick Williams on 6/26/23.
//

import Foundation
/// A Snapshot of the Birth Chart.
/// Includes all planets at the time of birth.
public struct CompBirthChart {

    public let comphouseCusps: CompHouseCusps

    public let sun: CompCoordinate

    public let moon: CompCoordinate

    public let mercury: CompCoordinate

    public let venus: CompCoordinate

    public let mars: CompCoordinate

    public let jupiter: CompCoordinate

    public let saturn: CompCoordinate

    public let uranus: CompCoordinate

    public let neptune: CompCoordinate
    
    public let ascendant: CompCoordinate
 
    public let midheaven: CompCoordinate

    public let pluto: CompCoordinate

    public let northNode: CompCoordinate

    public let southNode: CompCoordinate

    public let planets: [CompCoordinate]

    public let lunarNodes: [CompCoordinate]

    public let allBodies: [CompCoordinate]

    public init(latitude: Double, longitude: Double, houseSystem: HouseSystem) {
        comphouseCusps = CompHouseCusps(latitude: latitude, longitude: longitude, houseSystem: houseSystem)

        sun = CompCoordinate(body: Planet.sun.celestialObject, longitude: 0, latitude: 0)
        moon = CompCoordinate(body: Planet.moon.celestialObject, longitude: 0, latitude: 0)
        mercury = CompCoordinate(body: Planet.mercury.celestialObject, longitude: 0, latitude: 0)
        venus = CompCoordinate(body: Planet.venus.celestialObject, longitude: 0, latitude: 0)
        mars = CompCoordinate(body: Planet.mars.celestialObject, longitude: 0, latitude: 0)
        jupiter = CompCoordinate(body: Planet.jupiter.celestialObject, longitude: 0, latitude: 0)
        saturn = CompCoordinate(body: Planet.saturn.celestialObject, longitude: 0, latitude: 0)
        uranus = CompCoordinate(body: Planet.uranus.celestialObject, longitude: 0, latitude: 0)
        neptune = CompCoordinate(body: Planet.neptune.celestialObject, longitude: 0, latitude: 0)
        pluto = CompCoordinate(body: Planet.pluto.celestialObject, longitude: 0, latitude: 0)
        ascendant = CompCoordinate(body: Planet.pluto.celestialObject, longitude: 0, latitude: 0)
        midheaven = CompCoordinate(body: Planet.pluto.celestialObject, longitude: 0, latitude: 0)
        northNode = CompCoordinate(body: LunarNode.meanNode.celestialObject, longitude: 0, latitude: 0)
        southNode = CompCoordinate(body: LunarNode.meanSouthNode.celestialObject, longitude: 0, latitude: 0)

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
            northNode,
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
            northNode,
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
}

