//
//  CategoryVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 21/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCategory = -1
    var foodCategory : Results<FoodCategory>?
    let realm = try! Realm()
    
    // staic data set
    var dataSet = DataSet()
    var categoryToPass: String!
    var recipes : [StaticRecipe]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Coger informacion de NewCategoryVC
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notifications.viewControllerPublishNotification, object: nil)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        self.tableView.reloadData()
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
        self.foodCategory = self.realm.objects(FoodCategory.self)
        }
    }

// MARK: TableVIew Data Source, Delegate
extension CategoryVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Number of categories, if not any category, the value is 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodCategory?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.category, for: indexPath) as? CategoryCell {

            if let category = foodCategory?[indexPath.row] {
                cell.categoryLabel.text = category.title
                cell.categoryImage.image = UIImage(data: category.imageName!)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // Tamaño de la celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = indexPath.row
        print("selected category vc \(selectedCategory)")
        performSegue(withIdentifier: Segue.fromCategoryToRecipe, sender: self)
    }
    
    // delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            if let deleteFoodCategory = foodCategory?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(deleteFoodCategory)
                    }
                } catch {
                    print("Error deleting course: \(error)")
                }
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.fromCategoryToRecipe {
            let destinationVC = segue.destination as? RecipeVC
            print("destinationVC \(foodCategory![selectedCategory])")
            destinationVC?.selectedCategory = foodCategory![selectedCategory]
            
        } else if segue.identifier == Segue.fromCategoryToStaticRecipe {
            let destinationVC = segue.destination as? StaticRecipeVC
            print("destinationVC TableView \(String(describing: categoryToPass))")
            destinationVC?.staticRecipe = categoryToPass
        }
    }
}
// MARK: - Collection View Datasource, Delegate, Delegate Flow Layout for static data set
extension CategoryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSet.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.categoryCollection, for: indexPath) as? CategoryCollectionCell {
        
            cell.configureCell(staticRecipe: dataSet.categories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        
           let width = view.bounds.width
           let cellDimension = (width / 2) - 15
           return CGSize(width: width, height: cellDimension)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        categoryToPass = dataSet.categories[indexPath.row].title
        performSegue(withIdentifier: Segue.fromCategoryToStaticRecipe, sender: self)
    }
}
