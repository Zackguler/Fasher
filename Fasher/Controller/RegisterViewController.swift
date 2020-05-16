//
//  RegisterViewController.swift
//  Fasher
//
//  Created by Hüseyin İyibaş on 9.05.2020.
//  Copyright © 2020 Hüseyin İyibaş. All rights reserved.
//

import Firebase
import UIKit

class RegisterViewController: UIViewController {
    // MARK: IBOUTLET
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextView!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet weak var informationLabel: UILabel!
    
    // MARK: IBACTION
    @IBAction func registerButtonTapped(_ sender: Any) {
        if passwordTextField.text != retypePasswordTextField.text {
            showAlert(alert: "Passwords are not same")
        } else {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
                return
            }

            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

                if authResult != nil {
                    self.informationLabel.isHidden = false
                    self.informationLabel.text = "Registration is successful!"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    guard let error = error else { return }
                    self.showAlert(alert: "\(error.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Variables

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    private func showAlert(alert: String) {
        let alertAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        let alertController = UIAlertController(title: "Alert", message: "\(alert)", preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}
