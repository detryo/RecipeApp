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
    
//    let imageView = CategorySelectionCell()
//    let imagePicker = UIImagePickerController()
    //var recipe: [Recipe]!
    //var recipeToPass: Recipe!
    //var foodCategory: Results<FoodCategory>?
    //var selectedCategory: String!
    let realm = try! Realm()
    var categorySelection : Results<Recipe>?
    
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
        categorySelection = selectedCategory?.categorySelection.sorted(byKeyPath: "title", ascending: true)
    }
    
//    @IBAction func savePressed(_ sender: UIBarButtonItem) {
//
//        var textField = UITextField()
//
//        let controller = UIAlertController(title: "Implement New Note", message: "", preferredStyle: .alert)
//        let addAction = UIAlertAction(title: "Implement Item", style: .default) { (action) in
//
//            do {
//
//                try self.realm.write {
//                    let categorySelection = CategorySelection()
//                    categorySelection.title = textField.text!
//                    self.selectedCategory?.categorySelection.append(categorySelection) // <- esta manda
//                    self.collectionView.reloadData()
//                }
//
//            } catch {
//                print("error")
//            }
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        controller.addAction(addAction)
//        controller.addAction(cancelAction)
//
//        controller.addTextField { (alertTextField) in
//
//            alertTextField.placeholder = "Write your note"
//            textField = alertTextField
//        }
//
//        present(controller, animated: true, completion: nil)
//    }
    
    @objc func notificationReceived(_ notification: Notification) {
        collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadCategories()
    }

    func loadCategories() {
        self.categorySelection = self.realm.objects(Recipe.self)
    }
    
}

extension CategorySelectionVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorySelection?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorySelectionCell", for: indexPath) as! CategorySelectionCell
        
            if let recipes = categorySelection?[indexPath.row] {
                
                //cell.categorySelectedLabel.text = recipes.title //
                cell.categorySelectedImage.image = UIImage(data: recipes.imageName!)
                cell.categorySelectedImage.layer.borderColor = UIColor(hex: recipes.colorHex!)?.cgColor
                cell.categorySelectedImage.layer.borderWidth = 5
                cell.categorySelectedImage.layer.cornerRadius = 10
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
        
       // recipeToPass = recipe?[indexPath.row]
        performSegue(withIdentifier: "toRecipeDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? RecipeDetailVC {
            
            //detailVC.selectedRecipe = recipeToPass
        }
    }
}

