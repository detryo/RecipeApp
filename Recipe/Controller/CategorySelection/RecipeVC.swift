//
//  CategorySelectionVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 22/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

class RecipeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    let realm = try! Realm()
    var selectedRecipe: Recipe?
    var selectedCategory : FoodCategory?{
        didSet {
            loadRecipe()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Coger informacion de NewCategoryVC
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notifications.newRecipe, object: nil)
    }
    
    func loadRecipe() {
        print("loadding recipes for  \(String(describing: selectedCategory))")
    }
    // esta funcion es para que haga un reload namas añadir la imagen
    @objc func notificationReceived(_ notification: Notification) {
        collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Nos lleva al NewRecipe para añadir la receta
        if segue.identifier == Segue.toAddRecipe {
            let destinationVC = segue.destination as? NewRecipe
            print("to add recipe destinationVC \(String(describing: selectedCategory))")
            destinationVC?.foodCategory = selectedCategory
            
            // Cuando presionamos una celda, nos lleva al RecipeDetailVC
        } else if segue.identifier == Segue.showRecipeDetail {
            let destinationVC = segue.destination as? RecipeDetailVC
            print("to recipe detail \(String(describing: selectedRecipe))")
            destinationVC?.recipe = selectedRecipe
        }
    }
}

extension RecipeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("recipie count  \(String(describing: selectedCategory))")
        return selectedCategory?.recipes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.recipe, for: indexPath) as! RecipeCell
        print("loading recipies for  \(String(describing: selectedCategory))")
        if let recipes = selectedCategory?.recipes[indexPath.row] {
                
                //cell.categorySelectedLabel.text = recipes.title
                cell.recipeImage.image = UIImage(data: recipes.imageName!)
            }
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let cellDimension = (width / 2) - 15
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedRecipe = selectedCategory?.recipes[indexPath.item]
        print("selected recipe item \(indexPath.item) \(String(describing: selectedRecipe))")
        performSegue(withIdentifier: Segue.showRecipeDetail, sender: self)
    }
}
