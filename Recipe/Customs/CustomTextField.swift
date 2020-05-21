//
//  CustomTextField.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 20/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class CustomTextField : UITextField {
    
    class CustomTextField : UITextField {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUpViewProperties()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setUpViewProperties()
        }
        
        //Makes the textfield border thin with
        //color and moves the placeholder to the
        //right with color
        func setUpViewProperties() {
            self.layer.borderWidth = 1.5
            self.layer.cornerRadius = 1
            
            self.layer.borderColor = UIColor(hexString: "E0E0E0", withAlpha: 1)?.cgColor
            self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(hexString: "9E9E9E")!])
            self.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
        }
    }
}
