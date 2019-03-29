//
//  ViewController.swift
//  AirLift
//
//  Created by Trevor Hecht on 3/27/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit

class ViewControllerInfoCard: UIViewController {

    @IBOutlet weak var modelNumber: UILabel!
    @IBOutlet weak var commonName: UILabel!
    @IBOutlet weak var otherName: UILabel!
    @IBOutlet weak var cruiseSpeed: UILabel!
    @IBOutlet weak var maxSpeed: UILabel!
    @IBOutlet weak var aircraftPhoto: UIImageView!
    var image : UIImage!
    
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    
    let aircraft = TableViewAircrafts.baseballCard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsText()
        setImage()
    }
    
    func setImage(){
        
        dataTask?.cancel()
        if let photoUrl = aircraft?.photoURL{
            if photoUrl == "" {return}
            let url = URL(string: photoUrl)
            //Take link from database, then set it to the Aircraft photo
            dataTask = defaultSession.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                //succesfully found the link
                DispatchQueue.main.async {
                    self.aircraftPhoto.translatesAutoresizingMaskIntoConstraints = true
                    self.aircraftPhoto.image = UIImage(data: data!)
                }
         })
             dataTask?.resume()
        }
        //CODE TO FETCH PHOTO FROM ASSET FILE
//        aircraftPhoto.image = UIImage(named: "\(aircraft!.modelNumber)")
//        aircraftPhoto.translatesAutoresizingMaskIntoConstraints = true
//
    }
    
    func setLabelsText(){
        modelNumber.text = aircraft?.modelNumber
        commonName.text = aircraft?.commonName
        otherName.text = aircraft?.otherName
        cruiseSpeed.text = "\(aircraft!.cruiseSpeed)"
        maxSpeed.text = "\(aircraft!.maxSpeed)"
       // let image = UIImage(named: "RescueBackgournd1")

    }
    
    @IBAction func closeView(_ sender: Any) {
    self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    


}
