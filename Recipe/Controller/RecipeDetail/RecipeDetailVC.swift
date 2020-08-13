//
//  RecipeDetailVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 22/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class RecipeDetailVC: UIViewController {
    
    // Outels
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var servesLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var recipeTitle: UILabel!
    
    var recipe : Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupUI()
    }

    // set up ui with customer details
    func setupUI() {
        
        recipeImage.image = UIImage(data: recipe.imageName!)
        prepTimeLabel.text = recipe.preparation
        cookTimeLabel.text = recipe.timeToCook
        difficultyLabel.text = recipe.difficulty
        servesLabel.text = recipe.serves
        recipeIngredientsTextView.text = recipe.ingridients
        instructionsTextView.text = recipe.instructions
        recipeTitle.text = recipe.recipeTitle
    }
}
