//
//  SearchViewController.swift
//  Fasher
//
//  Created by Hüseyin İyibaş on 17.05.2020.
//  Copyright © 2020 Hüseyin İyibaş. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var dataSource = [String]()
    var keyword = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        keyword = searchTextField.text ?? ""
        searchByKeyword(keyword)
    }
    
    private func searchByKeyword(_ keyword: String) {
        dataSource = [String]()
        ref = Database.database().reference()
        ref.child("users").queryOrdered(byChild: "email").queryStarting(atValue: "\(keyword)").queryEnding(atValue: "\(keyword)" + "\u{f8ff}").observeSingleEvent(of: .value, with: { snapshot in
            if let result = snapshot.value as? [String: [String: String]] {
                for user in result {
                    if let firstName = user.value["firstName"], let lastName = user.value["lastName"] {
                        let data = "\(firstName) \(lastName)"
                        self.dataSource.append(data)
                        self.tableView.reloadData()
                    }
                }
            }

        })
        self.view.endEditing(true)
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.nameLabel.text = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
            DispatchQueue.main.async {
                profileViewController.userName = self.dataSource[indexPath.row]
                profileViewController.modalPresentationStyle = .popover
                profileViewController.isFollowButtonHidden = false
                self.present(profileViewController, animated: true)
            }
        }
        
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            keyword = textField.text ?? ""
        } else {
            
        }
    }
}
