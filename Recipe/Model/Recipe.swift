//
//  Recipe.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 21/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseFirestore

class Recipe: Object {
    @objc dynamic var imageName : Data?
    @objc dynamic var recipeTitle: String = ""
    @objc dynamic var ingridients : String = ""
    @objc dynamic var instructions : String = ""
    @objc dynamic var preparation : String = ""
    @objc dynamic var timeToCook : String = ""
    @objc dynamic var difficulty : String = ""
    @objc dynamic var serves : String = ""
    
    // Hay que cambiarlo por Data
    override static func primaryKey() -> String? {
        return "recipeTitle"
    }
    
//    init(recipeTitle: String, ingridients: String, instructions: String, preparation: String, timeToCook: String, difficulty: String, serves: String, id: String) {
//
//        self.recipeTitle = recipeTitle
//        self.ingridients = ingridients
//        self.instructions = instructions
//        self.preparation = preparation
//        self.timeToCook = timeToCook
//        self.difficulty = difficulty
//        self.serves = serves
//        self.id = id
//    }
    
    convenience init?(data : [String : Any]? ) {
        
        guard let data = data,
            let imageName = data["imageName"] as? Data,
            let recipeTitle = data["recipeTitle"] as? String,
            let ingridients = data["ingridients"] as? String,
            let instructions = data["instructions"] as? String,
            let preparation = data["preparation"] as? String,
            let timeToCook = data["timeToCook"] as? String,
            let difficulty = data["difficulty"] as? String,
            let serves = data["serves"] as? String else { return nil }
        
        self.init()
        
        self.imageName = imageName
        self.recipeTitle = recipeTitle
        self.ingridients = ingridients
        self.instructions = instructions
        self.preparation = preparation
        self.timeToCook = timeToCook
        self.difficulty = difficulty
        self.serves = serves
    }
    
    static func modelToData(recipe: Recipe) -> [String: Any] {
        
        let data: [String: Any] = [
            "imageName" : recipe.imageName!,
            "recipeTitle" : recipe.recipeTitle,
            "ingridients" : recipe.ingridients,
            "instructions" : recipe.instructions,
            "preparation" : recipe.preparation,
            "timeToCook" : recipe.timeToCook,
            "difficulty" : recipe.difficulty,
            "serves" : recipe.serves ]
        return data
    }
    
    var parentCategory = LinkingObjects(fromType: FoodCategory.self, property: "recipes")
}
