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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchRecipe = [Recipe]() // search bar
    var currentSearchRecipe = [Recipe]()
    var selectRecipe: Recipe!
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        refresh()
        setupSearchBar()
        currentSearchRecipe = searchRecipe
    }
    
    func refresh() {
        searchRecipe = realm.objects(Recipe.self).map({ $0 })
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSearchRecipe.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell, for: indexPath) as? SearchBarCell
        cell?.searchName.text = currentSearchRecipe[indexPath.row].recipeTitle
        cell?.searchImage.image = UIImage(data: currentSearchRecipe[indexPath.row].imageName!)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRecipe = searchRecipe[indexPath.row]
        print("selected search recipe vc \(String(describing: selectRecipe))")
        performSegue(withIdentifier: Segue.showSearchDetails, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == Segue.showSearchDetails {
            let destinationVC = segue.destination as? RecipeDetailVC
            destinationVC?.recipe = selectRecipe
        }
    }
}
// MARK: Search Bar Methods
extension SearchBarTableViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            currentSearchRecipe = searchRecipe
            tableView.reloadData()
            return
        }
        
        currentSearchRecipe = searchRecipe.filter({ (recipe) -> Bool in
            recipe.recipeTitle.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
