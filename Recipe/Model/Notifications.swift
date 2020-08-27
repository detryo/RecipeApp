//
//  Notifications.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 31/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation

class Notifications {
    
    static let viewControllerPublishNotification = NSNotification.Name(rawValue: "ViewControllerPublishEvent")
    static let newRecipe = NSNotification.Name(rawValue: "NewRecipe")
    static let favoriteRecipe = NSNotification.Name(rawValue: "FavoriteREcipe")
}
