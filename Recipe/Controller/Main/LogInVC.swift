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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        
        let forgotPasswordVC = ForgotPasswordVC()
        forgotPasswordVC.modalTransitionStyle = .crossDissolve
        forgotPasswordVC.modalPresentationStyle = .overCurrentContext
        present(forgotPasswordVC, animated: true, completion: nil)
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, email.isNotEmpty,
              let pass = passwordTextField.text, pass.isNotEmpty else {
                simpleAlert(title: "Error", message: "Please fill out all fields")
                return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, viewController: self)
                self.activityIndicator.stopAnimating()
                return
            } else {
                self.activityIndicator.stopAnimating()
                self.dismiss(animated: true, completion: nil)
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
