//
//  HomeViewController.swift
//  Fasher
//
//  Created by Zekeriya Semih Güler on 11.01.2020.
//  Copyright © 2020 Zekeriya Semih Güler. All rights reserved.
//

import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController, UITabBarControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: Variables
    var previousIndex = 0
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // current user
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            let value = snapshot.value as? NSDictionary
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        // all users
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex != 2 {
            previousIndex = tabBarController.selectedIndex
        } else {
            tabBarController.selectedIndex = previousIndex
            showAlertSheet()
        }
    }
    
    private func showAlertSheet() {
        let alertController = UIAlertController(title: "Upload Photo", message: "Select place", preferredStyle: .actionSheet)
        let importImage = UIAlertAction(title: "Import Image", style: .default, handler: { action in
            self.importImageGallery()
        })
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.importFromCamera()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(importImage)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func importFromCamera() {
        let image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.camera
        image.allowsEditing = false
        
        self.present(image, animated: true)
    }
    
    private func uploadImageFile(_ image: UIImage) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let date = Date()
        let imageName = "image\(date).jpg"
        let imageRef = storageRef.child("images/\(imageName)")
        
        imageRef.putData((image.pngData())!)
    }
    
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.camera
        image.allowsEditing = false
        
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // myImageView.image = image
            uploadImageFile(image)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func importImageGallery() {
        
        let image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true)
    }
    
    func imagePickerGaleryController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // myImageView.image = image
            uploadImageFile(image)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

