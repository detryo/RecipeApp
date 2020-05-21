//
//  CustomButton.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 19/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class CustomButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCustomViewProperty()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setCustomViewProperty()
    }
    
    func setCustomViewProperty() {
        
        let orange = CustomColor(withFrame: frame).getColor()
        
        self.backgroundColor = orange
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        
        let spacing = 1.5
        let attributesString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributesString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributesString.length))
        self.setAttributedTitle(attributesString, for: .normal)
        
    }
    
    //Sets the backgroud to white and makes
    //the border thin with a custom color
    func makeBacgroundWhiteWithBorder() {
        let orange = CustomColor(withFrame: frame).getColor()
        
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1.5
        self.layer.borderColor = orange.cgColor
        self.layer.cornerRadius = 25
    }
}
