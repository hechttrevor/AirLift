//
//  ViewControllerFitler.swift
//  AirLift
//
//  Created by Trevor Hecht on 3/29/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit

class ViewControllerFitler: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    var filterArray =  [ClosedRange<Double>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFilterArray()
        // Do any additional setup after loading the view.
    }
    
    
    
//TABLE VIEW SET UP ***********************************************************************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCellSlider else{
            return UITableViewCell()
        }
        cell.rangeSlider.minimumValue = 0
        cell.rangeSlider.maximumValue = 100
        cell.rangeSlider.upperValue = 100
        cell.rangeSlider.stepValue = 10

        return cell
    }
    //sets size of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    //makes each cell unclickable
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    
    
    
    

    func setFilterArray(){
        
        filterArray.append(1...3)
        filterArray.append(1...3)
        filterArray.append(1...3)
    }

}
