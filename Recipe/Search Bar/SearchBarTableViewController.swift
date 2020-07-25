//
//  SearchBarTableViewController.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 23/07/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

class SearchBarTableViewController: UITableViewController {
    
    var searchRecipe = [Recipe]()
    var selectRecipe: Recipe!
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        refresh()
    }
    
    func refresh() {
        searchRecipe = realm.objects(Recipe.self).map({ $0 })
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchRecipe.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell, for: indexPath) as? SearchBarCell
        cell?.searchName.text = searchRecipe[indexPath.row].recipeTitle
        cell?.searchImage.image = UIImage(data: searchRecipe[indexPath.row].imageName!)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRecipe = searchRecipe[indexPath.row]
        print("selected search recipe vc \(String(describing: selectRecipe))")
        performSegue(withIdentifier: Segue.showSearchDetails, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == Segue.showSearchDetails {
            let destinationVC = segue.destination as? SearchDetailsVC
            destinationVC?.recipe = selectRecipe
        }
    }
}
// TODO: hacer la search bar y el segue
