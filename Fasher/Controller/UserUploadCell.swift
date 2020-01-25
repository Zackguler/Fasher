//
//  UserUploadCell.swift
//  Fasher
//
//  Created by Zekeriya Semih Güler on 25.01.2020.
//  Copyright © 2020 Zekeriya Semih Güler. All rights reserved.
//

import Kingfisher
import UIKit

class UserUploadCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    public static let ReuseIdentifier = "UserUploadCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setCell(_ url: URL?) {
        guard let imageLink = url else { return }
        self.imageView.kf.setImage(with: imageLink)
    }
    
}
