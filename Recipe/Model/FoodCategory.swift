//
//  FoodCategory.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 21/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation
import RealmSwift

class FoodCategory: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var imageName : Data?
    
    var parentCategory = LinkingObjects(fromType: Recipe.self, property: "foodCategory")
}
