//
//  NotificationViewController.swift
//  Fasher
//
//  Created by Zekeriya Semih Güler on 17.05.2020.
//  Copyright © 2020 Zekeriya Semih Güler. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
    }

}

extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let notificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as? NotificationCell {
			notificationCell.selectionStyle = .none
			notificationCell.layoutIfNeeded()

			return notificationCell
		}

		return UITableViewCell()
	}

	
}
