//
//  LoginViewController.swift
//  Fasher
//
//  Created by Zekeriya Semih Güler on 11.01.2020.
//  Copyright © 2020 Zekeriya Semih Güler. All rights reserved.
//

import Firebase
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
  
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    func setUpElements() {
        //Hide error label
        errorLabel.alpha = 0
        //Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        //TODO: Registerda olan kısım buraya uyarlanıcak
        
        //Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        UserDefaults.standard.set("\(email)", forKey: "email")
        UserDefaults.standard.set("\(password)", forKey: "password")
        //signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (resukt, error) in
            if error != nil {
                //Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                
            } else {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                homeViewController.modalPresentationStyle = .overFullScreen
                self.present(homeViewController, animated: true)
            }
        }
    }
}
