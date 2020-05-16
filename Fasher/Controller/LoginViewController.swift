//
//  LoginViewController.swift
//  Fasher
//
//  Created by Zekeriya Semih Güler on 11.01.2020.
//  Copyright © 2020 Zekeriya Semih Güler. All rights reserved.
//

import Firebase
import UIKit

class LoginViewController: UIViewController {
    // MARK: IBOUTLET
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: IBACTION
    @IBAction func loginButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        homeViewController.modalPresentationStyle = .overFullScreen
        self.present(homeViewController, animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // MARK: Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
