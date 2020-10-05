//
//  FoodCategory.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 21/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation
import RealmSwift

class FoodCategory: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var imageName : Data?
    
    let recipes = List<Recipe>()
    
    convenience init?(data : [String : Any]? ) {
        
        guard let data = data,
            let imageName = data["imageName"] as? Data,
            let title = data["title"] as? String else { return nil }
        
        self.init()
        
        self.imageName = imageName
        self.title = title
    }
    
    static func modelToData(category: FoodCategory) -> [String: Any] {
        
        let data: [String: Any] = [
            "imageName" : category.imageName!,
            "title" : category.title ]
        return data
    }
}
