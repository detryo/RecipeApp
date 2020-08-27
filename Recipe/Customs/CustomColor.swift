//
//  CustomColor.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 19/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import ChameleonFramework

struct CustomColor {
    
    var customOrange : UIColor!
    
    init(withFrame: CGRect) {
        
        let firstColor = UIColor(hexString: "D25900", withAlpha: 1.0)
        let secondColor = UIColor(hexString: "B52F00", withAlpha: 1.0)
        
        customOrange = UIColor(gradientStyle: .leftToRight, withFrame: withFrame, andColors: [firstColor!, secondColor!])
    }
    
    func getColor() -> UIColor {
        
        return customOrange
    }
}
