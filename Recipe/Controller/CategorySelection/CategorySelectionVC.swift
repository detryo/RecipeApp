//
//  CategorySelectionVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 22/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class CategorySelectionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCategory: String!
    var recipe: [Recipe]!
    let data = DataSet()
    var recipeToPass: Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        recipe = data.getRecipe(forCategoryTitle: selectedCategory)
    }
}

extension CategorySelectionVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorySelectionCell", for: indexPath) as? CategorySelectionCell {
            
            let recipes = recipe[indexPath.row]
            cell.configureCell(recipe: recipes)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let cellDimension = (width / 2) - 15
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        recipeToPass = recipe[indexPath.item]
        performSegue(withIdentifier: "toRecipeDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? RecipeDetailVC {
            
            detailVC.selectedRecipe = recipeToPass
        }
    }
}
