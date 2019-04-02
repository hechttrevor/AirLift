//
//  Aircraft.swift
//  RescueApp
//
//  Created by Trevor Hecht on 3/22/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//
// This class is used for the Aircraft object.
// It contains all of filters that the user can use to search of an aircraft.

import UIKit

class Aircraft: NSObject { //modelNumber, commonName, otherName, cruiseSpeed, maxSpeed, maxRangeInt, maxRangeExt maxLoad, minCrew, maxCrew, paxSeated, paxLitters, slingloadCapacity, internalFuel, serviceCeiling, inFlightRefuel, runwayLength
    
    let modelNumber: String
    let commonName: String
    let otherName: String
    let photoURL: String?
    
    let cruiseSpeed: Double
    let maxSpeed: Double
    let maxRangeInt: Double
    let maxRangeExt: Double
    let maxLoad: Double
    let paxLitters: Double
    let slingloadCapacity: Double
    let internalFuel: Double
    let serviceCeiling: Double
    let takeoffRunway: Double
    let landingRunway: Double

    let crew: ClosedRange<Double>
    let paxSeated: ClosedRange<Double> // closed ranges have 3 dots between values a...b
    
    let inFlightRefuel: Bool
    let verticalLift: Bool
    
    
    
    // STILL NEED TO ADD: VerticalAirlift : Bool 
    
    init(modelNumber: String, commonName: String, otherName: String, cruiseSpeed:Double, maxSpeed: Double, maxRangeInt: Double, maxRangeExt: Double, maxLoad: Double, crew: ClosedRange<Double>, paxSeated: ClosedRange<Double>, paxLitters: Double, slingloadCapacity: Double, internalFuel: Double, serviceCeiling: Double, inFlightRefuel: Bool, takeoffRunway: Double, landingRunway: Double, photoURL: String?, verticalLift: Bool) {
        self.modelNumber = modelNumber
        self.commonName = commonName
        self.otherName = otherName
        self.cruiseSpeed = cruiseSpeed
        self.maxSpeed = maxSpeed
        self.maxRangeInt = maxRangeInt
        self.maxRangeExt = maxRangeExt
        self.maxLoad = maxLoad
        self.crew = crew
        self.paxSeated = paxSeated
        self.paxLitters = paxLitters
        self.slingloadCapacity = slingloadCapacity
        self.internalFuel = internalFuel
        self.serviceCeiling = serviceCeiling
        self.inFlightRefuel = inFlightRefuel
        self.takeoffRunway = takeoffRunway
        self.landingRunway = landingRunway
        self.photoURL = photoURL
        self.verticalLift = verticalLift
    }
    
    
    func toString() {
        print ("Aircraft Details: Model Number = \(modelNumber), Common Name = \(commonName), Other Name = \(otherName), Max Speed = \(maxSpeed), Max Range = \(maxRangeInt), Max Load = \(maxLoad)")
    }
}
