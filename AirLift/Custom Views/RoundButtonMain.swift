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
        backgroundColor = UIColor.init(red: 20/255, green: 110/255, blue: 230/255, alpha: 1)
        //titleLabel?.font = UIFont(name: font.avenirNextCondensedDemiBold, size: 22)
        layer.cornerRadius = frame.size.height/2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        setTitleColor(.white, for: .normal)
    }
    
}
