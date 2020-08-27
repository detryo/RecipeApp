//
//  UserService.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 28/07/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation
import RealmSwift

let userService = _UserService()

final class _UserService {

    var favorites = [Recipe]()
    var realm = try! Realm()

    func favoriteSelected(recipe: Recipe) {

        if favorites.contains(recipe){
            // we remove favorites
            favorites.removeAll { $0 == recipe }
            
        } else {
            // Add as a favorite
            favorites.append(recipe)
            
            do {
                try realm.write({
                    realm.add(recipe)
                })
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
