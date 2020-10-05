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
    
    var name: String
    var id: String
    
    init(name : String, id : String) {
        
        self.name = name
        self.id = id
    }
    
    init(data : [String : Any ] ) {
        
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
    }
    
    static func modelToData(userRef : UserReference) -> [String : Any] {
        
        let data : [String : Any] = [
            "name" : userRef.name,
            "id" : userRef.id ]
        
        return data
    }
}
