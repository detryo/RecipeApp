//
//  SearchBarCell.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 24/07/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class SearchBarCell: UITableViewCell {
    
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        searchImage.layer.cornerRadius = 10
        searchImage.layer.borderWidth = 2
        searchImage.layer.borderColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
    }
}
