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
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPassText: UITextField!
    @IBOutlet weak var conditionSwitch: UISwitch!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var passCheckImage: UIImageView!
    @IBOutlet weak var conformPassCheckImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPassText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            
            guard let passText = passwordText.text else { return }
            
            //if we have started typing in the confirm pass text field
            if textField == confirmPassText {
                passCheckImage.isHidden = false
                conformPassCheckImage.isHidden = false
            } else {
                // clear text field
                if passText.isEmpty {
                    passCheckImage.isHidden = true
                    conformPassCheckImage.isHidden = true
                    confirmPassText.text = ""
                }
            }
            
           // Make it so when the password match, the checkmarks turn green
            if passwordText.text == confirmPassText.text {
                passCheckImage.image = UIImage(named: AppImages.greenCheck)
                conformPassCheckImage.image = UIImage(named: AppImages.greenCheck)
            } else {
                passCheckImage.image = UIImage(named: AppImages.redCheck)
                conformPassCheckImage.image = UIImage(named: AppImages.redCheck)
            }
        }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text, email.isNotEmpty,
            let password = passwordText.text, password.isNotEmpty else {
                simpleAlert(title: "Error", message: "Please fill out all fields")
                return
        }
        
        guard let confirmPass = confirmPassText.text, confirmPass == password else {
            simpleAlert(title: "Error", message: "Password do not match")
            return
        }
        
        guard conditionSwitch.isOn else {
            simpleAlert(title: "Error", message: "You have not accept the termns")
            return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, viewController: self)
                self.activityIndicator.stopAnimating()
                return
            } else {
                
                //guard let fireUser = result?.user else { return }
                let artUser = User.init(email: email)
                
                // Upload to firestore
                self.createFireStoreUser(user: artUser)
                
                self.performSegue(withIdentifier: Segue.fromRegisterToCategory, sender: self)
            }
        }
    }
    
    func createFireStoreUser(user: User) {
        
        // Step 1: Create document reference
        let newUserRef = Firestore.firestore().collection("users").document(user.email)
        
        // Step 2: Create model data
        let data = User.modelToData(user: user)
        
        // Step 3: Upload to Firestore
        newUserRef.setData(data) { (error) in
            
            if let error = error {
                
                Auth.auth().handleFireAuthError(error: error, viewController: self)
                debugPrint("Unable to upload new user document \(error.localizedDescription)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            self.activityIndicator.stopAnimating()
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
