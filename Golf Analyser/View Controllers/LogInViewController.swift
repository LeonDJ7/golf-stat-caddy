//
//  LogInViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 8/29/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        curveBtnEdges()
        
    }
    
    func curveBtnEdges() {
        logInBtn.layer.cornerRadius = 15
        forgotPasswordBtn.layer.cornerRadius = 15
    }

    @IBAction func logInBtnTapped(_ sender: Any) {
        
        guard let password = passwordTF.text,
            password != "",
            let email = emailTF.text,
            email != "" else {
                AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all required fields")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard user?.user.uid != nil else {
                AlertController.showAlert(self, title: "Error", message: "User does not exist")
                return
            }
            self.performSegue(withIdentifier: "logInSegue", sender: nil)
        }
    }
    
    @IBAction func unwindToLogIn(_ sender: UIStoryboardSegue) {}
    
}
