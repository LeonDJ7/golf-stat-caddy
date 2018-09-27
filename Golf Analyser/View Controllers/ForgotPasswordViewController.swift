//
//  ForgotPasswordViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 8/29/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var recoverPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        curveEdges()
        
    }
    
    func curveEdges() {
        recoverPasswordBtn.layer.cornerRadius = 15
    }
    
    @IBAction func recoverPasswordTapped(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: (emailTF.text)!) { (error) in
            if error != nil {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
            } else {
                AlertController.showAlert(self, title: "Success", message: "Check your email")
                self.emailTF.text = ""
            }
        }
    }
}
