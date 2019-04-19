//
//  TableViewCellBoolFilter.swift
//  AirLift
//
//  Created by Trevor Hecht on 4/18/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit

class TableViewCellBoolFilter: UITableViewCell {

    @IBOutlet weak var inFlightRefuelSwitch: UISwitch!
    @IBOutlet weak var verticleSwitch: UISwitch!
    
    @IBOutlet weak var clearButton: UIButton!
    var clearAll: UIButton!
    var seeNumButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearButton.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //this makes the cell unselectable
        self.selectionStyle = .none
        
    }
    @IBAction func clearButtonOnClick(_ sender: Any) {
        verticleSwitch.setOn(false, animated: true)
        inFlightRefuelSwitch.setOn(false, animated: true)
        clearButton.isHidden = true
        ViewControllerFitler().clearBoolButtonClicked(clearAll: clearAll, seeNumButton:seeNumButton)
    }
    
    @IBAction func refuelOnClick(_ sender: Any) {
        if !inFlightRefuelSwitch.isOn && !verticleSwitch.isOn {
            clearButton.isHidden = true
        } else if inFlightRefuelSwitch.isOn || verticleSwitch.isOn {
            clearButton.isHidden = false
            clearAll.isHidden = false

        }
        if inFlightRefuelSwitch.isOn{
            ViewControllerFitler().filterRefuelBool(state: true, seeNumButton: seeNumButton)
        }else{
            ViewControllerFitler().filterRefuelBool(state: false, seeNumButton: seeNumButton)
        }
    }
    @IBAction func verticleOnClick(_ sender: Any) {
        if !inFlightRefuelSwitch.isOn && !verticleSwitch.isOn {
            clearAll.isHidden = false
            clearButton.isHidden = true
        }else if inFlightRefuelSwitch.isOn || verticleSwitch.isOn{
            clearButton.isHidden = false
            clearAll.isHidden = false

        }
        if verticleSwitch.isOn{
            ViewControllerFitler().fitlerVerticalBool(state: true, seeNumButton: seeNumButton)
        }else{
            ViewControllerFitler().fitlerVerticalBool(state: false, seeNumButton: seeNumButton)
        }
    }
}
