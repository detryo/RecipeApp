//
//  UserRef.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 28/09/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct UserReference {
    
    var recipeTitle: String
    
    init(recipeTitle : String) {
        
        self.recipeTitle = recipeTitle
    }
    
    init(data : [String : Any ] ) {
        
        self.recipeTitle = data["recipeTitle"] as? String ?? ""
    }
    
    static func modelToData(userRef : UserReference) -> [String : Any] {
        
        let data : [String : Any] = [
            "recipeTitle" : userRef.recipeTitle ]
        
        return data
    }
}

extension UserReference : Equatable {
    
    static func ==(lhs: UserReference, rhs: UserReference) -> Bool {
        
        return lhs.recipeTitle == rhs.recipeTitle
    }
}
