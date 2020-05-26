//
//  RecipeDetailVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 22/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class RecipeDetailVC: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var servesLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    
    var selectedRecipe : Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()

       setUpUI()
    }


    func setUpUI() {
        
        recipeImage.image = UIImage(named: selectedRecipe.imageName)
        prepTimeLabel.text = selectedRecipe.preparation
        cookTimeLabel.text = selectedRecipe.timeToCook
        difficultyLabel.text = selectedRecipe.difficulty
        servesLabel.text = selectedRecipe.serves
        recipeIngredientsLabel.text = selectedRecipe.ingridients
        instructionsLabel.text = selectedRecipe.instructions
    }
}
