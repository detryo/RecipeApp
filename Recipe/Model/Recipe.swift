//
//  Recipe.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 21/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation
import RealmSwift

class Recipe: Object {
   // @objc dynamic var title : String? = ""
    @objc dynamic var imageName : Data?
    @objc dynamic var ingridients : String = ""
    @objc dynamic var instructions : String = ""
    @objc dynamic var preparation : String = ""
    @objc dynamic var timeToCook : String = ""
    @objc dynamic var difficulty : String = ""
    @objc dynamic var serves : String = ""
    @objc dynamic var colorHex : String?
    
    var parentCategory = LinkingObjects(fromType: FoodCategory.self, property: "recipes")
}

extension Recipe {

    var color : UIColor? {

        get {
            guard let hex = colorHex else { return nil }
            return UIColor(hex: hex)
        }

        set(newColor) {

            if let newColor = newColor {
                colorHex = newColor.toHex
            }
        }
    }
}
