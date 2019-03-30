//
//  TableViewCell.swift
//  AirLift
//
//  Created by Trevor Hecht on 3/29/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var modelNumberLB: UILabel!
    @IBOutlet weak var commonNameLB: UILabel!
    @IBOutlet weak var aircraftPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
