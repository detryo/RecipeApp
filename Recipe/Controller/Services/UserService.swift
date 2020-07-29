//
//  UserService.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 28/07/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation

let userService = _UserService()

final class _UserService {

    var favorites = [Recipe]()

    func favoriteSelected(recipe: Recipe) {

        if favorites.contains(recipe){
            // we remove favorites
            favorites.removeAll { $0 == recipe }

        } else {
            // Add as a favorite
            favorites.append(recipe)
            
        }
    }
}
