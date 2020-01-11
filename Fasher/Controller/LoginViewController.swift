//
//  LoginViewController.swift
//  Fasher
//
//  Created by Hüseyin İyibaş on 11.01.2020.
//  Copyright © 2020 Hüseyin İyibaş. All rights reserved.
//

import FacebookLogin
import Firebase
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let size = CGRect(x: 38, y: 397, width: 300, height: 38)
        let loginButton = FBLoginButton(frame: size, permissions: [.publicProfile])
        loginButton.delegate = self
        
        view.addSubview(loginButton)
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("login")
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Errorrr", error)
                return
            }
            print(authResult?.user.displayName)
            
            self.dismiss(animated: true, completion: nil)
        }
        print("finish")
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("erorrrr", signOutError)
        }
            
    }
}


