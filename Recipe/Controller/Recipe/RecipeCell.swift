//
//  CategorySelectionCell.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 22/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

protocol RecipeCellDelegate {
    
    
    func deleteRecipe(recipe: Recipe)
}

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitles: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    //private var userRef : Recipe!
    var delegate: RecipeCellDelegate?
    
    var recipe: Recipe!
    //var delegate: RecipeCellDelegate?
    var foodCategory: FoodCategory?
    let realm = try! Realm()
    var isEditing: Bool = false {
        didSet {
            favoriteButton.isHidden = isEditing
            deleteButton.isHidden = isEditing
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recipeImage.layer.cornerRadius = 10
        recipeImage.layer.borderWidth = 2
    }
    
    func configureCell(recipe: Recipe, delegate: RecipeCellDelegate) {

        self.delegate = delegate
        self.recipe = recipe
        
        recipeImage.image = UIImage(data: recipe.imageName!)
        recipeTitles.text = recipe.recipeTitle
    }

    // TODO: Arreglar este boton
    @IBAction func favoriteClicked(_ sender: UIButton) {
        
        
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        delegate?.deleteRecipe(recipe: recipe)
        print("delete success \(String(describing: recipe))")
    }
}
