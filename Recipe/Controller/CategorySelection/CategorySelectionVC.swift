//
//  CategorySelectionVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 22/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

class CategorySelectionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    let realm = try! Realm()
    var selectedRecipe: Recipe?
    var selectedCategory : FoodCategory?{
        didSet {
            loadNotes()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Coger informacion de NewCategoryVC
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notifications.newCategorySelection, object: nil)
    }
    
    func loadNotes() {
        print("loadding recipes for  \(selectedCategory)")
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAddRecipe" {
            let destinationVC = segue.destination as? NewCategorySelectionVC
            print("to add recipe destinationVC \(String(describing: selectedCategory))")
            destinationVC?.foodCategory = selectedCategory
            
        } else if segue.identifier == "toRecipeDetail" {
            let destinationVC = segue.destination as? RecipeDetailVC
            print("to recipe detail \(String(describing: selectedRecipe))")
            destinationVC?.recipe = selectedRecipe
            
        }
    }
}

extension CategorySelectionVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("recipie count  \(String(describing: selectedCategory))")
        return selectedCategory?.categorySelection.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorySelectionCell", for: indexPath) as! CategorySelectionCell
        print("loading recipies for  \(String(describing: selectedCategory))")
        if let recipes = selectedCategory?.categorySelection[indexPath.row] {
                
                //cell.categorySelectedLabel.text = recipes.title
                cell.categorySelectedImage.image = UIImage(data: recipes.imageName!)
                cell.categorySelectedImage.layer.borderColor = UIColor(hex: recipes.colorHex!)?.cgColor
                cell.categorySelectedImage.layer.borderWidth = 5
                cell.categorySelectedImage.layer.cornerRadius = 5
                cell.categorySelectedImage.backgroundColor = UIColor(hex: recipes.colorHex!)
            }

            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let cellDimension = (width / 2) - 15
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedRecipe = selectedCategory?.categorySelection[indexPath.item]
        print("selected recipe item \(indexPath.item) \(String(describing: selectedRecipe))")
        performSegue(withIdentifier: "toRecipeDetail", sender: self)
    }
}
