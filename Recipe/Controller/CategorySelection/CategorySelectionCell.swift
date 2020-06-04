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
    @IBOutlet weak var categorySelectedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categorySelectedImage.layer.cornerRadius = 10
    }
}
