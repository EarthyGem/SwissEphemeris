public protocol ZodiacCoordinate {
    var value: Double { get }
    var sign: Zodiac { get }
    var lunarMansion: LunarMansion { get }
    var degree: Double { get }
    var minute: Double { get }
    var second: Double { get }
    var roundedValue: Double { get }
    var decanate: Decanates { get }
    var formatted: String { get }
}

public extension ZodiacCoordinate {
    var sign: Zodiac {
        Zodiac(rawValue: Int(value / 30))!
    }
    
    var lunarMansion: LunarMansion {
        LunarMansion(rawValue: Int(value / 12.857142857142857)) ?? .batnAlHut
    }
    
    var degree: Double {
        value.truncatingRemainder(dividingBy: 30)
    }
    
    var minute: Double {
        value.truncatingRemainder(dividingBy: 1) * 60
    }
    
    var second: Double {
        minute.truncatingRemainder(dividingBy: 1) * 60
    }
    
    var roundedValue: Double {
        preciseRound(value, precision: .thousandths)
    }
    
    var decanate: Decanates {
        Decanates(rawValue: Int(value / 10)) ?? .cassiopeia
    }
    
   
    }


public extension ZodiacCoordinate {
	/// A readable `String` formatting the degree, sign, minute and second
    var formatted: String {
        "\(Int(degree))° \(sign.symbol) \(Int(minute)) \(decanate.formatted)"
	}
}

