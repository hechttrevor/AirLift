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
    var fullArray = [Aircraft]()
    static var isFiltered = false

    var infoCard: Aircraft!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setFloatingButtons()
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "filterSegue"){
            let vc = segue.destination as! ViewControllerFitler
            vc.aircraftArray = self.fullArray
        }
        if (segue.identifier == "infoSegue"){
            let vc = segue.destination as! ViewControllerInfoCard
            vc.aircraft = self.infoCard
        }
        
    }
    
    
//FLOATING BUTTONS SET UP ************************************************************************************************
    func setFloatingButtons(){
    //backButton set up
        let backButton = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width/2 - 75, y: self.view.frame.height - 50), size: CGSize(width: 75, height: 35)))
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        backButton.backgroundColor = UIColor(red: 20/255, green: 110/255, blue: 230/255, alpha: 1)
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = UIColor.white.cgColor
        
    //filterButton set up
        let filterButton = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width/2 , y: self.view.frame.height - 50), size: CGSize(width: 75, height: 35)))
        filterButton.setTitle("Filters", for: .normal)
        filterButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        filterButton.backgroundColor = UIColor(red: 20/255, green: 110/255, blue: 230/255, alpha: 1)
        filterButton.layer.borderWidth = 2
        filterButton.layer.borderColor = UIColor.white.cgColor
        
        
        self.navigationController?.view.addSubview(backButton)
        self.navigationController?.view.addSubview(filterButton)
        self.navigationController?.isNavigationBarHidden = true
    }
    @objc func buttonAction(sender: UIButton!) {
        performSegue(withIdentifier: "homeSegue", sender: self)
    }
    @objc func filterAction(sender: UIButton!) {
        fullArray = aircraftArray
        performSegue(withIdentifier: "filterSegue", sender: self)
    }

    
//SEARCH BAR SET UP ******************************************************************************************************
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //executes without filter
        if !ViewControllerTable.isFiltered{
            guard !searchText.isEmpty else{
                self.currentAircraftArray = aircraftArray
                table.reloadData()
                return
            }
            self.currentAircraftArray = aircraftArray.filter({ (aircraft) -> Bool in
                return (aircraft.modelNumber.lowercased().contains(searchText.lowercased()) ||  aircraft.commonName.lowercased().contains(searchText.lowercased()))
            })
        //executes with filter
        }else{
            guard !searchText.isEmpty else{
                ViewControllerFitler.currentArray = ViewControllerFitler.finalArray
                table.reloadData()
                return
            }
            ViewControllerFitler.currentArray = ViewControllerFitler.finalArray.filter({ (aircraft) -> Bool in
                return (aircraft.modelNumber.lowercased().contains(searchText.lowercased()) ||  aircraft.commonName.lowercased().contains(searchText.lowercased()))
            })
        }
        table.reloadData()
    }
//vertical lift switch
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //without filter
        if !ViewControllerTable.isFiltered{
            switch selectedScope{
            case 0:
                self.currentAircraftArray = aircraftArray
            case 1:
                self.currentAircraftArray = aircraftArray.filter { (aircraft) -> Bool in
                    return (aircraft.verticalLift == true)
                }
            default:
                break
            }
        //with filter
        }else{
            switch selectedScope{
            case 0:
                ViewControllerFitler.currentArray = ViewControllerFitler.finalArray
            case 1:
                ViewControllerFitler.currentArray = ViewControllerFitler.finalArray.filter { (aircraft) -> Bool in
                    return (aircraft.verticalLift == true)
                }
            default:
                break
            }
        }
        table.reloadData()
    }
    
//returns the keyboard when searching 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    
    
    
//TABLE VIEW SET UP ******************************************************************************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //without filter
        if !ViewControllerTable.isFiltered{
           return self.currentAircraftArray.count
        }else{
            return ViewControllerFitler.currentArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else{
            return UITableViewCell()
        }
        //without filter
        if !ViewControllerTable.isFiltered{
            cell.commonNameLB.text = self.currentAircraftArray[indexPath.row].commonName
            cell.modelNumberLB.text = self.currentAircraftArray[indexPath.row].modelNumber
            cell.aircraftPhoto.image = UIImage(named: "testImage")
        }else{
            cell.commonNameLB.text = ViewControllerFitler.currentArray[indexPath.row].commonName
            cell.modelNumberLB.text = ViewControllerFitler.currentArray[indexPath.row].modelNumber
            cell.aircraftPhoto.image = UIImage(named: "testImage")
        }
        return cell
    }
    
//sets size of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
//ALERT for onClick cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showAlertYesNo(title: "Selected Aircraft", message: "View the model: \(aircraftArray[indexPath.row].modelNumber)?", row: indexPath.row)
    }
    func showAlertYesNo(title : String, message: String, row: Int){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //Click OK
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            //Open Segue with Aircraft Data
            self.infoCard = self.aircraftArray[row]
            self.seg()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    func seg(){
        performSegue(withIdentifier: "infoSegue", sender: self)
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
                
                let inFlightRefuel = snapValues?["inFlightRefuel"] as? Bool ?? false //find a way to make it NA
                let verticalLift = snapValues?["verticalLift"] as? Bool ?? false
                let commonName = snapValues?["commonName"] as? String ?? "N/A"
                let otherName = snapValues?["otherName"] as? String ?? "N/A"
                let photoURL =  snapValues?["photo"] as? String ?? "N/A"
                let cruiseSpeed = snapValues?["cruiseSpeed"]as? Int ?? -1
                let maxSpeed = snapValues?["maxSpeed"] as? Int ?? -1
                let maxRangeInt = snapValues?["maxRangeInt"] as? Int ?? -1
                let maxRangeExt = snapValues?["maxRangeExt"] as? Int ?? -1
                let maxLoad = snapValues?["maxLoad"] as? Int ?? -1
                let minCrew = snapValues?["minCrew"] as? Int ?? -1
                let maxCrew = snapValues?["maxCrew"] as? Int ?? minCrew
                let paxSeatedMin = snapValues?["paxSeatedMin"] as? Int ?? -1
                let paxSeatedMax = snapValues?["paxSeatedMax"] as? Int ?? paxSeatedMin
                let paxLitters = snapValues?["paxLitters"] as? Int ?? -1
                let singleLoadCapacity = snapValues?["singleLoadCapacity"] as? Int ?? -1
                let internalFuel = snapValues?["internalFuel"] as? Int ?? -1
                let serviceCeiling = snapValues?["serviceCeiling"] as? Int ?? -1
                let takeoffRunway = snapValues?["takeoffRunway"] as? Int ?? -1
                let landingRunway = snapValues?["landingRunway"] as? Int ?? -1
                
            //Add each element of each child to Aircraft array
                self.aircraftArray.append(Aircraft.init(modelNumber: modelNumber, commonName: commonName,otherName: otherName, cruiseSpeed: cruiseSpeed, maxSpeed: maxSpeed, maxRangeInt: maxRangeInt, maxRangeExt: maxRangeExt, maxLoad: maxLoad, crew: minCrew...maxCrew, paxSeated: paxSeatedMin...paxSeatedMax, paxLitters: paxLitters, singleLoadCapacity: singleLoadCapacity, internalFuel: internalFuel, serviceCeiling: serviceCeiling, inFlightRefuel: inFlightRefuel, takeoffRunway: takeoffRunway, landingRunway: landingRunway, photoURL: photoURL, verticalLift: verticalLift))
                self.currentAircraftArray = self.aircraftArray
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
