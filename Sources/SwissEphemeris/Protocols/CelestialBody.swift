//
//  CelestialBody.swift
//  
//
//  Created by Vincent Smithers on 11.02.21.
//

import Foundation

/// Models a planet, moon, astroid, star or celestial body both real or imaginary.
public protocol CelestialBody: CaseIterable {
	/// The IPL body number.
	var value: Int32 { get }
}
