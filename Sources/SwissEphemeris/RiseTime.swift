//
//  RiseTime.swift
//  
//
//  Created by Vincent Smithers on 09.03.21.
//

import Foundation

import CSwissEphemeris

/// Models the precise rising time for a celestial body.
public struct RiseTime {
	
	/// The date of the rise.
	public let date: Date?
	/// The pointer for the longitude, latitude and altitude.
	let geoPos = UnsafeMutablePointer<Double>.allocate(capacity: 3)
	/// The pointer for the time.
	let time = UnsafeMutablePointer<Double>.allocate(capacity: 1)
	
	/// Creates a `RisingTime`.
	/// - Parameters:
	///   - date: The date to set for the rise.
	///   - body: The celestial body that is rising.
	///   - longitude: The longitude of the location.
	///   - latitude: The latitude of the location.
	///   - altitude: The height above sea level. The default value is zero.
	///   - atmosphericPressure: The level of atmospheric pressure. The default value is zero.
	///   - atmosphericTemperature: The atmospheric temperature. The default value is zero.
	public init(date: Date,
				body: CelestialObject,
				longitude: Double,
				latitude: Double,
                altitude: Double = .zero,
				atmosphericPressure: Double = .zero,
				atmosphericTemperature: Double = .zero) {
		defer {
			geoPos.deallocate()
			time.deallocate()
		}
		geoPos[0] = longitude
		geoPos[1] = latitude
		geoPos[2] = altitude
        let value: Int32?

        switch body {
        case .asteroid(let asteroid):
            value = asteroid.value
        case .lunarNode(let lunarNode):
            value = lunarNode.value
        case .planet(let planet):
            value = planet.value
        default:
            value = nil
        }

		if let value = value {
			swe_rise_trans(date.julianDate(),
						   value,
						   nil,
						   SEFLG_SWIEPH,
						   1,
						   geoPos,
						   atmosphericPressure,
						   atmosphericTemperature,
						   time,
						   nil)
		}
		self.date = Date(julianDate: time[0])
	}
}
