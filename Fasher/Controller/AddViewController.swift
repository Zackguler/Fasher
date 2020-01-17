//
//  AddViewController.swift
//  Fasher
//
//  Created by Hüseyin İyibaş on 11.01.2020.
//  Copyright © 2020 Hüseyin İyibaş. All rights reserved.
//

import FirebaseDatabase
import FirebaseStorage
import UIKit

class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseTest()
    }
    
    private func databaseTest() {
        print("Database test")
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.setValue(["username": "test"])
    }
    
    private func uploadImageFile(_ image: UIImage) {
        print("Storage test")

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
            myImageView.image = image
            uploadImageFile(image)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    


}
