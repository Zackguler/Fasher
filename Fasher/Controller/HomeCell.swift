//
//  HomeCell.swift
//  Fasher
//
//  Created by Zekeriya Semih Güler on 01/06/20.
//  Copyright © 2020 Zekeriya Semih Güler. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

	@IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

		profileImageView.layer.borderWidth = 1.0
		profileImageView.layer.masksToBounds = false
		profileImageView.layer.borderColor = UIColor.white.cgColor
		profileImageView.layer.cornerRadius = profileImageView.layer.frame.size.width / 2
		profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
