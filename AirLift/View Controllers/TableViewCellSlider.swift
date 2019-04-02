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


    @IBOutlet weak var rangeSlider: RangeSlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func rangeSliderChanged(_ sender: RangeSlider) {
         print("\(rangeSlider.lowerValue), \(rangeSlider.upperValue)")
    }
}
