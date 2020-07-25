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
    @objc dynamic var imageName : Data?
    @objc dynamic var recipeTitle: String = ""
    @objc dynamic var ingridients : String = ""
    @objc dynamic var instructions : String = ""
    @objc dynamic var preparation : String = ""
    @objc dynamic var timeToCook : String = ""
    @objc dynamic var difficulty : String = ""
    @objc dynamic var serves : String = ""
    
    var parentCategory = LinkingObjects(fromType: FoodCategory.self, property: "recipes")
}
