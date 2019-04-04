//
//  ViewControllerFitler.swift
//  AirLift
//
//  Created by Trevor Hecht on 3/29/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import SwiftRangeSlider


class ViewControllerFitler: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
  
   
    @IBOutlet var seeNumButton: UIButton!
    var filterRangeArray = [filters]()
    var aircraftArray =  [Aircraft]()// ViewControllerTable.filterAircraftArray
    static var currentArray = [Aircraft]()
    static var fixedArray = [Aircraft]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewControllerFitler.currentArray = aircraftArray
        ViewControllerFitler.fixedArray = aircraftArray
        getMinMaxFromAircraftArray()

        seeNumButton?.setTitle("See \(ViewControllerFitler.currentArray.count) aircrafts", for: .normal)
//        print(currentArray.count)
//        print(aircraftArray.count)
    }
    

    func setNumAircrafts(curMin: Int,curMax: Int){
        
        //FIGURE OUT HOW TO MAKE THIS WORK FOR EACH ATTRIBUTE
        ViewControllerFitler.currentArray = ViewControllerFitler.fixedArray.filter { (aircraft) -> Bool in
            return (aircraft.cruiseSpeed >= curMin && aircraft.cruiseSpeed <= curMax)
             //ViewControllerFitler.currentArray.append(aircraftArray(count))
        }
        print(ViewControllerFitler.currentArray.count)
        print(ViewControllerFitler.currentArray)
        
        //TO DO!! figure out why this isn't working
        seeNumButton?.setTitle("yarg", for: .normal)
    }

    
    
//TABLE VIEW SET UP ***********************************************************************************************
    //set row count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterRangeArray.count
    }
    //add everything in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCellSlider else{
            return UITableViewCell()
        }
        let range = filterRangeArray[indexPath.row].filterRange.upperBound - filterRangeArray[indexPath.row].filterRange.lowerBound
        //round the range to the nearest 10, then divide by 10
        let stepValue = 10*(round(Double(range/10)))/10
        //Set up our range slider
        cell.rangeSlider.minimumValue = Double(filterRangeArray[indexPath.row].filterRange.lowerBound)
        cell.rangeSlider.maximumValue = Double(filterRangeArray[indexPath.row].filterRange.upperBound)
        cell.rangeSlider.lowerValue = Double(filterRangeArray[indexPath.row].filterRange.lowerBound)
        cell.rangeSlider.upperValue = Double(filterRangeArray[indexPath.row].filterRange.upperBound)
        cell.rangeSlider.stepValue =  stepValue
        //Set up our text labels
        cell.filterName.text = filterRangeArray[indexPath.row].filterName
        cell.curMin.text = "\(filterRangeArray[indexPath.row].filterRange.lowerBound)"
        cell.curMax.text = "\(filterRangeArray[indexPath.row].filterRange.upperBound)"

        return cell
    }
    //sets size of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //CALCULATE ALL RANGES ***********************************************************************************************
    func getMinMaxFromAircraftArray(){
        //Initialize attributes min/max to first val in array
        var cruiseSpeedMin = aircraftArray[0].cruiseSpeed, cruiseSpeedMax = cruiseSpeedMin
        var maxSpeedMin =  aircraftArray[0].maxSpeed, maxSpeedMax = maxSpeedMin
        var maxRangeIntMin = aircraftArray[0].maxRangeInt, maxRangeIntMax = maxRangeIntMin
        var maxRangeExtMin = aircraftArray[0].maxRangeExt, maxRangeExtMax = maxRangeExtMin
        var maxLoadMin = aircraftArray[0].maxLoad, maxLoadMax =  maxLoadMin
        var paxLittersMin = aircraftArray[0].paxLitters, paxLittersMax = paxLittersMin
        var singleLoadCapacityMin = aircraftArray[0].singleLoadCapacity, singleLoadCapacityMax = singleLoadCapacityMin
        var internalFuelMin = aircraftArray[0].internalFuel, internalFuelMax = internalFuelMin
        // TO DO:   var serviceCeilingMin: Double
        //    var takeoffRunwayMin: Double
        //    var landingRunwayMin: Double
        //   let crew: ClosedRange<Int>
        //  let paxSeated: ClosedRange<Int>
        //let inFlightRefuel: Bool
         //  let verticalLift: Bool
    //these loops are to make sure the first value are not null
        for index in (1...aircraftArray.count-1){
            if cruiseSpeedMin != -1{break}
            else{cruiseSpeedMin = aircraftArray[index+1].cruiseSpeed}
        }
        for index in (1...aircraftArray.count-1){
            if maxRangeIntMin != -1{break}
            else{maxRangeIntMin = aircraftArray[index+1].maxRangeInt}
        }
        for index in (1...aircraftArray.count-1){
            if maxRangeExtMin != -1{break}
            else{maxRangeExtMin = aircraftArray[index+1].maxRangeExt}
        }
        for index in (1...aircraftArray.count-1){
            if maxLoadMin != -1{break}
            else{maxLoadMin = aircraftArray[index+1].maxLoad}
        }
        for index in (1...aircraftArray.count-1){
            if paxLittersMin != -1{break}
            else{paxLittersMin = aircraftArray[index+1].paxLitters}
        }
        for index in (1...aircraftArray.count-1){
            if singleLoadCapacityMin != -1{break}
            else{singleLoadCapacityMin = aircraftArray[index+1].singleLoadCapacity}
        }
        for index in (1...aircraftArray.count-1){
            if internalFuelMin != -1{break}
            else{internalFuelMin = aircraftArray[index+1].internalFuel}
        }
        
    //Set the min and max for each attribute
        for index in aircraftArray{
            if (index.cruiseSpeed != -1) && (index.cruiseSpeed < cruiseSpeedMin) {
                cruiseSpeedMin = index.cruiseSpeed
            }else if index.cruiseSpeed > cruiseSpeedMax{
                cruiseSpeedMax = index.cruiseSpeed
            }
            else if (index.maxSpeed != -1) && (index.maxSpeed < maxSpeedMin){
                maxSpeedMin = index.maxSpeed
            }else if index.maxSpeed > maxSpeedMax{
                maxSpeedMax = index.maxSpeed
            }else if (index.maxRangeInt != -1) && (index.maxRangeInt < maxRangeIntMin){
                maxRangeIntMin = index.maxRangeInt
            }else if index.maxRangeInt > maxRangeIntMax{
                maxRangeIntMax = index.maxRangeInt
            }else if (index.maxRangeExt != -1) && (index.maxRangeExt < maxRangeExtMin){
                maxRangeExtMin = index.maxRangeExt
            }else if index.maxRangeExt > maxRangeExtMax{
                maxRangeExtMax = index.maxRangeExt
            }else if (index.maxLoad != -1) && (index.maxLoad < maxLoadMin){
                maxLoadMin = index.maxLoad
            }else if index.maxLoad > maxLoadMax{
                maxLoadMax = index.maxLoad
            }else if (index.paxLitters != -1) && (index.paxLitters < paxLittersMin){
                paxLittersMin = index.paxLitters
            }else if index.paxLitters > paxLittersMax{
                paxLittersMax = index.paxLitters
            }else if (index.singleLoadCapacity != -1) && (index.singleLoadCapacity < singleLoadCapacityMin){
                singleLoadCapacityMin = index.singleLoadCapacity
            }else if index.singleLoadCapacity > singleLoadCapacityMax{
                singleLoadCapacityMax = index.singleLoadCapacity
            }else if (index.internalFuel != -1) && (index.internalFuel < internalFuelMin){
                internalFuelMin = index.internalFuel
            }else if index.internalFuel > internalFuelMax{
                internalFuelMax = index.internalFuel
            }
        }
        //Set the filter arrays with the min and max of all aircraft attributes
        filterRangeArray.append(filters(filterRange: cruiseSpeedMin...cruiseSpeedMax, filterName: "Cruise Speed (mph)"))
        filterRangeArray.append(filters(filterRange: maxSpeedMin...maxSpeedMax, filterName: "Max Speed (mph)"))
        filterRangeArray.append(filters(filterRange: maxRangeIntMin...maxRangeIntMax, filterName: "Max Range Int (mi)"))
        filterRangeArray.append(filters(filterRange: maxRangeExtMin...maxRangeExtMax, filterName: "Max Range Ext (mi)"))
        filterRangeArray.append(filters(filterRange: maxLoadMin...maxLoadMax, filterName: "Max Load (lbs)"))
        filterRangeArray.append(filters(filterRange: paxLittersMin...paxLittersMax, filterName: "Pax Litters"))
        filterRangeArray.append(filters(filterRange: singleLoadCapacityMin...singleLoadCapacityMax, filterName: "Single Load Capacity"))
        //filterRangeArray.append(filters(filterRange: internalFuelMin...internalFuelMax, filterName: "Internal Fuel"))
    }
}

class filters{
    let filterRange: ClosedRange<Int>
    var filterName: String
    
    init(filterRange: ClosedRange<Int>,filterName: String){
        self.filterRange = filterRange
        self.filterName = filterName
    }
}
