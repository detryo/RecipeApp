//
//  CategoryCollectionCell.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 13/06/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryCollectionImage: UIImageView!
    @IBOutlet weak var categoryCollectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryCollectionImage.layer.cornerRadius = 10
    }
    
    func configureCell(staticRecipe: StaticFoodCategory) {
        
        categoryCollectionImage.image = UIImage(named: staticRecipe.imageName)
        categoryCollectionLabel.text = staticRecipe.title
    }
}
