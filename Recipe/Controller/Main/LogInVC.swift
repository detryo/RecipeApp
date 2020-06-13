//
//  LogInVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 19/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import Firebase

class LogInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text else {
            let controller = UIAlertController(title: "", message: "Invalid Email", preferredStyle: .alert)
            let alert = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            controller.addAction(alert)
            present(controller, animated: true, completion: nil)
            return
        }
        
        guard let pass = passwordTextField.text else {
            let controller = UIAlertController(title: "", message: "Invalid password", preferredStyle: .alert)
            let alert = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            controller.addAction(alert)
            present(controller, animated: true, completion: nil)
            return
        }
        
        
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
             
            if error != nil {
                print(error!)
            } else {
                
                self.performSegue(withIdentifier: Segue.fromLoginToCategory, sender: self)
            }
        }
    }
}

extension LogInVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
        self.topConstraint.constant = CGFloat(180)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.topConstraint.constant = CGFloat(180)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.topConstraint.constant = CGFloat(180)
        textField.resignFirstResponder()
        return true
    }
}
