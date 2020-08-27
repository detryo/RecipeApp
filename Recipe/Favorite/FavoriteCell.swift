//
//  FavoriteCell.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 25/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

protocol FavoriteCellDelegate {
    func deleteFavoriteRecipe(recipe: Recipe)
}

class FavoriteCell: UICollectionViewCell {
 
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteTitle: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate: FavoriteCellDelegate?
    var favorite: Recipe!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        favoriteImage.layer.cornerRadius = 10
        favoriteImage.layer.borderWidth = 2
    }
}
