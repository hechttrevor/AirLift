//
//  ViewController.swift
//  AirLift
//
//  Created by Trevor Hecht on 3/27/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit

class ViewControllerInfoCard: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var modelNumber: UILabel!
    @IBOutlet weak var commonName: UILabel!
    @IBOutlet weak var otherName: UILabel!
    @IBOutlet weak var cruiseSpeed: UILabel!
    @IBOutlet weak var maxSpeed: UILabel!
    @IBOutlet weak var maxRangeInt: UILabel!
    @IBOutlet weak var maxRangeExt: UILabel!
    @IBOutlet weak var maxLoad: UILabel!
    @IBOutlet weak var crew: UILabel!
    @IBOutlet weak var paxSeated: UILabel!
    @IBOutlet weak var paxLitters: UILabel!
    @IBOutlet weak var internalFuel: UILabel!
    @IBOutlet weak var serviceCeiling: UILabel!
    @IBOutlet weak var singleLoadCapacity: UILabel!
    @IBOutlet weak var inFlightRefuel: UILabel!
    @IBOutlet weak var takeoffRunway: UILabel!
    @IBOutlet weak var landingRunway: UILabel!
    @IBOutlet weak var aircraftPhoto: UIImageView!
    var image : UIImage!
    
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    let dispatchGroup = DispatchGroup()
    
    var aircraft : Aircraft!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Round edges of the card
        backgroundView.layer.cornerRadius = 30
        backgroundView.clipsToBounds = true
        //removes all text while image loads

        mainView.bringSubviewToFront(backgroundView)
        setImage()
        dispatchGroup.notify(queue: .main){
            self.mainView.sendSubviewToBack(self.backgroundView)
            self.setLabelsText()
        }
    }
    

    
//This func convets http link to an imageView
    func setImage(){
        dispatchGroup.enter()
        dataTask?.cancel()
        if let photoUrl = aircraft?.photoURL{
            if photoUrl == "" {
                self.dispatchGroup.leave()
                return
            }
            let url = URL(string: photoUrl)
            //Take link from database, then set it to the Aircraft photo
            dataTask = defaultSession.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    print("HERE MUTHA FUCK")
                    self.dispatchGroup.leave()
                    return
                }
                //succesfully found the link
                DispatchQueue.main.async {
                    self.aircraftPhoto.translatesAutoresizingMaskIntoConstraints = true
                    self.aircraftPhoto.image = UIImage(data: data!)
                    self.dispatchGroup.leave()
                }
         })
             dataTask?.resume()
        }
        
    }
    
    func setLabelsText(){
        modelNumber.text = "\(aircraft!.modelNumber)/ "
        commonName.text = aircraft?.commonName
        otherName.text = aircraft?.otherName
        
 
        if aircraft!.crew.lowerBound == aircraft!.crew.upperBound && aircraft!.crew.lowerBound>0{
            crew.text = "\(aircraft!.crew.lowerBound)"
        }else if aircraft!.crew.lowerBound > 0 {
            crew.text = "\(aircraft!.crew.lowerBound) - \(aircraft!.crew.upperBound)"
        }else {crew.text = "N/A"}
        
        if aircraft!.paxSeated.lowerBound == aircraft!.paxSeated.upperBound && aircraft!.paxSeated.lowerBound > 0{
            paxSeated.text = "\(aircraft!.paxSeated.lowerBound)"
        }else if aircraft!.paxSeated.lowerBound > 0 {
            paxSeated.text = "\(aircraft!.paxSeated.lowerBound) - \(aircraft!.paxSeated.upperBound)"
        }else {paxSeated.text = "N/A"}

    
        
        //I COULD ADD BOUND HERE SO THAT INVALID VALUE WOULD SHOW UP AS N/A
        if aircraft!.cruiseSpeed > 0{
            cruiseSpeed.text = "\(aircraft!.cruiseSpeed) mph"
        }else{cruiseSpeed.text = "N/A"}
       
        if aircraft!.maxSpeed > 0{
            maxSpeed.text = "\(aircraft!.maxSpeed) mph"
        }else{maxSpeed.text = "N/A"}
       
        if aircraft!.maxRangeInt > 0{
            maxRangeInt.text = "\(aircraft!.maxRangeInt) mi"
        }else{maxRangeInt.text = "N/A"}
       
        if aircraft!.maxRangeExt > 0{
            maxRangeExt.text = "\(aircraft!.maxRangeExt) mi"
        }else{maxRangeExt.text = "N/A"}
       
        if aircraft!.maxLoad > 0{
            maxLoad.text = "\(aircraft!.maxLoad) lbs"
        }else{maxLoad.text = "N/A"}
        
        if aircraft!.paxLitters > 0{
            paxLitters.text = "\(aircraft!.paxLitters)"
        }else{paxLitters.text = "N/A"}
        
        if aircraft!.internalFuel > 0{
            internalFuel.text = "\(aircraft!.internalFuel)"
        }else{internalFuel.text = "N/A"}
        
        if aircraft!.serviceCeiling > 0{
            serviceCeiling.text = "\(aircraft!.serviceCeiling) feet"
        }else{serviceCeiling.text = "N/A"}
        
        if aircraft!.singleLoadCapacity > 0{
            singleLoadCapacity.text = "\(aircraft!.singleLoadCapacity)"
        }else{singleLoadCapacity.text = "N/A"}
        
//        if aircraft!.inFlightRefuel == nil{
//            inFlightRefuel.text = "\(aircraft!.inFlightRefuel)"
//        }else{inFlightRefuel.text = "N/A"}
        
        inFlightRefuel.text = "\(aircraft.inFlightRefuel)"
        
        if aircraft!.takeoffRunway >= 0{
            takeoffRunway.text = "\(aircraft!.takeoffRunway) feet"
        }else{takeoffRunway.text = "N/A"}
       
        if aircraft!.landingRunway >= 0{
            landingRunway.text = "\(aircraft!.landingRunway) feet"
        }else{landingRunway.text = "N/A"}
        
        // let image = UIImage(named: "RescueBackgournd1")
    }
    
    @IBAction func closeView(_ sender: Any) {
    self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    


}
