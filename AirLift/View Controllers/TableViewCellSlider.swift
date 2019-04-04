//
//  TableViewCellSlider.swift
//  AirLift
//
//  Created by Trevor Hecht on 4/2/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import SwiftRangeSlider

class TableViewCellSlider: UITableViewCell {


    @IBOutlet weak var curMax: UILabel!
    @IBOutlet weak var curMin: UILabel!
    @IBOutlet weak var filterName: UILabel!
    @IBOutlet weak var rangeSlider: RangeSlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    //this makes the cell unselectable 
        self.selectionStyle = .none
    }

    @IBAction func rangeSliderChanged(_ sender: RangeSlider) {
        
        curMin.text = "\(Int(rangeSlider.lowerValue))"
        curMax.text = "\(Int(rangeSlider.upperValue))"
        let currMin = Int(rangeSlider.lowerValue)
        let currMax = Int(rangeSlider.upperValue)
//        let range = Int(rangeSlider.lowerValue)...Int(rangeSlider.upperValue)
        ViewControllerFitler().setNumAircrafts(curMin: currMin,curMax: currMax)
        //doSomething(currMin: currMin, currMax: currMax)
    }
    
//    func doSomething(currMin: Int, currMax: Int){
//        
//    }
}
