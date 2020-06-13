//
//  RegisterVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 19/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmedPassword: UITextField!
    @IBOutlet weak var conditionSwitch: UISwitch!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        guard conditionSwitch.isOn else {
            
            let controller = UIAlertController(title: "", message: "You have not accept the termns", preferredStyle: .alert)
            let alert = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            controller.addAction(alert)
            present(controller, animated: true, completion: nil)
            return
        }
        
        guard passwordTextField.text == confirmedPassword.text else {
            
            let controller = UIAlertController(title: "", message: "Your password does't match", preferredStyle: .alert)
            let alert = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            controller.addAction(alert)
            present(controller, animated: true, completion: nil)
            return
        }
        
        guard let email = emailTextField.text, let pass = passwordTextField.text else { return }
        
        
        
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                
                self.performSegue(withIdentifier: Segue.fromRegisterToCategory, sender: self)
            }
        }
    }
}

extension RegisterVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.navigationController?.navigationBar.isHidden = true
        self.topConstraint.constant = CGFloat(0)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.topConstraint.constant = CGFloat(40)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.navigationController?.navigationBar.isHidden = false
        self.topConstraint.constant = CGFloat(60)
        textField.resignFirstResponder()
        return true
    }
}
