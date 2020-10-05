//
//  User.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 28/09/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation

struct User {
    
    var email: String
    
    init(email: String = "") {
        
        self.email = email
    }
    
    init(data: [String: Any]) {
        
        email = data["email"] as? String ?? ""
    }
    
    static func modelToData(user: User) -> [String: Any] {
        
        let data: [String: Any] = [ "email": user.email ]
        return data
    }
}
