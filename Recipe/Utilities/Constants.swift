//
//  Constants.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 12/06/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation

struct Segue {
    
    static let fromHomeToCategory = "fromHomeToCategory"
    static let fromRegisterToCategory = "fromRegisterToCategory"
    static let fromLoginToCategory = "fromLogInToCategory"
    static let showRecipeList = "ShowRecipeList"
    
    static let toAddRecipe = "toAddRecipe"
    static let showRecipeDetail = "ShowRecipeDetail"
    static let fromCategoryToRecipe = "fromCategoryToRecipe"
}

struct Cell {
    
    static let category = "CategoryCell"
    static let recipe = "RecipeCell"
}
