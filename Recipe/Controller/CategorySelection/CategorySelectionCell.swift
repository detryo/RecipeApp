//
//  CategorySelectionCell.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 22/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class CategorySelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var categorySelectedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categorySelectedImage.layer.cornerRadius = 10
    }
    
    func configureCell(recipe: Recipe) {
        
        categorySelectedImage.image = UIImage(named: recipe.imageName)
    }
}
