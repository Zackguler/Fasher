//
//  ViewController.swift
//  Fasher
//
//  Created by Semih Güler on 17.05.2020.
//  Copyright © 2020 Hüseyin İyibaş. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            return
        }
        
        guard let password = UserDefaults.standard.string(forKey: "password") else {
            return
        }
        
        if !email.isEmpty && !password.isEmpty {
            Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "email")!, password: UserDefaults.standard.string(forKey: "password")!) { (result, error) in
                if error != nil {
                    //Couldn't sign in
                    
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                    homeViewController.modalPresentationStyle = .overFullScreen
                    self.present(homeViewController, animated: true)
                }
            }
        }
    }
}
