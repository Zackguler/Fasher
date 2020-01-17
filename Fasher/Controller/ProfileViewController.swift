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
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setDelegates()

    }

}

extension ProfileViewController {
    
    private func setView() {
        addFacebookButton()
        setProfilePicture()
        setDisplayName()
    }
    
    private func setDelegates() {
        
    }
}

extension ProfileViewController {
    
    private func addFacebookButton() {
        let size = CGRect(x: 60, y: 645, width: 300, height: 38)
        let loginButton = FBLoginButton(frame: size, permissions: [.publicProfile])
        loginButton.delegate = self
        
        view.addSubview(loginButton)
    }
    
    private func setProfilePicture() {
        if let imageURL = Auth.auth().currentUser?.photoURL {
            let imageData = try! Data(contentsOf: imageURL)
            profileImageView.image = UIImage(data: imageData)
        }
    }
    
    private func setDisplayName() {
        if let displayName = Auth.auth().currentUser?.displayName {
            displayNameLabel.text = displayName
        }
    }
    
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
