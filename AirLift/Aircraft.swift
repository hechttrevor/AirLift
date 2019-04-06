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
    
    let cruiseSpeed: Int
    let maxSpeed: Int
    let maxRangeInt: Int
    let maxRangeExt: Int
    let maxLoad: Int
    let paxLitters: Int
    let singleLoadCapacity: Int
    let internalFuel: Int
    let serviceCeiling: Int
    let takeoffRunway: Int
    let landingRunway: Int

    let crew: ClosedRange<Int>
    let paxSeated: ClosedRange<Int> // closed ranges have 3 dots between values a...b
    
    let inFlightRefuel: Bool
    let verticalLift: Bool
    
    var attribute = [Int]()
    
    
    
    // STILL NEED TO ADD: VerticalAirlift : Bool 
    
    init(modelNumber: String, commonName: String, otherName: String, cruiseSpeed:Int, maxSpeed: Int, maxRangeInt: Int, maxRangeExt: Int, maxLoad: Int, crew: ClosedRange<Int>, paxSeated: ClosedRange<Int>, paxLitters: Int, singleLoadCapacity: Int, internalFuel: Int, serviceCeiling: Int, inFlightRefuel: Bool, takeoffRunway: Int, landingRunway: Int, photoURL: String?, verticalLift: Bool, attribute: [Int]) {
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
        self.singleLoadCapacity = singleLoadCapacity
        self.internalFuel = internalFuel
        self.serviceCeiling = serviceCeiling
        self.inFlightRefuel = inFlightRefuel
        self.takeoffRunway = takeoffRunway
        self.landingRunway = landingRunway
        self.photoURL = photoURL
        self.verticalLift = verticalLift
        self.attribute = attribute
    }
    
    
    func toString() {
        print ("Aircraft Details: Model Number = \(modelNumber), Common Name = \(commonName), Other Name = \(otherName), Max Speed = \(maxSpeed), Max Range = \(maxRangeInt), Max Load = \(maxLoad)")
    }
}
