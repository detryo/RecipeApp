//
//  CategorySelectionVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 22/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseFirestore

class RecipeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var userRef = [Recipe]()
    var userFav : User!
    var showFavorites = false //
    var database: Firestore!
    var listener : ListFormatter!
    var pruebaRecipe: Recipe! //
    
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
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(title: BarButton.back, style: .done, target: self, action: #selector(backButtonPressed)), editButtonItem] //
        collectionView.reloadData()
        
        
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        collectionView.isMultipleTouchEnabled = true
        collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cell = collectionView.cellForItem(at: indexPath) as? RecipeCell
            cell?.isEditing = editing
        }
        collectionView.reloadData()
    }
    
    //
    func setupQuery() {
        
        var ref: Query!
        
        if showFavorites {
            ref = database.collection("users").document(UserService.user.email).collection("favorites")
        }
        
//        listener = ref.addSnapshotListener({ (snap, error) in
//
//            if let error = error {
//
//                debugPrint(error.localizedDescription)
//            }
//
//            snap?.documentChanges.forEach({ (change) in
//
//                let data = change.document.data()
//                let recipe = Recipe.init(data: data)
//
//                switch change.type {
//                case .added:
//                    return self.onDocumentAdded(change: change, recipe: recipe!)
//                case .modified:
//                    return self.onDocumentModified(change: change, recipe: recipe!)
//                case .removed:
//                    return self.onDocumentRemoved(change: change)
//                }
//            })
//
//        }) as? ListFormatter
    }
    
    func loadRecipe() {
        print("loadding recipes for  \(String(describing: selectedCategory))")
    }
    
    // esta funcion es para que haga un reload namas añadir la imagen
    @objc func notificationReceived(_ notification: Notification) {
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        collectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("WTF IS destination \(segue.destination)")
        // Nos lleva al AddRecipeVC para añadir la receta
        if segue.identifier == Segue.toAddRecipe {
            let destinationVC = segue.destination as? AddRecipeVC
            print("to add recipe destinationVC \(String(describing: selectedCategory))")
            destinationVC?.foodCategory = selectedCategory
            
            // Cuando presionamos una celda, nos lleva al RecipeDetailVC
        } else if segue.identifier == Segue.showRecipeDetail {
            let destinationVC = segue.destination as? RecipeDetailVC
            print("to recipe detail \(String(describing: selectedRecipe))")
            destinationVC?.recipe = selectedRecipe
            
        } else if segue.identifier == Segue.showEditing {
            let destinationVC = segue.destination as? EditRecipeVC
            print("mmmmmm")
            destinationVC?.editRecipe = selectedRecipe
        }
    }
    
    // MARK: - Firebase Documents Functions
    func onDocumentAdded(change: DocumentChange, recipe: Recipe) {
        
        let newIndex = Int(change.newIndex)
        userRef.insert(recipe, at: newIndex)
        collectionView.reloadItems(at: [IndexPath(item: newIndex, section: 0)])
    }
    
    func onDocumentModified(change: DocumentChange, recipe: Recipe) {
        
        if change.oldIndex == change.newIndex {
            // Item changed, but remined in the same position
            let index = Int(change.newIndex)
            userRef[index] = recipe
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            
        } else {
            // the itme changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            userRef.remove(at: oldIndex)
            userRef.insert(recipe, at: newIndex)
            collectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
        }
    }
    
    func onDocumentRemoved(change: DocumentChange) {
        
        let oldIndex = Int(change.oldIndex)
        userRef.remove(at: oldIndex)
        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
    }
}

extension RecipeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("recipie count  \(String(describing: selectedCategory))")
        return selectedCategory?.recipes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.recipe, for: indexPath) as! RecipeCell
        print("loading recipies for  \(String(describing: selectedCategory))")
        if let recipes = selectedCategory?.recipes[indexPath.row] {
            
            cell.configureCell(recipe: recipes, delegate: self)
            cell.isEditing = isEditing
            
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let cellDimension = (width / 2) - 15
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if  !isEditing {
            selectedRecipe = selectedCategory?.recipes[indexPath.item]
            print("selected recipe item \(indexPath.item) \(String(describing: selectedRecipe))")
            performSegue(withIdentifier: Segue.showRecipeDetail, sender: self)
        } else { //
            selectedRecipe = selectedCategory?.recipes[indexPath.item]
            print("selected editing recipe item \(indexPath.item) \(String(describing: selectedRecipe))")
            performSegue(withIdentifier: Segue.showEditing, sender: self)
        }
    }
}
// MARK: - Delete function and Recipe Favorite function
extension RecipeVC: RecipeCellDelegate {
    
    func recipeFavorite(recipe: Recipe) {
        
        UserService.favoriteSelected(recipe: recipe)
        guard let index = userRef.firstIndex(of: recipe) else { return }
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
    
    func deleteRecipe(recipe: Recipe) {
        
        do {
            try! realm.write({
                realm.delete(recipe)
            })
        }
        collectionView.reloadData()
    }
    
//    func recipeFavorite(recipe: Recipe) {
//        userService.favoriteSelected(recipe: recipe.self)
//
//        do {
//            try! realm.write({
//                realm.add(recipe)
//            })
//        }
//        print("recipe favorite \(recipe)")
//    }
}
