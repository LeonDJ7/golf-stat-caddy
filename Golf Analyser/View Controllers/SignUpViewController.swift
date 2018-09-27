//
//  ViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 8/29/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curveBtnEdges()
        
    }
    
    func curveBtnEdges() {
        signUpBtn.layer.cornerRadius = 15
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        guard let name = nameTF.text,
        name != "",
        let email = emailTF.text,
        email != "",
        let password = passwordTF.text,
        password != "",
        let confirmPassword = confirmPasswordTF.text,
            confirmPassword != "" else {
                AlertController.showAlert(self, title: "Error", message: "Not all fields are filled out.")
                return
        }
        
        guard password.count >= 6 else {
            AlertController.showAlert(self, title: "Error", message: "Password must be at least 6 characters.")
            return
        }
        
        guard password == confirmPassword else {
            AlertController.showAlert(self, title: "Error", message: "Password and confirm password fields are not the same.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            guard error == nil else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            
            let changeRequest = user?.user.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges(completion: { (error) in
                guard error == nil else {
                    AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: "signUpSegue", sender: self)
            })
        }
    }
}

