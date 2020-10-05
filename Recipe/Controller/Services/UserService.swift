//
//  UserService.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 28/07/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let UserService = _UserService()

final class _UserService {
    
    var user = User()
    var favorites = [Recipe]()
    let auth = Auth.auth()
    let database = Firestore.firestore()
    var userListener: ListenerRegistration? = nil
    var favoriteListener: ListenerRegistration? = nil
    
    func getCurrentUser() {
        
        guard let authUser = auth.currentUser else { return }
        let userRef = database.collection("users").document(authUser.uid)
        
        userListener = userRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            guard let data = snap?.data() else { return }
            self.user = User.init(data: data)
            print("\(self.user)")
            debugPrint(self.user)
        })
        
        let faveRef = userRef.collection("favorites")
        
        favoriteListener = faveRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
                let favorite = Recipe.init(data: document.data())
                self.favorites.append(favorite!)
            })
        })
    }
    
    func favoriteSelected(recipe: Recipe) {
        // user.mail es lo que falla, si se borra, funciona
        let favsRef = Firestore.firestore().collection("users").document(user.email).collection("favorites")

        if favorites.contains(recipe) {
            // remove favorite
            favorites.removeAll{ $0 == recipe }
            favsRef.document(recipe.recipeTitle).delete()
        } else {
            // Add as a favorite
            favorites.append(recipe)
            let data = Recipe.modelToData(recipe: recipe)
            favsRef.document(recipe.recipeTitle).setData(data)
        }
    }
}

// estudiar inheritance
// estudiar primary keys


//import RealmSwift

//let userService = _UserService()
//
//final class _UserService {
//
//    var favorites = [Recipe]()
//    var realm = try! Realm()
//
//    func favoriteSelected(recipe: Recipe) {
//
//        if favorites.contains(recipe){
//            // we remove favorites
//            favorites.removeAll { $0 == recipe }
//
//        } else {
//            // Add as a favorite
//            favorites.append(recipe)
//
//            do {
//                try realm.write({
//                    realm.add(recipe)
//                })
//            } catch {
//                debugPrint(error.localizedDescription)
//            }
//        }
//    }
//}
