//
//  TableViewAircrafts.swift
//  AirLift
//
//  Created by Trevor Hecht on 3/28/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TableViewAircrafts: UITableViewController {

    let backgroundImageView = UIImageView()
    var ref : DatabaseReference!
    //let modelNumbers = ["U145", "H123", "W323", "F350" ]
    var modelNumbers = [String]()
    let cNames = ["C-10","C124","C123"]
    let dNames = ["D130", "D123" ,"D823"]
    var twoDimensionalArray = [
        [String](),
        [String](),
        [String]()
    ]
    var caseNumb = 0
    var aircraftArray = [Aircraft]()
    static var baseballCard : Aircraft!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setBackground()
        //Sets a top right button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Common Name", style: .plain, target: self, action: #selector(handleShowAttribute))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    // fetch data from firebase database
    func getData(){
        ref = Database.database().reference()
        ref.child("ModelNumbers").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                
                let modelNumber = snap.key
                self.twoDimensionalArray[0].append(modelNumber)
                self.tableView.reloadData()
                
                //Collects data from firebase, fill array of aircrafts
                let snapValues = snap.value as? NSDictionary
                
                let inFlightRefuel = snapValues?["inFlightRefuel"] as? Bool ?? false
                
                let commonName = snapValues?["commonName"] as? String ?? ""
                let otherName = snapValues?["otherName"] as? String ?? ""
                let photoURL =  snapValues?["photo"] as? String ?? ""
                
                let cruiseSpeed = snapValues?["cruiseSpeed"]as? Double ?? 0
                let maxSpeed = snapValues?["maxSpeed"] as? Double ?? 0
                let maxRangeInt = snapValues?["maxRangeInt"] as? Double ?? 0
                let maxRangeExt = snapValues?["maxRangeExt"] as? Double ?? 0
                let maxLoad = snapValues?["maxLoad"] as? Double ?? 0
                let minCrew = snapValues?["minCrew"] as? Double ?? 0
                let maxCrew = snapValues?["maxCrew"] as? Double ?? minCrew
                let paxSeatedMin = snapValues?["paxSeatedMin"] as? Double ?? 0
                let paxSeatedMax = snapValues?["paxSeatedMax"] as? Double ?? paxSeatedMin
                let paxLitters = snapValues?["paxLitters"] as? Double ?? 0
                let slingloadCapacity = snapValues?["slingloadCapacity"] as? Double ?? 0
                let internalFuel = snapValues?["internalFuel"] as? Double ?? 0
                let serviceCeiling = snapValues?["serviceCeiling"] as? Double ?? 0
                let takeoffRunway = snapValues?["takeoffRunway"] as? Double ?? 0
                let landingRunway = snapValues?["landingRunway"] as? Double ?? 0
                
                
            
                //Add each element of each child to Aircraft array
                self.aircraftArray.append(Aircraft.init(modelNumber: modelNumber, commonName: commonName,otherName: otherName, cruiseSpeed: cruiseSpeed, maxSpeed: maxSpeed, maxRangeInt: maxRangeInt, maxRangeExt: maxRangeExt, maxLoad: maxLoad, crew: minCrew...maxCrew, paxSeated: paxSeatedMin...paxSeatedMax, paxLitters: paxLitters, slingloadCapacity: slingloadCapacity, internalFuel: internalFuel, serviceCeiling: serviceCeiling, inFlightRefuel: inFlightRefuel, takeoffRunway: takeoffRunway, landingRunway: landingRunway, photoURL: photoURL))
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //        ref?.child("ModelNumbers").observe(.value, with: {(snapshot) in
        //            //takes all Model Numbers
        //            //self.modelNumbers.append(snapshot.key)
        //            self.twoDimensionalArray[0].append(snapshot.key)
        //        })
    }
    
    // On click Back function
    
    //  On click Show Attribute function
    @objc func handleShowAttribute(){
        var indexPathReload = [IndexPath]()
        for section in twoDimensionalArray.indices{
            for row in twoDimensionalArray[section].indices{
                let indexPath = IndexPath(row: row, section: section)
                indexPathReload.append(indexPath)
            }
        }
        //shuffling through the attributes everytime you click the (Show Attribute) button
        if caseNumb < 5{
            caseNumb += 1
        }else{
            caseNumb = 0
        }
        tableView.reloadRows(at: indexPathReload, with: .fade)
    }
    
    
    // CODE FOR HEADERS *****************************************************************************************
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let label = UILabel()
    //        label.text = "Header"
    //        label.backgroundColor = UIColor.lightGray
    //        return label
    //    }
    //    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 36
    //    }
    //******************************************************************************************************
    
    
    // Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        //return twoDimensionalArray.count
        return 1
    }
    
    // Number of Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArray[section].count
    }
    
    //Handles the conntent of each cell for ever row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let modelNumber = twoDimensionalArray[indexPath.section][indexPath.row]
        
        
        cell.textLabel?.text = modelNumber
        
        //shuffling through the attributes everytime you click the (Show Attribute) button
        switch caseNumb{
        case 0:
            cell.textLabel?.text = modelNumber
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Common Name", style: .plain, target: self, action: #selector(handleShowAttribute))
        case 1:
            cell.textLabel?.text = "\(modelNumber) Common Name: \(aircraftArray[indexPath.row].commonName)" //Still need to add actual attribute
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Other Name", style: .plain, target: self, action: #selector(handleShowAttribute))
        case 2:
            cell.textLabel?.text = "\(modelNumber) Other Name: \(aircraftArray[indexPath.row].otherName)"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Max Speed", style: .plain, target: self, action: #selector(handleShowAttribute))
        case 3:
            cell.textLabel?.text = "\(modelNumber) Max Speed (mph):  \(aircraftArray[indexPath.row].maxSpeed)"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Max Range Int", style: .plain, target: self, action: #selector(handleShowAttribute))
        case 4:
            cell.textLabel?.text = "\(modelNumber) Max Range Int (mi):  \(aircraftArray[indexPath.row].maxRangeInt)"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Max Range Ext", style: .plain, target: self, action: #selector(handleShowAttribute))
        case 5:
            cell.textLabel?.text = "\(modelNumber) Max Range Ext (mi):  \(aircraftArray[indexPath.row].maxRangeExt)"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleShowAttribute))
        default:
            cell.textLabel?.text = modelNumber
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Attribute", style: .plain, target: self, action: #selector(handleShowAttribute))
        }
        
        
        let cellBack = UIView()
        cellBack.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = cellBack
        return cell
    }
    
    //Handles onClick for each cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showAlertYesNo(title: "Selected Aircraft", message: "View the model: \(aircraftArray[indexPath.row].modelNumber)?", row: indexPath.row)
    }
    //ALERT for onClick cell
    func showAlertYesNo(title : String, message: String, row: Int){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //Click OK
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            //Open Segue with Aircraft Data
            TableViewAircrafts.baseballCard = self.aircraftArray[row]
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vcInfo") as? ViewControllerInfoCard {
                //ViewControllerAircraftInfo.aircraft = self.aircraftArray[row]
                self.present(vc, animated: true, completion: nil)
            }
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func setBackground(){
        //title stuff
               navigationItem.title = "AirLift"
              navigationController?.navigationBar.prefersLargeTitles = true
        //       let label = UILabel()
        //label.textColor = UIColor.white
        //label.text = "Model Number"
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(sendBack))
        
        
//        let backButton = UIImage(named: "BackButton")
//        let myInsets = UIEdgeInsets(top: 0.1, left: 0.1, bottom: 0.1, right: 0.1)
//        backButton?.resizableImage(withCapInsets: myInsets)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButton, style: .plain, target: self, action: #selector(sendBack))
        
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0/255, green: 90/255, blue: 200/255, alpha: 1)
        
        tableView.backgroundColor = UIColor.clear
        backgroundImageView.image = UIImage(named: "Background1")
        tableView.backgroundView = backgroundImageView
    }
    

    
    @objc func sendBack(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vcHome") as? ViewControllerHomePage {
            self.present(vc, animated: true, completion: nil)
        }
    }

}
