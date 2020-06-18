//
//  StaticRecipeCell.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 17/06/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recipeImage.layer.cornerRadius = 10
    }
    
    func configureCell(recipe : StaticRecipe) {
        
        recipeImage.image = UIImage(named: recipe.imageName)
    }
}
