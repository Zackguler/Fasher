//
//  ProfileViewController.swift
//  Fasher
//
//  Created by Zekeriya Semih Güler on 11.01.2020.
//  Copyright © 2020 Zekeriya Semih Güler. All rights reserved.
//

import Firebase
import Kingfisher
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var followButton: UIButton!
    
    var ref: DatabaseReference!
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
           
        } catch let signOutError{
            print(signOutError)
        }
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MainVC")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    var userUploads: [StorageReference?] = []
    var userName = ""
    var isFollowButtonHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        ref = Database.database().reference()
        if !userName.isEmpty {
            displayNameLabel.text = userName
        }
        followButton.isHidden = isFollowButtonHidden
    }

    @IBAction func followButtonTapped(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        // TODO: self.ref.child("users/\(uid)/followed/test").setValue("true")
    }
}


extension ProfileViewController {
    
    private func setView() {
        setProfilePicture()
        setDisplayName()
    }
}

extension ProfileViewController {
    
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

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userUploads.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserUploadCell.ReuseIdentifier, for: indexPath) as? UserUploadCell {
            let storageRef = userUploads[indexPath.row]
            storageRef?.downloadURL { url, error in
                if let error = error {
                    print("error", error)
                } else {
                    if let url = url {
                        cell.setCell(url)
                    }
                    
                    
                }
            }
            
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
}

extension ProfileViewController: UICollectionViewDelegate {
    
}
