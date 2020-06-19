//
//  StaticRecipeDetailVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 19/06/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class StaticRecipeDetailVC: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var servesLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!

    // Static recipe
    var staticSelectRecipe : StaticRecipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStaticUI()
    }


    // set uo ui with static recipe
    func setupStaticUI() {
        
        recipeImage.image = UIImage(named: staticSelectRecipe.imageName)
        prepTimeLabel.text = staticSelectRecipe.preparation
        cookTimeLabel.text = staticSelectRecipe.timeToCook
        difficultyLabel.text = staticSelectRecipe.difficulty
        servesLabel.text = staticSelectRecipe.serves
        recipeIngredientsTextView.text = staticSelectRecipe.ingridients
        instructionsTextView.text = staticSelectRecipe.instructions
    }
}
