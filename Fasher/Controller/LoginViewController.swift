//
//  LoginViewController.swift
//  Fasher
//
//  Created by Hüseyin İyibaş on 11.01.2020.
//  Copyright © 2020 Hüseyin İyibaş. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let userLogged = false
        
        if !userLogged {
            DispatchQueue.main.async {
                let loginViewController = LoginViewController()
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }
            return
        }
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
