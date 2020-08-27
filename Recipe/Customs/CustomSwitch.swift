//
//  CustomSwitch.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 24/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class CustomSwitch: UISwitch {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    // Setting "on" state colour
    self.onTintColor        = UIColor.orange

    // Setting "off" state colour
    self.tintColor          = UIColor.white
    self.layer.cornerRadius = self.frame.height / 2
    self.backgroundColor    = UIColor.white
  }
}


