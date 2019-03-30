//
//  ViewControllerTable.swift
//  AirLift
//
//  Created by Trevor Hecht on 3/29/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//
// Nessasary that I set the delegates for TableView and SearchBar to this UIView, so I can use them inside of this view
//



import UIKit
import FirebaseDatabase

class ViewControllerTable: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!

    var ref : DatabaseReference!
    var aircraftArray = [Aircraft]()
    var currentAircraftArray = [Aircraft]()
    static var baseballCard : Aircraft!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
    }
    
   
    
//SEARCH BAR SET UP ******************************************************************************************
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            currentAircraftArray = aircraftArray
            table.reloadData()
            return
        }
        currentAircraftArray = aircraftArray.filter({ (aircraft) -> Bool in
            return (aircraft.modelNumber.lowercased().contains(searchText.lowercased()) ||  aircraft.commonName.lowercased().contains(searchText.lowercased()))
        })
        table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope{
        case 0:
            currentAircraftArray = aircraftArray
        case 1:
            currentAircraftArray = aircraftArray.filter { (aircraft) -> Bool in
            //This is just for testing. Eventually I will check to see if airlift == true
                return (aircraft.modelNumber == ("CH-47D"))
            }
        default:
            break
        }
        table.reloadData()
    }
    
//returns the keyboard when searching 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    

    
    
//TABLE SET UP ***********************************************************************************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAircraftArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else{
            return UITableViewCell()
        }
        cell.commonNameLB.text = currentAircraftArray[indexPath.row].commonName
        cell.modelNumberLB.text = currentAircraftArray[indexPath.row].modelNumber
        cell.aircraftPhoto.image = UIImage(named: "testImage")
        return cell
    }
    
//sets size of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    
// GET DATA FROM FIREBASE ************************************************************************************
    
    func getData(){
        ref = Database.database().reference()
        ref.child("ModelNumbers").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                
                let modelNumber = snap.key
                self.table.reloadData()
                
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
                self.currentAircraftArray = self.aircraftArray
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
