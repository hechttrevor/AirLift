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
    @IBOutlet weak var filterNames: UILabel!
    @IBOutlet weak var rangeSlider: RangeSlider!
    @IBOutlet weak var clearButton: UIButton!
    var clearAll: UIButton!
    var seeNumButton: UIButton!
    
    var filterName: String!
    var fixedMin: Int!
    var fixedMax: Int!
    
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
        ViewControllerFitler().setNumAircrafts(curMin: currMin,curMax: currMax, button: seeNumButton, filterName: filterName)
        self.clearButton.isHidden = false
        self.clearAll.isHidden = false
    }
    @IBAction func onClickClearButton(_ sender: UIButton) {
        
        ViewControllerFitler().clearButtonClicked(button: seeNumButton, clearAllButton: clearAll, filterName: filterName)
        
        rangeSlider.lowerValue = Double(fixedMin)
        rangeSlider.upperValue = Double(fixedMax)
        curMin.text = "\(Int(rangeSlider.lowerValue))"
        curMax.text = "\(Int(rangeSlider.upperValue))"

        
        self.clearButton.isHidden = true
    }
}
