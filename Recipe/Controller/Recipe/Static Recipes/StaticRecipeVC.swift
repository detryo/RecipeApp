//
//  StaticRecipeVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 18/06/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class StaticRecipeVC: UITableViewController {
    
    // static data set
    var staticRecipe: String!
    var staticRecipes: [StaticRecipe]!
    let data = DataSet()
    var recipeToPass : StaticRecipe!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        staticRecipes = data.getRecipe(forCategoryTitle: staticRecipe)
    }

   // MARK: - Static Table View Data Source and Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staticRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.recipeTableView, for: indexPath) as? RecipeTableViewCell {
    
            let recipe = staticRecipes[indexPath.item]
            cell.configureCell(recipe: recipe)
            
            // Shadow View
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowRadius = 5

            cell.layer.shadowOpacity = 0.40
            cell.layer.masksToBounds = false
            cell.clipsToBounds = false
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        recipeToPass = staticRecipes[indexPath.item]
        performSegue(withIdentifier: Segue.showRecipeDetails, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? StaticRecipeDetailVC {
            
            detailVC.staticSelectRecipe = recipeToPass
        }
    }
}
