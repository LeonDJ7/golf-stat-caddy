//
//  EighteenOrNineViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 9/5/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase

var isOkToConfirm = false

class EighteenOrNineViewController: UIViewController {
    
    @IBOutlet weak var questionMarkBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tellUserAboutLastRound == true {
            questionMarkBtn.isHidden = false
        }
    }

    @IBAction func questionMarkBtnTapped(_ sender: Any) {
        
        presentAlert()
        
    }
    func presentAlert() {
        AlertController.showAlert(self, title: "", message: "This is referring to your last round. You were at 9 holes but I'm unsure whether you were done or planning on doing 18.")
    }
    
    @IBAction func nineHolesTapped(_ sender: Any) {
        tellUserAboutLastRound = false
        createAlertOne(title: "Just Checking", message: "Are you sure you're doing 9 holes?")
    }
    
    @IBAction func eighteenHolesTapped(_ sender: Any) {
        tellUserAboutLastRound = false
        createAlertTwo(title: "Just Checking", message: "Are you sure you're doing 18 holes?")
    }
    
    func createAlertOne(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            isOkToConfirm = true
            
            self.performSegue(withIdentifier: "toConfirmAfterNine", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlertTwo(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "returnHomeIfEighteenSegue", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
