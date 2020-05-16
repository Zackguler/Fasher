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
    
    var userUploads: [StorageReference?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setDelegates()
        
        let storage = Storage.storage()
        let storageRef = storage.reference().child("images")
        storageRef.listAll { (result, error) in
            if let error = error {
                print("error", error)
            }
            for prefix in result.prefixes {
                print("prefix", prefix)
            }
            for item in result.items {
                print("item", item)
                self.userUploads.append(item)
                self.collectionView.reloadData()
            }
        }
        print("uuid", Auth.auth().currentUser?.uid)
    }

}

extension ProfileViewController {
    
    private func setView() {
        setProfilePicture()
        setDisplayName()
        setCollectionViewLayout()
    }
    
    private func setDelegates() {
        self.collectionView.register(UINib(nibName: UserUploadCell.ReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: UserUploadCell.ReuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
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
    
    private func setCollectionViewLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(userUploads.count)
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
                        print("urlll", url)
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
