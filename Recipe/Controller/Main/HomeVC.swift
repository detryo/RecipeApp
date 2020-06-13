//
//  ViewController.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 19/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    @IBOutlet weak var registerButton: CustomButton!
    @IBOutlet weak var logInButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: Segue.fromHomeToCategory, sender: self)
        }
        setUpButton()
    }

    func setUpButton() {
        logInButton.makeBacgroundWhiteWithBorder()
    }
}
