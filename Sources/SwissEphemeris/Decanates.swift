//
//  Decanates.swift
//
//
//  Created by Vincent Smithers on 27.03.21.
//

import Foundation

///
public enum Decanates: Int {
    // Aries
    case triangulum
    case eridanus
    case perseus

    // Taurus
    case lepus
    case orion
    case auriga

    // Gemini
    case ursaMinor
    case canisMajor
    case ursaMajor

    // Cancer
    case canisMinor
    case hydra
    case argo

    // Leo
    case crater
    case centaurus
    case corvus

    // Virgo
    case bootes
    case hercules
    case coronaBorealis

    // Libra
    case serpens
    case draco
    case lupus

    // Scorpio
    case ophiuchus
    case ara
    case coronaAustralis

    // Sagittarius
    case lyra
    case aquila
    case sagitta

    // Capricorn
    case cygnus
    case delphinus
    case piscesAustralis

    // Aquarius
    case equuleus
    case pegasus
    case cetus

    // Pisces
    case cepheus
    case andromeda
    case cassiopeia

    public var formatted: String {
        switch self {
        // Aries
        case .triangulum:
            return "Triangulum"
        case .eridanus:
            return "Eridanus"
        case .perseus:
            return "Perseus"

        // Taurus
        case .lepus:
            return "Lepus"
        case .orion:
            return "Orion"
        case .auriga:
            return "Auriga"

        // Gemini
        case .ursaMinor:
            return "Ursa Minor"
        case .canisMajor:
            return "Canis Major"
        case .ursaMajor:
            return "Ursa Major"

        // Cancer
        case .canisMinor:
            return "Canis Minor"
        case .hydra:
            return "Hydra"
        case .argo:
            return "Argo"

        // Leo
        case .crater:
            return "Crater"
        case .centaurus:
            return "Centaurus"
        case .corvus:
            return "Corvus"

        // Virgo
        case .bootes:
            return "Bootes"
        case .hercules:
            return "Hercules"
        case .coronaBorealis:
            return "Corona Borealis"

        // Libra
        case .serpens:
            return "Serpens"
        case .draco:
            return "Draco"
        case .lupus:
            return "Lupus"

        // Scorpio
        case .ophiuchus:
            return "Ophiuchus"
        case .ara:
            return "Ara"
        case .coronaAustralis:
            return "Corona Australis"

        // Sagittarius
        case .lyra:
            return "Lyra"
        case .aquila:
            return "Aquila"
        case .sagitta:
            return "Sagitta"

        // Capricorn
        case .cygnus:
            return "Cygnus"
        case .delphinus:
            return "Delphinus"
        case .piscesAustralis:
            return "Pisces Australis"

        // Aquarius
        case .equuleus:
            return "Equuleus"
        case .pegasus:
            return "Pegasus"
        case .cetus:
            return "Cetus"

        // Pisces
        case .cepheus:
            return "Cepheus"
        case .andromeda:
            return "Andromeda"
        case .cassiopeia:
            return "Cassiopeia"
        }
    }
}
