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
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var clearAll: UIButton!
    @IBOutlet weak var seeNumButton: UIButton!
    
    static var filterRangeArray = [filters]()
    
    var aircraftArray =  [Aircraft]()
    static var fixedArray = [Aircraft]() //static version of aircraftArray
    static var finalArray = [Aircraft]() //sent back to main tableView
    static var currentArray = [Aircraft]() //used for searching in main tableView

    static var fullReload = true
    static var firstTime = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Should only run the first time you get to filterView
        if ViewControllerFitler.firstTime{
            ViewControllerFitler.fixedArray = aircraftArray
            getMinMaxFromAircraftArray()
            ViewControllerFitler.firstTime = false
        }
        if ViewControllerFitler.fullReload{
            resetAircraftArrays()
        }
        checkAllClear(clearAllButton: clearAll)
        compareArrays(button: seeNumButton)
        seeNumButton.setTitle("See \(ViewControllerFitler.finalArray.count) aircrafts", for: .normal)
    }
    
    
    
//onClick mainButton ****************************************************************************************************
    @IBAction func onClickSeeAircrafts(_ sender: Any) {
        ViewControllerFitler.currentArray = ViewControllerFitler.finalArray
        ViewControllerTable.isFiltered = true
    }
    
//clear button functions**************************************************************************************************
    @IBAction func onClickClearAll(_ sender: UIButton) {
        resetAircraftArrays()
        resestFilterArray()
        ViewControllerFitler.fullReload = true
        table.reloadData()
    }
    //Sets the cleared array back to original array
    func clearButtonClicked(button: UIButton, clearAllButton: UIButton, filterName: String, index: Int){
        ViewControllerFitler.filterRangeArray[index].isCleared = true
        //reset aircraft array
        ViewControllerFitler.filterRangeArray[index].aircraftArray = ViewControllerFitler.fixedArray
        //Reset filter array
        ViewControllerFitler.filterRangeArray[index].curMin = ViewControllerFitler.filterRangeArray[index].setMin
       
        compareArrays(button: button)
        checkAllClear(clearAllButton: clearAllButton)
    }
    
    //Hide Clear all button if all cells are cleared
    func checkAllClear(clearAllButton: UIButton){
        var notAllCleared = true
        for i in 0...ViewControllerFitler.filterRangeArray.count - 1{
            if !ViewControllerFitler.filterRangeArray[i].isCleared {
                notAllCleared = false
            }
        }
        if notAllCleared{
            clearAllButton.isHidden = true
            ViewControllerFitler.fullReload = true
        }
    }
    
// Filtering Functions (returns a final array with the aircrafts that have the right values)******************************
    func resetAircraftArrays(){
        ViewControllerFitler.finalArray = ViewControllerFitler.fixedArray
        for i in 0...ViewControllerFitler.filterRangeArray.count - 1{
            ViewControllerFitler.filterRangeArray[i].aircraftArray =  ViewControllerFitler.fixedArray
        }
        seeNumButton.setTitle("See \(ViewControllerFitler.finalArray.count) aircrafts", for: .normal)
        clearAll.isHidden = true
    }
    
    func resestFilterArray(){
        for index in ViewControllerFitler.filterRangeArray{
            index.curMin = index.setMin
            index.curMax = index.setMax
            index.isCleared = true
        }
    }
    
    
//rangeSlider listener functions *****************************************************************************************
    //stores min/max values for table.reloadData()
    func updateCurMinMax(curFilter: filters){
        var count = 0
        for index in ViewControllerFitler.filterRangeArray{
            if index.filterName == curFilter.filterName{
                ViewControllerFitler.filterRangeArray[count] = curFilter
            }
            count += 1
        }
        ViewControllerFitler.fullReload = false
    }
    //changes the filter's AIRCRAFT ARRAY
    func setNumAircrafts(curFilter: filters, button: UIButton, index: Int){
        ViewControllerFitler.filterRangeArray[index].isCleared = false
        ViewControllerFitler.filterRangeArray[index].aircraftArray = ViewControllerFitler.fixedArray.filter { (aircraft) -> Bool in
            return (aircraft.attribute[index] >= curFilter.curMin && aircraft.attribute[index] <= curFilter.curMax)
        }
        compareArrays(button: button)
    }
    
    
    //does the actual comparing of aircraft arrays
    func compareArrays(button: UIButton){
        //compares all arrays and outputs array that shares values in every array
        ViewControllerFitler.finalArray = ViewControllerFitler.filterRangeArray[0].aircraftArray.filter(ViewControllerFitler.filterRangeArray[1].aircraftArray.contains)
        for i in 2...ViewControllerFitler.filterRangeArray.count - 1{
            
            ViewControllerFitler.finalArray = ViewControllerFitler.finalArray.filter(ViewControllerFitler.filterRangeArray[i].aircraftArray.contains)
        }
        setButton(button: button)
    }
    
    //sets the main button with number of aircraft options
    func setButton(button: UIButton){
        if ViewControllerFitler.finalArray.count > 1{
            button.setTitle("See \(ViewControllerFitler.finalArray.count) Aircrafts", for: .normal)
        } else if ViewControllerFitler.finalArray.count == 1{
            button.setTitle("See \(ViewControllerFitler.finalArray.count) Aircraft", for: .normal)
        } else if ViewControllerFitler.finalArray.count == 0{
            button.setTitle("No Matching Aircraft", for: .normal)
        }
    }

    
//TABLE VIEW SET UP ***********************************************************************************************
    //set row count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewControllerFitler.filterRangeArray.count
    }
    //add everything in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCellSlider else{
            return UITableViewCell()
        }
        //give the cell class some values
        cell.curFilter = ViewControllerFitler.filterRangeArray[indexPath.row]
        cell.fixedMin = cell.curFilter.setMin
        cell.fixedMax = cell.curFilter.setMax
        cell.filterName = cell.curFilter.filterName
        cell.index = indexPath.row
        
        //initialize rangeSlider
        cell.rangeSlider.minimumValue = Double(cell.fixedMin)
        cell.rangeSlider.maximumValue = Double(cell.fixedMax)
        cell.rangeSlider.stepValue =  10 * (round(Double((cell.fixedMax - cell.fixedMin)/15)))/10
        cell.filterNames.text = cell.filterName
        
        //Set reference to buttons
        cell.seeNumButton = seeNumButton
        cell.clearAll = clearAll
        
        //check whether or not to show clear button
        if ViewControllerFitler.filterRangeArray[indexPath.row].isCleared {
            cell.clearButton.isHidden = true
        }else{
            cell.clearButton.isHidden = false
        }
        
        //This determines if we reset to original state OR recent state
        if ViewControllerFitler.fullReload{
            print("fulll relaod")
            cell.rangeSlider.lowerValue = Double(ViewControllerFitler.filterRangeArray[indexPath.row].setMin)
            cell.rangeSlider.upperValue = Double(ViewControllerFitler.filterRangeArray[indexPath.row].setMax)
            cell.curMin.text = "\(ViewControllerFitler.filterRangeArray[indexPath.row].setMin)"
            cell.curMax.text = "\(ViewControllerFitler.filterRangeArray[indexPath.row].setMax)"
        }else{
            print("recent reload")
            cell.rangeSlider.lowerValue = Double(ViewControllerFitler.filterRangeArray[indexPath.row].curMin)
            cell.rangeSlider.upperValue = Double(ViewControllerFitler.filterRangeArray[indexPath.row].curMax)
            cell.curMin.text = "\(ViewControllerFitler.filterRangeArray[indexPath.row].curMin)"
            cell.curMax.text = "\(ViewControllerFitler.filterRangeArray[indexPath.row].curMax)"
        }
        return cell
    }
    //sets size of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    
//CALCULATE ALL RANGES **************************************************************************************************
    func getMinMaxFromAircraftArray(){
  
        //Initialize attributes min/max to first val in array
        let cruiseSpeed = aircraftArray[0].cruiseSpeed
        let maxSpeed = aircraftArray[0].maxSpeed
        let maxRangeInt = aircraftArray[0].maxRangeInt
        let maxRangeExt = aircraftArray[0].maxRangeExt
        let maxLoad = aircraftArray[0].maxLoad
        let paxLitters = aircraftArray[0].paxLitters
        let singleLoadCapacity = aircraftArray[0].singleLoadCapacity
        let internalFuel = aircraftArray[0].internalFuel
        let serviceCeiling = aircraftArray[0].serviceCeiling
        let takeoffRunway = aircraftArray[0].takeoffRunway
        let landingRunway = aircraftArray[0].landingRunway
        // TO DO:
        //   let crew: ClosedRange<Int>
        //  let paxSeated: ClosedRange<Int>
        //let inFlightRefuel: Bool
         //  let verticalLift: Bool
        
        //Set the filter arrays with the min and max of all aircraft attributes
        ViewControllerFitler.filterRangeArray.append(filters(filterName: "Cruise Speed (mph)", setMin: cruiseSpeed, setMax: cruiseSpeed, curMin: cruiseSpeed, curMax: cruiseSpeed, aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters(filterName: "Max Speed (mph)", setMin: maxSpeed, setMax: maxSpeed, curMin: maxSpeed,curMax: maxSpeed,aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters( filterName: "Max Range Int (mi)", setMin: maxRangeInt, setMax: maxRangeInt, curMin: maxRangeInt,curMax: maxRangeInt, aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters(filterName: "Max Range Ext (mi)", setMin: maxRangeExt, setMax: maxRangeExt, curMin: maxRangeExt,curMax: maxRangeExt, aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters(filterName: "Max Load (lbs)", setMin: maxLoad, setMax: maxLoad, curMin: maxLoad,curMax: maxLoad, aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters(filterName: "Pax Litters", setMin: paxLitters, setMax: paxLitters, curMin: paxLitters,curMax: paxLitters, aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters(filterName: "Single Load Capacity", setMin: singleLoadCapacity, setMax: singleLoadCapacity, curMin: singleLoadCapacity,curMax: singleLoadCapacity, aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters( filterName: "Internal Fuel",setMin: internalFuel, setMax: internalFuel, curMin: internalFuel, curMax: internalFuel, aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters( filterName: "Service Ceiling",setMin: serviceCeiling, setMax: serviceCeiling, curMin: serviceCeiling, curMax: serviceCeiling, aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters( filterName: "Take Off Runway (ft)",setMin: takeoffRunway, setMax: takeoffRunway, curMin: takeoffRunway, curMax: landingRunway, aircraftArray: aircraftArray, isCleared: true))
        ViewControllerFitler.filterRangeArray.append(filters( filterName: "Landing Runway (ft)",setMin: landingRunway, setMax: landingRunway, curMin: landingRunway, curMax: landingRunway, aircraftArray: aircraftArray, isCleared: true))
        
        
    //these loops are to make sure the first value are not nullZ
        var count = 0
        for index in ViewControllerFitler.filterRangeArray {
            for aircraftItorator in (0...aircraftArray.count-2){
                if index.curMin != -1{ break}
                //if value is not null, we're set
                else{
                    index.curMin = aircraftArray[aircraftItorator + 1].attribute[count]
                    index.setMin = aircraftArray[aircraftItorator + 1].attribute[count]
                }
            }
            count += 1
        }
        
        
    //Set the min and max for each attribute
        count = 0
        for index in ViewControllerFitler.filterRangeArray {
            for aircraftItorator in aircraftArray{
                if aircraftItorator.attribute[count] < index.curMin && aircraftItorator.attribute[count] != -1 {
                    index.curMin = aircraftItorator.attribute[count]
                    index.setMin = aircraftItorator.attribute[count]
                    }else if aircraftItorator.attribute[count] > index.curMax{
                        index.curMax = aircraftItorator.attribute[count]
                        index.setMax = aircraftItorator.attribute[count]
                }
            }
            count += 1
        }
    }
}
        

//To create a range with a name, this ends up showing up in each cell
class filters{
    var filterName: String
    var setMin: Int
    var setMax: Int
    var curMin: Int
    var curMax: Int
    var aircraftArray: [Aircraft]
    var isCleared: Bool
    
    init(filterName: String, setMin: Int, setMax: Int, curMin: Int, curMax: Int, aircraftArray: [Aircraft], isCleared: Bool){
        self.filterName = filterName
        self.setMin = setMin
        self.setMax = setMax
        self.curMin = curMin
        self.curMax = curMax
        self.aircraftArray = aircraftArray
        self.isCleared = isCleared
    }
}
