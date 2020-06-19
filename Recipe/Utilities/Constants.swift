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
    static let showRecipeDetails = "ShowRecipeDetails"
    static let fromCategoryToRecipe = "fromCategoryToRecipe"
    static let fromCategoryToStaticRecipe = "fromCategoryToStaticRecipe"
}

struct Cell {
    
    static let category = "CategoryCell"
    static let recipe = "RecipeCell"
    static let recipeTableView = "RecipeTableViewCell"
    static let categoryCollection = "CategoryCollectionCell"
}

struct AppImages {
    
    static let greenCheck = "green_check"
    static let redCheck = "red_check"
}
