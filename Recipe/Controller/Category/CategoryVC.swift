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
    
    //var data = DataSet()
    var selectedCategory = -1
    var foodCategory : Results<FoodCategory>?
    //var recipe: Results<Recipe>?
    //var categoryToPass : String!
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Coger informacion de NewCategoryVC
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notifications.viewControllerPublishNotification, object: nil)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        tableView.reloadData()
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

extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodCategory?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
            
            if let category = foodCategory?[indexPath.row] {
                
                cell.categoryLabel.text = category.title
                cell.categoryImage.image = UIImage(data: category.imageName!)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCategory = indexPath.row
        print("selected category vc \(selectedCategory)")
        performSegue(withIdentifier: "toSelection", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSelection" {
            let destinationVC = segue.destination as? CategorySelectionVC
            print("destinationVC \(foodCategory![selectedCategory])")
            destinationVC?.selectedCategory = foodCategory![selectedCategory]
            
        }
    }
}
