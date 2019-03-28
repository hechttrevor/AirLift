//
//  RoundButtonMain.swift
//  RescueApp
//
//  Created by Trevor Hecht on 3/21/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit

class RoundButtonMain: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setupButton()
    }
    
    private func setupButton() {
        backgroundColor = UIColor.red
        //titleLabel?.font = UIFont(name: font.avenirNextCondensedDemiBold, size: 22)
        layer.cornerRadius = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
    
}
