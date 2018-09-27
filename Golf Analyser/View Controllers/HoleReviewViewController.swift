//
//  HoleReviewViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 8/31/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase

class HoleReviewViewController: UIViewController {
    
    @IBOutlet weak var par5Btn: UIButton!
    @IBOutlet weak var par4Btn: UIButton!
    @IBOutlet weak var par3Btn: UIButton!
    @IBOutlet weak var holeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        par3Btn.layer.cornerRadius = 5
        par4Btn.layer.cornerRadius = 5
        par5Btn.layer.cornerRadius = 5
        setHoleLbl()
        
    }
    
    func setHoleLbl() {
        let holeNumber = UserDefaults.standard.integer(forKey: "specificHole")
        self.holeLbl.text = "Hole \(holeNumber)"
    }
    
    @IBAction func parThreeBtnTapped(_ sender: Any) {
        
        loadedQuestion = "Was your tee shot on the green?"
        UserDefaults.standard.set("3", forKey: "par")
        
        performSegue(withIdentifier: "toHoleReviewData", sender: self)
        
    }
    
    @IBAction func parFourBtnTapped(_ sender: Any) {
        
        loadedQuestion = "Was your drive in the fairway?"
        UserDefaults.standard.set("4", forKey: "par")
        
        performSegue(withIdentifier: "toHoleReviewData", sender: self)
    }
    @IBAction func parFiveBtnTapped(_ sender: Any) {
        
        loadedQuestion = "Was your drive in the fairway?"
        UserDefaults.standard.set("5", forKey: "par")
        
        performSegue(withIdentifier: "toHoleReviewData", sender: self)
        
    }
    
    @IBAction func unwindToReviewHoleTypeVC(_ sender: UIStoryboardSegue) {}
    
}
