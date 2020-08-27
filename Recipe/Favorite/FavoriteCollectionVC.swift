//
//  CollectionViewController.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 25/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteCollectionVC: UICollectionViewController {
    
    let realm = try! Realm()
    var favoriteRecipe = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notifications.newRecipe, object: nil)
        refresh()
    }
    
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteRecipe.count
    }
    
    func refresh() {
        favoriteRecipe = realm.objects(Recipe.self).map({ $0 })
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.favoriteCell, for: indexPath) as? FavoriteCell
        
        cell?.favoriteTitle.text = favoriteRecipe[indexPath.row].recipeTitle
        cell?.favoriteImage.image = UIImage(data: favoriteRecipe[indexPath.row].imageName!)
        cell?.delegate = self
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let cellDimension = (width / 2) - 15
        return CGSize(width: cellDimension, height: cellDimension)
    }
    // TODO: hacer el segue hacia el RecipeDetailVC.swift
}

extension FavoriteCollectionVC: FavoriteCellDelegate {
    
    func deleteFavoriteRecipe(recipe: Recipe) {
        
        do {
            try! realm.write({
                realm.delete(favoriteRecipe)
            })
        }
        collectionView.reloadData()
    }
}
