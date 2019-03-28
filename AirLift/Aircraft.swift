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
    let cruiseSpeed: Double
    let maxSpeed: Double
    let maxRangeInt: Double
    let maxRangeExt: Double
    let maxLoad: Double
    let minCrew: Double
    let maxCrew: Double
     // STILL NEED TO ADD:  , paxSeated, paxLitters, slingloadCapacity, internalFuel, serviceCeiling, inFlightRefuel, runwayLength
    
    init(modelNumber: String, commonName: String, otherName: String, cruiseSpeed:Double, maxSpeed: Double, maxRangeInt: Double, maxRangeExt: Double, maxLoad: Double, minCrew: Double, maxCrew: Double) {
        self.modelNumber = modelNumber
        self.commonName = commonName
        self.otherName = otherName
        self.cruiseSpeed = cruiseSpeed
        self.maxSpeed = maxSpeed
        self.maxRangeInt = maxRangeInt
        self.maxRangeExt = maxRangeExt
        self.maxLoad = maxLoad
        self.minCrew = minCrew
        self.maxCrew = maxCrew
    }
    
    
    func toString() {
        print ("Aircraft Details: Model Number = \(modelNumber), Common Name = \(commonName), Other Name = \(otherName), Max Speed = \(maxSpeed), Max Range = \(maxRangeInt), Max Load = \(maxLoad), Min Crew = \(minCrew), Max Crew = \(maxCrew)")
    }
}
