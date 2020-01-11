//
//  ProfileViewController.swift
//  Fasher
//
//  Created by Hüseyin İyibaş on 11.01.2020.
//  Copyright © 2020 Hüseyin İyibaş. All rights reserved.
//

import FacebookLogin
import Firebase
import UIKit

class ProfileViewController: UIViewController {

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

extension ProfileViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("logged")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("profileview logout")
        do {
            try Auth.auth().signOut()
            print("profileview show login")
            performSegue(withIdentifier: "showLogin", sender: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    
}
